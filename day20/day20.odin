package day20

import "core:fmt"
import "core:math"
import "core:mem"
import "core:os"
import "core:slice"
import "core:strconv"
import "core:strings"
import "core:testing"
import "core:time"
import sa "core:container/small_array"
import q "core:container/queue"

Label :: u16
Typed_Label :: distinct u16
Last_Sent :: struct {
    label: Label,
    prev: bool,
}
TLabel_List :: sa.Small_Array(10, Typed_Label)
State_List :: sa.Small_Array(10, Last_Sent)

State :: struct {
    from: Label,
    tlabel: Typed_Label,
    pulse: bool
}

BROADCAST := Label(0x7FFF)
OUTPUT := str_to_label("ou")
RX := str_to_label("rx")

part_1 :: proc(data: string) -> int {
    adj_list, f_or_c, flip_flops, conjuncts := parse_lists(data)

    queue: q.Queue(State)

    low: int
    high: int
    for i in 0..<1000 {
        // we have to run the simulation once incorrectly
        // to connect up all the conjunctions
        low += 1 // button
        q.clear(&queue)
        q.push_back(&queue, State{BROADCAST, Typed_Label(BROADCAST), false})
        for q.len(queue) != 0 {
            state := q.pop_front(&queue)
            debug_print("HANDLING:", state)
            label := as_label(state.tlabel)
            
            if label == OUTPUT do continue
            if label not_in adj_list do continue

            is_flipflop := is_label_flipflop(state.tlabel)

            debug_print(state.tlabel, label, is_flipflop)

            signal_to_send: bool
            send_signal: bool

            if label == BROADCAST {
                send_signal = true
                signal_to_send = false
            } else if is_flipflop && !state.pulse {
                cur_state, cs_exists := flip_flops[label]
                assert(cs_exists)
                flip_flops[label] = !cur_state
                signal_to_send = !cur_state
                send_signal = true
            } else if !is_flipflop {
                send_signal = true
                from := state.from
                cur_state, cs_exists := &conjuncts[label]
                assert(cs_exists)
                cur_state_len := sa.len(cur_state^)
                idx, found := linear_search_key(cur_state.data[:cur_state_len], proc(ls: Last_Sent) -> Label {
                    return ls.label
                }, from)
                if found {
                    cur_state.data[idx].prev = state.pulse
                } else {
                    sa.append(cur_state, Last_Sent{from, state.pulse})
                    cur_state_len += 1
                }
                signal_to_send = !slice.all_of_proc(cur_state.data[:cur_state_len], proc(ls: Last_Sent) -> bool { return ls.prev})
                debug_print(cur_state.data[:cur_state_len], signal_to_send)
            }

            if send_signal {
                adjacent, exists := &adj_list[label]
                assert(exists)
                adjacent_len := sa.len(adjacent^)
                if signal_to_send {
                    debug_print(label, "sent", adjacent_len, "highs")
                    high += adjacent_len
                } else {
                    debug_print(label, "sent", adjacent_len, "lows")
                    low += adjacent_len
                }
                for tlabel in adjacent.data[:adjacent_len] {
                    q.push_back(&queue, State{label, tlabel, signal_to_send})
                }
            }
        }

    }

    debug_print(low, high)
    
    return high * low
}

State2 :: struct {
    from: Label,
    tlabel: Typed_Label,
    from_goes_low_every: int,
}

Last_Sent2 :: struct {
    label: Label,
    prev: int,
}

