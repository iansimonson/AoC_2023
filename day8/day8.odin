package day8

import "core:fmt"
import "core:mem"
import "core:os"
import "core:strconv"
import "core:strings"
import "core:testing"
import "core:time"
import "core:math"
import ba "core:container/bit_array"

state :: proc(s: string) -> (result: u16) {
    assert(len(s) == 3)
    mask := u8(0x1F)
    result = (u16((s[0] - 'A') & mask) << 10) | (u16((s[1] - 'A') & mask) << 5) | (u16((s[2] - 'A') & mask))
    return
}

to_str :: proc(s: u16) -> [3]u8 {
    return {u8((s >> 10) & 0x1F) + 'A', u8((s >> 5) & 0x1F) + 'A', u8(s & 0x1F) + 'A'}
}

// FTX = (VVM, VVM) e.g.
parse_transition :: proc(s: string) -> [3]u16 {
    return {state(s[:3]), state(s[7:][:3]), state(s[12:][:3])}
}

part_1 :: proc(data: string) -> (count: uint) {
    data := data
    newline := strings.index_byte(data, '\n')
    instrs_str := data[:newline]
    data = data[newline + 2:]

    instr_len := uint(len(instrs_str))
    instrs, iok := ba.create(int(instr_len))
    assert(iok)

    m: [max(u16)][2]u16 = ---

    for instr, i in instrs_str {
        ba.set(instrs, uint(i), instr == 'R')
    }


    for line in strings.split_lines_iterator(&data) {
        t := parse_transition(line)
        m[t.x] = t.yz
    }

    cur_state := state("AAA")
    end_state := state("ZZZ")
    for {
        i, ok := ba.get(instrs, count % instr_len)
        assert(ok)
        cur_state = m[cur_state][int(i)]
        count += 1
        if cur_state == end_state do break
    }
    return
}

part_2 :: proc(data: string) -> uint {
    data := data
    newline := strings.index_byte(data, '\n')
    instrs_str := data[:newline]
    data = data[newline + 2:]

    instr_len := uint(len(instrs_str))
    instrs, iok := ba.create(int(instr_len))
    assert(iok)

    m: [max(u16)][2]u16 = ---

    starting_states := make([dynamic]u16, 0, 50)
    state_mask := u16(0x1F)
    A := u16(0)
    Z := u16(('Z' - 'A') & state_mask)


    for instr, i in instrs_str {
        ba.set(instrs, uint(i), instr == 'R')
    }


    for line in strings.split_lines_iterator(&data) {
        t := parse_transition(line)
        m[t.x] = t.yz
        if t.x & state_mask == A {
            append(&starting_states, t.x)
        }
    }

    steps := make([]uint, len(starting_states))
    for &s, i in starting_states {
        step: uint = 0

        for {
            i, ok := ba.get(instrs, step % instr_len)
            assert(ok)
            s = m[s][int(i)]
            step += 1
            if s & state_mask == Z do break
        }
        steps[i] = step
    }

    result := steps[0]
    for step in steps[1:] {
        result = math.lcm(result, step)
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
    testing.expect_value(t, part_1(test_input), 2)
}

@(test)
part_1_test_2 :: proc(t: ^testing.T) {
    testing.expect_value(t, part_1(test_input_2), 6)
}

@(test)
part_2_test :: proc(t: ^testing.T) {
    testing.expect_value(t, part_2(test_input_3), 6)
}

input := #load("./input.txt", string)
test_input := `RL

AAA = (BBB, CCC)
BBB = (DDD, EEE)
CCC = (ZZZ, GGG)
DDD = (DDD, DDD)
EEE = (EEE, EEE)
GGG = (GGG, GGG)
ZZZ = (ZZZ, ZZZ)`

test_input_2 := `LLR

AAA = (BBB, BBB)
BBB = (AAA, ZZZ)
ZZZ = (ZZZ, ZZZ)`

test_input_3 := `LR

11A = (11B, XXX)
11B = (XXX, 11Z)
11Z = (11B, XXX)
22A = (22B, XXX)
22B = (22C, 22C)
22C = (22Z, 22Z)
22Z = (22B, 22B)
XXX = (XXX, XXX)`