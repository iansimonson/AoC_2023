package day19

import "core:fmt"
import "core:math"
import "core:mem"
import "core:os"
import "core:slice"
import "core:strconv"
import "core:strings"
import "core:testing"
import "core:time"
import q "core:container/queue"

Xmas :: [4]u16
XMAS_CHAR_MAP := [26]u8 {
    'x' - 'a' = 0,
    'm' - 'a' = 1,
    'a' - 'a' = 2,
    's' - 'a' = 3,
}

Op :: enum u8 {
    None,
    Compare_Lt,
    Compare_Gt,
    Goto,
    R,
    A,
}

Instr :: struct {
    op: Op,
    xmas_value: u8,
    operand: u16,
}

Workflow :: [8]Instr

MaxLetterVal :: ('z' - 'a' + 1)
MaxLabel :: MaxLetterVal << 10 | MaxLetterVal << 5 | MaxLetterVal
IN: u16 = ('i' - 'a' + 1) << 5 | ('n' - 'a' + 1)

@(disabled = !(ODIN_DEBUG || ODIN_TEST))
debug_print :: proc(args: ..any) {
    fmt.println(..args)
}


part_1 :: proc(data: string) -> (result: int) {
    data := data
    
    workflows: map[u16]Workflow
    parse_workflows(&data, &workflows)
    debug_print(workflows[IN])

    for xmas_str in strings.split_lines_iterator(&data) {
        if len(xmas_str) == 0 do continue
        xmas: Xmas
        idx: int
        str_len := len(xmas_str)
        for i := 0; idx < len(Xmas); {
            for xmas_str[i] != '=' do i += 1
            i += 1
            for xmas_str[i] != ',' && xmas_str[i] != '}' {
                xmas[idx] = xmas[idx] * 10 + u16(xmas_str[i] - '0')
                i += 1
            }
            idx += 1
        }

        if run_workflows(workflows, xmas) {
            result += int(math.sum(xmas[:]))
        }
    }

    return

}

part_2 :: proc(data: string) -> (result: int) {
    data := data
    
    workflows: map[u16]Workflow
    parse_workflows(&data, &workflows)
    debug_print(workflows[IN])

    return run_theoretical_workflows(workflows)
}

// qs{s>3448:A,lnx} e.g.
parse_workflows :: proc(data: ^string, workflow_map: ^map[u16]Workflow) {
    for line in strings.split_lines_iterator(data) {
        if len(line) == 0 do return

        line_len := len(line)
        debug_print(line)

        // parse label
        label: u16
        idx: int
        for line[idx] != '{' {
            label = label << 5 + u16(line[idx] - 'a' + 1)
            idx += 1
        }
        idx += 1
        debug_print(label)

        if label == IN {
            debug_print("YAY HERE:", line)
        }

        // ALWAYS a condition except the last rule
        if label not_in workflow_map {
            workflow_map[label] = {}
        }
        workflow := &workflow_map[label]
        workflow_idx: int

        // parse workflow
        for {
            if idx >= line_len do break
            if line[idx] == '}' do break

            next_char := line[idx + 1]
            switch next_char {
            case '>', '<': // maybe_parse condition
                instr := &workflow[workflow_idx]
                instr.op = .Compare_Gt if next_char == '>' else .Compare_Lt
                instr.xmas_value = XMAS_CHAR_MAP[line[idx] - 'a']
                
                // parse operand
                idx += 2
                for ;line[idx] != ':'; idx += 1 {
                    instr.operand = instr.operand * 10 + u16(line[idx] - '0')
                }

                // parse _then_
                idx += 1
                workflow_idx += 1
                instr = &workflow[workflow_idx]
                if line[idx] == 'A' {
                    instr.op = .A
                    idx += 1
                } else if line[idx] == 'R' {
                    instr.op = .R
                    idx += 1
                } else {
                    instr.op = .Goto
                    for ;line[idx] != ','; idx += 1 {
                        instr.operand = instr.operand << 5 + u16(line[idx] - 'a' + 1)
                    }
                }
                workflow_idx += 1
                idx += 1
            case:
                instr := &workflow[workflow_idx]
                switch line[idx] {
                case 'R':
                    instr.op = .R
                    idx += 1
                case 'A':
                    instr.op = .A
                    idx += 1
                case:
                    instr.op = .Goto
                    for ;line[idx] != ',' && line[idx] != '}'; idx += 1 {
                        instr.operand = instr.operand << 5 + u16(line[idx] - 'a' + 1)
                    }
                }
                assert(line[idx] == ',' || line[idx] == '}')
                workflow_idx += 1
                idx += 1
            }
        }


    }
}