part_2 :: proc(data: string) -> int {
    adj_list, f_or_c, conjuncts := parse_lists_2(data)
    flip_flops: map[Label]int

    queue: q.Queue(State2)

    q.push_back(&queue, State2{BROADCAST, Typed_Label(BROADCAST), 1})
    for q.len(queue) != 0 {
        state := q.pop_front(&queue)
        debug_print("HANDLING:", state)
        label := as_label(state.tlabel)

        fmt.println(state)
        
        if label == OUTPUT do continue
        // LOL OF COURSE THIS WAS THE THING TO FIND IN PT2
        if label == RX {
            return state.from_goes_low_every
        }

        is_flipflop := is_label_flipflop(state.tlabel)
        debug_print(state.tlabel, label, is_flipflop)

        if label == BROADCAST {
            adj := adj_list[label]
            for i in 0..<sa.len(adj) {
                nxt := sa.get(adj, i)
                q.append(&queue, State2{label, nxt, 1})
            }
        } else if is_flipflop {
            adj := adj_list[label]
            flip_flops[label] = 2 * next.from_goes_low_every
            for i in 0..<sa.len(adj) {
                nxt := sa.get(adj, i)
                q.append(&queue, State2{label, nxt, 2 * next.from_goes_low_every})
            }
        } else if !is_flipflop {
            cycle_low: int
            if prev_cycle_low, cl_exists := cycle_to_low[label]; !cl_exists {
                conj := conjuncts[label]
                m_ff: int
                lcm_conjs := 1
                for i in 0..<sa.len(conj) {
                    cl := sa.get(conj, i)
                    if cl.label == BROADCAST do continue
                    fc := f_or_c[cl.label]
                    if fc {
                        m_ff = max(m_ff, (flip_flops[cl.label] or_else 2))
                    } else {
                        lcm_conjs = math.lcm(lcm_conjs, cl.prev)
                    }
                }
                ff_input_is_high := m_ff - 1
                for ff_input_is_high % lcm_conjs == 0 {
                    ff_input_is_high += m_ff
                }
                cycle_low = math.lcm(cycle_low, lcm_conjs)
                cycle_to_low[label] = cycle_low
            } else {
                cycle_low = prev_cycle_low
            }
            
            adj := adj_list[label]
            for i in 0..<sa.len(adj) {
                nxt := sa.get(adj, i)
                q.append(&queue, State2{label, nxt, cycle_low})
            }
        }
    }

    return 0
}

parse_lists :: proc(data: string) -> (adj_list: map[Label]TLabel_List, f_or_c, flip_flops: map[Label]bool, conjuncts: map[Label]State_List) {
    data := data
    adj_list = make(map[Label]TLabel_List)
    f_or_c = make(map[Label]bool)
    flip_flops = make(map[Label]bool)
    conjuncts = make(map[Label]State_List)

    adj_list[OUTPUT] = {}
    f_or_c[OUTPUT] = false

    reg_idx := 1
    for line in strings.split_lines_iterator(&data) {
        line := line
        if len(line) == 0 do continue

        switch line[0] {
        case '&':
            // conjunction
            label := str_to_label(strings.trim_space(line[1:3]))
            adj_list[label] = parse_adj_list(line)
            f_or_c[label] = false
            conjuncts[label] = {}

        case '%':
            // flip flop
            label := str_to_label(strings.trim_space(line[1:3]))
            adj_list[label] = parse_adj_list(line)
            f_or_c[label] = true
            flip_flops[label] = false
        case 'b':
            // broadcast
            adj_list[BROADCAST] = parse_adj_list(line)

        case:
            panic("Not possible")
        }
    }

    for k, &v in adj_list {
        for i in 0..<sa.len(v) {
            adj := sa.get(v, i)
            debug_print(adj)
            if fc, exists := f_or_c[Label(adj)]; !exists {
                adjlist, adjexists := adj_list[Label(adj)]
                assert(!adjexists)
            } else if fc {
                adj = adj | 0x8000
            } else {
                conj, conjexists := &conjuncts[Label(adj)]
                assert(conjexists || Label(adj) == OUTPUT)
                if conjexists {
                    if _, found := linear_search_key(conj.data[:sa.len(conj^)], proc(ls: Last_Sent) -> Label { return ls.label }, k); !found {
                        sa.append(conj, Last_Sent{k, false})
                    }
                }
            }
            sa.set(&v, i, adj)
        }
    }

    debug_print_adj_list(adj_list)
    debug_print("DONE")

    return
}

