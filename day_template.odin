//+ignore
package dayX

import "core:fmt"
import "core:math"
import "core:mem"
import "core:os"
import "core:slice"
import "core:strconv"
import "core:strings"
import "core:testing"
import "core:time"

part_1 :: proc(data: string) -> int {
    return 0
}

part_2 :: proc(data: string) -> int {
    return 0
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
        pt2_ans = part_1(input)
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
    testing.expect_value(t, part_1(test_input), 1234)
}

@(test)
part_2_test :: proc(t: ^testing.T) {
    testing.expect_value(t, part_2(test_input), 1234)
}

@(disabled = !(ODIN_DEBUG || ODIN_TEST))
debug_print :: proc(args: ..any) {
    fmt.println(..args)
}

input := #load("./input.txt", string)
test_input := ``