run_workflows :: proc(workflows: map[u16]Workflow, xmas: Xmas) -> bool {
    cur_flow := u16(IN)
    outer: for {
        workflow := &workflows[cur_flow]
        instr_idx := 0
        debug_print(workflow)
        for {
            instr := workflow[instr_idx]
            debug_print(instr)
            switch instr.op {
            case .R:
                return false
            case .A:
                return true
            case .Goto:
                cur_flow = u16(instr.operand)
                continue outer
            case .Compare_Lt:
                if xmas[instr.xmas_value] < instr.operand do instr_idx += 1
                else do instr_idx += 2
            case .Compare_Gt:
                if xmas[instr.xmas_value] > instr.operand do instr_idx += 1
                else do instr_idx += 2
            case .None:
                fallthrough
            case:
                panic("This shouldn't happen")
            }
        }
    }
}

Node :: struct {
    label: u16,
    ranges: [4][2]u16,
}

compute_combos :: proc(ranges: [4][2]u16) -> int {
    combos := 1
    for r in ranges {
        combos *= range_len(r)
    }
    return combos
}

range_len :: proc(r: [2]u16) -> int {
    return int(max(0, r[1] - r[0] + 1))
}

run_theoretical_workflows :: proc(workflows: map[u16]Workflow) -> int {
    queue: q.Queue(Node)
    q.push(&queue, Node{IN, [4][2]u16{{1, 4000}, {1, 4000}, {1, 4000}, {1, 4000}}})

    result: int

    outer: for q.len(queue) != 0 {
        node := q.pop_front(&queue)

        workflow := &workflows[node.label]
        ranges := node.ranges
        // debug_print(node.label, workflow)
        instr_idx: int
        for {
            instr := workflow[instr_idx]
            debug_print(node.label, instr)
            debug_print(node.label, ranges)
            switch instr.op {
            case .R:
                continue outer
            case .A:
                debug_print("Adding combos for:", ranges)
                // add_all_ranges(xmas_ranges[:], ranges[:])
                result += compute_combos(ranges)
                continue outer
            case .Goto:
                q.push_back(&queue, Node{u16(instr.operand), ranges})
                continue outer
            case .Compare_Lt:
                if instr.operand <= node.ranges[instr.xmas_value][0] {
                    // range is now zero size, continue
                    continue outer
                } else {
                    // we either have everything, or a subset in the LT case
                    then_instr := workflow[instr_idx + 1]
                    new_ranges := ranges
                    new_ranges[instr.xmas_value][1] = min(ranges[instr.xmas_value][1], instr.operand - 1)
                    remaining_range := [2]u16{instr.operand, ranges[instr.xmas_value][1]}
                    debug_print("CUT AT LT - new range:", new_ranges)
                    debug_print("remaining_range", remaining_range)
                    debug_print("THEN:", then_instr)
                    #partial switch then_instr.op {
                    case .R:
                        // nothing
                    case .A:
                        debug_print("Adding combos for:", ranges)
                        // add_all_ranges(xmas_ranges[:], new_ranges[:])
                        result += compute_combos(new_ranges)
                    case .Goto:
                        q.push_back(&queue, Node{u16(then_instr.operand), new_ranges})
                    case:
                        panic("not possible")
                    }
                    instr_idx += 2
                    if range_len(remaining_range) == 0 do continue outer
                    ranges[instr.xmas_value] = remaining_range
                }
            case .Compare_Gt:
                if instr.operand >= node.ranges[instr.xmas_value][1] {
                    instr_idx += 2
                } else {
                    then_instr := workflow[instr_idx + 1]
                    new_ranges := ranges
                    new_ranges[instr.xmas_value][0] = max(ranges[instr.xmas_value][0], instr.operand + 1)
                    remaining_range := [2]u16{ranges[instr.xmas_value][0], instr.operand}
                    debug_print("CUT AT GT - new range:", new_ranges)
                    debug_print("remaining_range", remaining_range)
                    debug_print("THEN:", then_instr)
                    #partial switch then_instr.op {
                    case .R:
                        // nothing
                    case .A:
                        debug_print("Adding combos for:", new_ranges)
                        // add_all_ranges(xmas_ranges[:], new_ranges[:])
                        result += compute_combos(new_ranges)
                    case .Goto:
                        q.push_back(&queue, Node{u16(then_instr.operand), new_ranges})
                    case:
                        panic("not possible")
                    }
                    instr_idx += 2
                    if range_len(remaining_range) == 0 do continue outer
                    ranges[instr.xmas_value] = remaining_range
                }
            case .None:
                fallthrough
            case:
                panic("This shouldn't happen")
            }
        }
    }
    return result
}

