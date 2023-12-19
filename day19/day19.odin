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

Xmas :: [4]int
XMAS_CHAR_MAP := [26]int {
    'x' - 'a' = 0,
    'm' - 'a' = 1,
    'a' - 'a' = 2,
    's' - 'a' = 3,
}

Op :: enum {
    None,
    Compare_Lt,
    Compare_Gt,
    Goto,
    R,
    A,
}

Instr :: struct {
    op: Op,
    xmas_value, operand: int,
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
                xmas[idx] = xmas[idx] * 10 + int(xmas_str[i] - '0')
                i += 1
            }
            idx += 1
        }

        if run_workflows(workflows, xmas) {
            result += math.sum(xmas[:])
        }
    }

    return

}

part_2 :: proc(data: string) -> (result: int) {

    return 0
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
                    instr.operand = instr.operand * 10 + int(line[idx] - '0')
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
                        instr.operand = instr.operand << 5 + int(line[idx] - 'a' + 1)
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
                        instr.operand = instr.operand << 5 + int(line[idx] - 'a' + 1)
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

main :: proc() {
    arena_backing := make([]u8, 8 * mem.Megabyte)
    solution_arena: mem.Arena
    mem.arena_init(&solution_arena, arena_backing)

    alloc := mem.arena_allocator(&solution_arena)
    context.allocator = alloc
    context.temp_allocator = alloc

    pt1_start := time.now()
    pt1_ans := part_1(input)
    pt1_end := time.now()
    fmt.println("P1:", pt1_ans, "Time:", time.diff(pt1_start, pt1_end), "Memory Used:", solution_arena.peak_used)

    free_all(context.allocator)
    solution_arena.peak_used = 0

    pt2_start := time.now()
    pt2_ans := part_2(input)
    pt2_end := time.now()
    fmt.println("P2:", pt2_ans, "Time:", time.diff(pt2_start, pt2_end), "Memory Used:", solution_arena.peak_used)

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
