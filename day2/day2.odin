package day2

import "core:fmt"
import "core:mem"
import "core:os"
import "core:strconv"
import "core:strings"
import "core:testing"
import "core:time"

p1_limits := [3]int{12, 13, 14}

part_1 :: proc(data: string) -> int {
    data := data
    total: int
    id: int
    outer: for line in strings.split_lines_iterator(&data) {
        line := line
        id += 1
        colon := strings.index(line, ":")
        assert(colon != -1)
        line = line[colon + 2:]
        value := -1
        ok: bool
        for vc in strings.split_iterator(&line, " ") {
            if value == -1 {
                value, ok = strconv.parse_int(vc)
                assert(ok)
            } else {
                switch {
                case strings.has_prefix(vc, "red"):
                    if value > p1_limits.r do continue outer
                case strings.has_prefix(vc, "blue"):
                    if value > p1_limits.b do continue outer
                case strings.has_prefix(vc, "green"):
                    if value > p1_limits.g do continue outer
                }
                value = -1
            }
        }

        total += id
    }

    return total
}

part_2 :: proc(data: string) -> (total: int) {
    data := data
    id: int
    for line in strings.split_lines_iterator(&data) {
        required: [3]int
        line := line
        id += 1
        colon := strings.index(line, ":")
        assert(colon != -1)
        line = line[colon + 2:]
        value := -1
        ok: bool
        for vc in strings.split_iterator(&line, " ") {
            if value == -1 {
                value, ok = strconv.parse_int(vc)
                assert(ok)
            } else {
                switch {
                case strings.has_prefix(vc, "red"):
                    required.r = max(value, required.r)
                case strings.has_prefix(vc, "blue"):
                    required.b = max(value, required.b)
                case strings.has_prefix(vc, "green"):
                    required.g = max(value, required.g)
                }
                value = -1
            }
        }

        total += required.r * required.g * required.b
    }

    return
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

    pt2_start := time.now()
    pt2_ans := part_2(input)
    pt2_end := time.now()
    fmt.println("P2:", pt2_ans, "Time:", time.diff(pt2_start, pt2_end), "Memory Used:", solution_arena.peak_used)

    free_all(context.allocator)
}


@(test)
part_1_test :: proc(t: ^testing.T) {
    testing.expect_value(t, part_1(test_input), 8)
}

@(test)
part_2_test :: proc(t: ^testing.T) {
    testing.expect_value(t, part_2(test_input), 2286)
}

input := #load("./input.txt", string)

test_input := `Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green`