parse_lists_2 :: proc(data: string) -> (adj_list: map[Label]TLabel_List, f_or_c: map[Label]bool, conjuncts: map[Label]State_List2) {
    data := data
    adj_list = make(map[Label]TLabel_List)
    f_or_c = make(map[Label]bool)
    conjuncts = make(map[Label]State_List2)

    adj_list[OUTPUT] = {}
    f_or_c[OUTPUT] = false

    reg_idx := 1
    for line in strings.split_lines_iterator(&data) {
        line := line
        if len(line) == 0 do continue

        switch line[0] {
        case '&':
            // conjunction
            label := str_to_label(strings.trim_space(line[1:3]))
            adj_list[label] = parse_adj_list(line)
            f_or_c[label] = false
            conjuncts[label] = {}

        case '%':
            // flip flop
            label := str_to_label(strings.trim_space(line[1:3]))
            adj_list[label] = parse_adj_list(line)
            f_or_c[label] = true
        case 'b':
            // broadcast
            adj_list[BROADCAST] = parse_adj_list(line)

        case:
            panic("Not possible")
        }
    }

    for k, &v in adj_list {
        for i in 0..<sa.len(v) {
            adj := sa.get(v, i)
            debug_print(adj)
            if fc, exists := f_or_c[Label(adj)]; !exists {
                adjlist, adjexists := adj_list[Label(adj)]
                assert(!adjexists)
            } else if fc {
                adj = adj | 0x8000
            } else {
                conj, conjexists := &conjuncts[Label(adj)]
                assert(conjexists || Label(adj) == OUTPUT)
                if conjexists {
                    if _, found := linear_search_key(conj.data[:sa.len(conj^)], proc(ls: Last_Sent) -> Label { return ls.label }, k); !found {
                        sa.append(conj, Last_Sent2{k, 0})
                    }
                }
            }
            sa.set(&v, i, adj)
        }
    }

    debug_print_adj_list(adj_list)
    debug_print("DONE")

    return
}

as_label :: proc(tlabel: Typed_Label) -> Label {
    return Label(tlabel & 0x7FFF)
}

as_tlabel :: proc(label: Label, is_flipflop: bool) -> Typed_Label {
    if !is_flipflop do return Typed_Label(label)

    return Typed_Label(label | 0x8000)
}

is_label_flipflop :: proc(tlabel: Typed_Label) -> bool {
    return tlabel & 0x8000 != 0
}

parse_adj_list :: proc(line: string) -> (adjacent: TLabel_List) {
    line := line
    arrow := strings.index(line, "->")
    line = line[arrow + 3:]
    for label_str in strings.split_by_byte_iterator(&line, ',') {
        if len(label_str) == 0 do continue
        label_str := strings.trim_space(label_str)
        label := str_to_label(label_str)
        debug_print(label_str, label)
        // technically these are _not_ typed labels
        // yet but they will be after parsing
        sa.append(&adjacent, Typed_Label(label))
    }
    return
}

str_to_label :: proc(label_str: string) -> (label: Label) {
    label = u16(label_str[0] - 'a')
    if len(label_str) > 1 {
        label = label << 5 | u16(label_str[1] - 'a')
    }
    return
}

label_to_str :: proc(label: Label) -> (label_str: string) {
    buffer: [2]u8
    buffer[1] = u8(label & 0x001F) + 'a'
    label := label >> 5
    buffer[0] = u8(label & 0x001F) + 'a'
    return strings.clone(string(buffer[:]), context.temp_allocator)
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
    testing.expect_value(t, part_1(test_input), 32000000)
    testing.expect_value(t, part_1(test_input_2), 11687500)
}

// No pt2 test b/c there is no rx
// @(test)
// part_2_test :: proc(t: ^testing.T) {
//     testing.expect_value(t, part_2(test_input), 1234)
// }

@(disabled = !(ODIN_DEBUG || ODIN_TEST))
debug_print :: proc(args: ..any) {
    fmt.println(..args)
}

@(disabled = !(ODIN_DEBUG || ODIN_TEST))
debug_print_adj_list :: proc(list: map[Label]TLabel_List) {
    for k, v in list {
        fmt.println(k, sa.len(v), v.data)
    }
}

@(require_results)
linear_search_key :: proc(array: $A/[]$T, f: proc(T) -> $K, value: K) -> (index: int, found: bool) #no_bounds_check {
	for x, i in array {
		if f(x) == value {
			return i, true
		}
	}
	return -1, false
}

AVG_RUNTIME :: #config(AVG, false)

input := #load("./input.txt", string)
test_input := `broadcaster -> a, b, c
%a -> b
%b -> c
%c -> inv
&inv -> a
`

test_input_2 := `broadcaster -> a
%a -> inv, con
&inv -> b
%b -> con
&con -> output
`
