package day24

import "core:fmt"
import "core:math"
import "core:mem"
import "core:os"
import "core:slice"
import "core:strconv"
import "core:strings"
import "core:testing"
import "core:time"
import "core:math/linalg"

Hail :: struct {
    pos: [3]int,
    velocity: [3]int,
}

part_1 :: proc(data: string, min_v, max_v: int) -> int {
    data := data
    hails: [dynamic]Hail
    for line in strings.split_lines_iterator(&data) {
        line := line
        hail: Hail
        pos, _ := strings.split_by_byte_iterator(&line, '@')
        velocity, _ := strings.split_by_byte_iterator(&line, '@')
        idx: int
        for v_str in strings.split_by_byte_iterator(&pos, ',') {
            hail.pos[idx] = strconv.atoi(strings.trim_space(v_str))
            idx += 1
        }

        idx = 0
        for v_str in strings.split_by_byte_iterator(&velocity, ',') {
            hail.velocity[idx] = strconv.atoi(strings.trim_space(v_str))
            idx += 1
        }

        append(&hails, hail)
    }
    debug_print(hails)

    return num_paths_intersect(hails[:], min_v, max_v)
}

part_2 :: proc(data: string) -> int {
    return 0
}

num_paths_intersect :: proc(hails: []Hail, min_v, max_v: int) -> int {

    /*
dx = bs.x - as.x
dy = bs.y - as.y
det = bd.x * ad.y - bd.y * ad.x
u = (dy * bd.x - dx * bd.y) / det
v = (dy * ad.x - dx * ad.y) / det
    */
    

    result: int
    for hail, i in hails {
        for hail2 in hails[i + 1:] {
            as, bs := [2]f64{f64(hail.pos.x), f64(hail.pos.y)}, [2]f64{f64(hail2.pos.x), f64(hail2.pos.y)}
            ad, bd := [2]f64{f64(hail.velocity.x), f64(hail.velocity.y)}, [2]f64{f64(hail2.velocity.x), f64(hail2.velocity.y)}

            d := bs - as
            det := bd.x * ad.y - bd.y * ad.x

            // either colinear or no intersect
            if det == 0 {
                if as.x == bs.x || as.y == bs.y {
                    debug_print("COLININT:", as, ad, "and", bs, bd)
                    result += 1
                }
                continue
            }

            u := (d.y * bd.x - d.x * bd.y) / det
            v := (d.y * ad.x - d.x * ad.y) / det

            if u >= 0 && v >= 0 {
                ip := as + ad * u
                intersect_point := [2]int{int(ip.x), int(ip.y)}
                if (intersect_point.x >= min_v && intersect_point.x <= max_v) && (intersect_point.y >= min_v && intersect_point.y <= max_v) {
                    debug_print("INTER", as, ad, "and", bs, bd, "at point", intersect_point)
                    result += 1
                }
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
        pt1_ans = part_1(input, 200000000000000, 400000000000000)
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
    testing.expect_value(t, part_1(test_input, 7, 27), 2)
}

@(test)
part_2_test :: proc(t: ^testing.T) {
    testing.expect_value(t, part_2(test_input), 47)
}

@(disabled = !(ODIN_DEBUG || ODIN_TEST))
debug_print :: proc(args: ..any) {
    fmt.println(..args)
}

AVG_RUNTIME :: #config(AVG, false)

input := #load("./input.txt", string)
test_input := `19, 13, 30 @ -2,  1, -2
18, 19, 22 @ -1, -1, -2
20, 25, 34 @ -2, -2, -4
12, 31, 28 @ -1, -2, -1
20, 19, 15 @  1, -5, -3`
