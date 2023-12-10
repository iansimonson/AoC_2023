package day9

import "core:fmt"
import "core:mem"
import "core:os"
import "core:slice"
import "core:strconv"
import "core:strings"
import "core:testing"
import "core:time"

part_1 :: proc(data: string) -> (result: int) {
    data := data
    values := make([dynamic]int, 0, 100)
    left_values: int
    lines: for line in strings.split_lines_iterator(&data) {
        clear(&values)
        left_values = 0
        line := line
        for v in strings.split_iterator(&line, " ") {
            if len(v) == 0 do continue
            append(&values, strconv.atoi(v))
        }
        val_slice := values[:]
        for {
            left_values += val_slice[len(val_slice) - 1]
            for i in 1..<len(val_slice) {
                val_slice[i - 1] = val_slice[i] - val_slice[i - 1]
            }
            val_slice = val_slice[:len(val_slice) - 1]
            if slice.all_of(val_slice, 0) {
                result += left_values
                continue lines
            }
        }
    }
    return
}

part_2 :: proc(data: string) -> (result: int) {
    data := data
    values := make([dynamic]int, 0, 100)
    left_values := make([dynamic]int, 0, 100)
    lines: for line in strings.split_lines_iterator(&data) {
        clear(&values)
        clear(&left_values)
        line := line
        for v in strings.split_iterator(&line, " ") {
            if len(v) == 0 do continue
            append(&values, strconv.atoi(v))
        }
        val_slice := values[:]
        for {
            append(&left_values, val_slice[0])
            for i in 1..<len(val_slice) {
                val_slice[i - 1] = val_slice[i] - val_slice[i - 1]
            }
            val_slice = val_slice[:len(val_slice) - 1]
            if slice.all_of(val_slice, 0) {
                prev_val := 0
                #reverse for v in left_values {
                    prev_val = v - prev_val
                }
                result += prev_val
                continue lines
            }
        }
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
    testing.expect_value(t, part_1(test_input), 114)
}

@(test)
part_2_test :: proc(t: ^testing.T) {
    testing.expect_value(t, part_2(test_input), 2)
}

input := #load("./input.txt", string)
test_input := `0 3 6 9 12 15
1 3 6 10 15 21
10 13 16 21 30 45`
