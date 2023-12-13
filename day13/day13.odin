package day13

import "core:fmt"
import "core:math"
import "core:mem"
import "core:os"
import "core:slice"
import "core:strconv"
import "core:strings"
import "core:testing"
import "core:time"
import "core:intrinsics"

Rocks :: bit_set[0..<32; u32]

find_mirror :: proc(rocks: []Rocks) -> int {
    check_rows: for i in 0..<len(rocks) - 1 {
        lhs, rhs := rocks[:i + 1], rocks[i + 1:]
        if len(lhs) > len(rhs) {
            diff := len(lhs) - len(rhs)
            lhs = lhs[diff:]
        } else if len(rhs) > len(lhs) {
            rhs = rhs[:len(lhs)]
        }

        assert(len(lhs) == len(rhs))
        l := len(lhs)
    
        for j in 0..<l {
            if lhs[l - 1 - j] != rhs[j] do continue check_rows
        }

        return i + 1
    }

    return 0
}

part_1 :: proc(data: string) -> (result: int) {
    data := data

    rows := make([dynamic]Rocks, 0, 15)
    cols := make([dynamic]Rocks, 0, 15)

    row_accum, col_accum: int

    grids: for grid in strings.split_iterator(&data, "\n\n") {
        grid := grid
        clear(&rows)
        clear(&cols)

        row_idx: int
        for row in strings.split_lines_iterator(&grid) {
            append(&rows, Rocks{})
            for r, i in row {
                if i >= len(cols) do append(&cols, Rocks{})
                if r == '#' {
                    rows[row_idx] += {i}
                    cols[i] += {row_idx}
                }
            }
            row_idx += 1
        }

        rmirr, cmirr: int
        rmirr = find_mirror(rows[:])

        if rmirr != 0 {
            row_accum += rmirr
        } else {
            cmirr = find_mirror(cols[:])
            col_accum += cmirr
        }

        assert((rmirr != 0) !=  (cmirr != 0))
    }

    return 100 * row_accum + col_accum
}

part_2 :: proc(data: string) -> int {
    data := data

    rows := make([dynamic]Rocks, 0, 15)
    cols := make([dynamic]Rocks, 0, 15)

    row_accum, col_accum: int

    grids: for grid in strings.split_iterator(&data, "\n\n") {
        grid := grid
        clear(&rows)
        clear(&cols)

        row_idx: int
        for row in strings.split_lines_iterator(&grid) {
            append(&rows, Rocks{})
            for r, i in row {
                if i >= len(cols) do append(&cols, Rocks{})
                if r == '#' {
                    rows[row_idx] += {i}
                    cols[i] += {row_idx}
                }
            }
            row_idx += 1
        }

        rmirr, cmirr: int
        rmirr = find_mirror_smudge(rows[:])

        if rmirr != 0 {
            row_accum += rmirr
        } else {
            cmirr = find_mirror_smudge(cols[:])
            col_accum += cmirr
        }

        assert((rmirr != 0) !=  (cmirr != 0))
    }

    return 100 * row_accum + col_accum
}

find_mirror_smudge :: proc(rocks: []Rocks) -> int {
    check_rows: for i in 0..<len(rocks) - 1 {
        lhs, rhs := rocks[:i + 1], rocks[i + 1:]
        if len(lhs) > len(rhs) {
            diff := len(lhs) - len(rhs)
            lhs = lhs[diff:]
        } else if len(rhs) > len(lhs) {
            rhs = rhs[:len(lhs)]
        }

        assert(len(lhs) == len(rhs))
        l := len(lhs)
    
        reflections: u32
        for j in 0..<l {
            diffs := lhs[l - 1 - j] ~ rhs[j]
            reflections += intrinsics.count_ones(transmute(u32) diffs)
        }

        if reflections == 1 do return i + 1
    }

    return 0
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
    testing.expect_value(t, part_1(test_input), 405)
}

@(test)
part_2_test :: proc(t: ^testing.T) {
    testing.expect_value(t, part_2(test_input), 400)
}

input := #load("./input.txt", string)
test_input := `#.##..##.
..#.##.#.
##......#
##......#
..#.##.#.
..##..##.
#.#.##.#.

#...##..#
#....#..#
..##..###
#####.##.
#####.##.
..##..###
#....#..#`