main :: proc() {
    arena_backing := make([]u8, 8 * mem.Megabyte)
    solution_arena: mem.Arena
    mem.arena_init(&solution_arena, arena_backing)

    alloc := mem.arena_allocator(&solution_arena)
    context.allocator = alloc
    context.temp_allocator = alloc

    when AVG_RUNTIME {
        iters := 10_000
    } else {
        iters := 1
    }

    pt1_ans: int
    pt1_total_time: time.Duration
    for i in 0..<iters {
        pt1_start := time.now()
        pt1_ans = part_1(input)
        pt1_end := time.now()
        pt1_total_time += time.diff(pt1_start, pt1_end)
        free_all(context.allocator)
    }

    fmt.println("P1:", pt1_ans, "Time:", pt1_total_time / time.Duration(iters), "Memory Used:", solution_arena.peak_used)

    free_all(context.allocator)
    solution_arena.peak_used = 0

    pt2_ans: int
    pt2_total_time: time.Duration
    for i in 0..<iters {
        pt2_start := time.now()
        pt2_ans = part_2(input)
        pt2_end := time.now()
        pt2_total_time += time.diff(pt2_start, pt2_end)
        free_all(context.allocator)
    }
    fmt.println("P2:", pt2_ans, "Time:", pt2_total_time / time.Duration(iters), "Memory Used:", solution_arena.peak_used)

    free_all(context.allocator)
    solution_arena.peak_used = 0
}


@(test)
part_1_test :: proc(t: ^testing.T) {
    testing.expect_value(t, part_1(test_input), 19114)
}

@(test)
part_2_test :: proc(t: ^testing.T) {
    testing.expect_value(t, part_2(test_input), 167_409_079_868_000)
}

AVG_RUNTIME :: #config(AVG, false)

input := #load("./input.txt", string)
test_input := `px{a<2006:qkq,m>2090:A,rfg}
pv{a>1716:R,A}
lnx{m>1548:A,A}
rfg{s<537:gd,x>2440:R,A}
qs{s>3448:A,lnx}
qkq{x<1416:A,crn}
crn{x>2662:A,R}
in{s<1351:px,qqz}
qqz{s>2770:qs,m<1801:hdj,R}
gd{a>3333:R,R}
hdj{m>838:A,pv}

{x=787,m=2655,a=1222,s=2876}
{x=1679,m=44,a=2067,s=496}
{x=2036,m=264,a=79,s=2244}
{x=2461,m=1339,a=466,s=291}
{x=2127,m=1623,a=2188,s=1013}`
