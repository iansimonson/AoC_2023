package day6

import "core:fmt"
import "core:mem"
import "core:os"
import "core:math"
import "core:strconv"
import "core:strings"
import "core:testing"
import "core:time"

part_1 :: proc(data: string) -> int {
    data := data
    times := make([dynamic]int, 0, 5)
    distances := make([dynamic]int, 0, 5)
    times_str, _ := strings.split_lines_iterator(&data)
    distances_str, _ := strings.split_lines_iterator(&data)

    ts_colon := strings.index(times_str, ":")
    times_str = strings.trim_left_space(times_str[ts_colon + 1:])
    ds_colon := strings.index(distances_str, ":")
    distances_str = strings.trim_left_space(distances_str[ds_colon + 1:])

    for v in strings.split_iterator(&times_str, " ") {
        if len(v) == 0 do continue
        value := strconv.atoi(v)
        append(&times, value)
    }
    for v in strings.split_iterator(&distances_str, " ") {
        if len(v) == 0 do continue
        value := strconv.atoi(v)
        append(&distances, value)
    }

    assert(len(times) == len(distances))
    results := make([]int, len(times))
    for i in 0..<len(times) {
        time := times[i]
        distance := distances[i]
        for j in 1..<time {
            remaining := time - j
            travelled := remaining * j
            if travelled > distance {
                results[i] += 1
            }
        }
    }

    return math.prod(results[:])

}

part_2 :: proc(data: string) -> int {
    data := data
    times_str, _ := strings.split_lines_iterator(&data)
    distances_str, _ := strings.split_lines_iterator(&data)

    ts_colon := strings.index(times_str, ":")
    times_str = strings.trim_left_space(times_str[ts_colon + 1:])
    ds_colon := strings.index(distances_str, ":")
    distances_str = strings.trim_left_space(distances_str[ds_colon + 1:])

    time, distance: int
    for c in times_str {
        if '0' <= c && c <= '9' {
            time = time * 10 + int(c - '0')
        }
    }

    for c in distances_str {
        if '0' <= c && c <= '9' {
            distance = distance * 10 + int(c - '0')
        }
    }

    result: int
    winning: bool
    for j in 1..<time {
        remaining := time - j
        travelled := remaining * j
        if travelled > distance {
            result += 1
            winning = true
        } else if winning {
            break
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
    testing.expect_value(t, part_1(test_input), 288)
}

@(test)
part_2_test :: proc(t: ^testing.T) {
    testing.expect_value(t, part_2(test_input), 71503)
}

input := #load("./input.txt", string)
test_input := `Time:      7  15   30
Distance:  9  40  200`
