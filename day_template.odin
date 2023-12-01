//+ignore
package dayX

import "core:testing"
import "core:time"
import "core:mem"
import "core:os"

dayX_pt1 :: proc(data: string) -> int {
    return 0
}

dayX_pt2 :: proc(data: string) -> int {
    return 0
}

main :: proc() {
    arena_backing := make([]u8, 8 * mem.Megabyte)
    solution_arena: mem.Arena
    mem.arena_init(&solution_arena, arena_backing)

    alloc := mem.arena_allocator(&solution_arena)
    context.allocator = alloc

    pt1_start := time.now()
    pt1_ans := dayX_pt1(dayX_data)
    pt1_end := time.now()
    fmt.println("P1:", pt1_ans, "Time:", time.diff(pt1_start, pt1_end), "Memory Used:", solution_arena.peak_used)
    
    free_all(context.allocator)

    pt2_start := time.now()
    pt2_ans := dayX_pt2(dayX_data)
    pt2_end := time.now()
    fmt.println("P2:", pt2_ans, "Time:", time.diff(pt2_start, pt2_end), "Memory Used:", solution_arena.peak_used)

    free_all(context.allocator)
}


@(test)
dayX_test :: proc(t: ^testing.T) {
    testing.expect_value(t, dayX_pt1(test_data), 1234)
    testing.expect_value(t, dayX_pt2(test_data), 1234)
}

dayX_data := #load("./input.txt", string)
dayX_test_data := ``