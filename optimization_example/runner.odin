package opt_ex

import "core:time"
import "core:fmt"
import "core:mem"

main :: proc() {

    bench(aocloop_do_work_1)
    bench(aocloop_do_work_1c)
    // bench(aocloop_do_work_1d)
    // bench(aocloop_do_work_1b)
    bench(aocloop_do_work_2)
    // bench(aocloop_do_work_3)
}

bench :: proc(work: proc() -> int) {
    fmt.println()
    fmt.println("BENCHMARKING....")
    fmt.println("=================================")

    widths := []int{1, 5, 10, 20, 50, 100}

    memory := make([]byte, 2 * 1024 * 1024)
    arena: mem.Arena
    mem.arena_init(&arena, memory)

    context.allocator = mem.arena_allocator(&arena)

    iterations := 100_000

    for width in widths {
        aocloop_bench_init(width)
        result: int
        total_time: time.Duration

        for i in 0..<iterations {
            aocloop_per_iter_cleanup()
            start := time.now()
            result += work()
            loop_diff := time.since(start)
            total_time += loop_diff
        }

        aocloop_bench_destroy()
        free_all(context.allocator)

        fmt.println("Width:", width, "time:", int(total_time) / iterations, "ns", "unused value:", result)
    }
}