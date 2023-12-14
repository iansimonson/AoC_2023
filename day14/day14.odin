package day14

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
    newline := strings.index_byte(data, '\n')
    grid_width := newline + 1
    lines := strings.count(data, "\n")
    column_loads := make([]int, newline)
    slice.fill(column_loads, lines)
    column_accumulators := make([]int, newline)


    col: int = -1
    row: int
    for c, i in data {
        col += 1
        switch c {
        case 'O':
            column_accumulators[col] += column_loads[col]
            column_loads[col] -= 1
        case '#':
            column_loads[col] = lines - row - 1
        case '\n':
            row += 1
            col = -1
        }
    }

    return math.sum(column_accumulators)

}


/*
Possible optimization? instead of doing everything towards
the 0th row and rotating. Rotate the world counterclockwise once
and make North to the left, then instead of looking at each element
in the column a column is now a row and you can do it in one sweep

you also don't need row_col_data then, just a single int

But honestly given how many grids we have to cache (120+) I don't think
saving the one extra grid is worth it. That being said removing the work
of filling next with '.' on each rotation would be nice

Whelp replacing current character with '.' as we walk cur_grid
to remove the need to slice.fill() was _slower_ which...sure
*/

cycle_grid :: proc(grid_width: int, cur, next: []u8, row_col_data: []int) {
    cur, next := cur, next
    slice.fill(next, '.')
    slide_and_rotate(grid_width, cur, next, row_col_data) // north

    cur, next = next, cur
    slice.fill(next, '.')
    slide_and_rotate(grid_width, cur, next, row_col_data) // west

    cur, next = next, cur
    slice.fill(next, '.')
    slide_and_rotate(grid_width, cur, next, row_col_data) // south

    cur, next = next, cur
    slice.fill(next, '.')
    slide_and_rotate(grid_width, cur, next, row_col_data) // east
}

// prereq: `next` must be empty (filled with '.')
slide_and_rotate :: proc(grid_width: int, cur, next: []u8, row_col_data: []int) {
    assert(len(row_col_data) == grid_width)
    slice.fill(row_col_data, 0)

    for c, i in cur {
        row := i / grid_width
        col := i % grid_width
        slide_to_row := row_col_data[col]
        // rotate clockwise while we're computing
        switch c {
        case 'O':
            next_idx := col * grid_width + (grid_width - slide_to_row - 1)
            next[next_idx] = u8('O')
            row_col_data[col] += 1
        case '#':
            next_idx := col * grid_width + (grid_width - row - 1)
            next[next_idx] = u8('#')
            row_col_data[col] = row + 1
        }
    }
}

part_2 :: proc(data: string) -> int {
    newline := strings.index_byte(data, '\n')
    grid_width := newline
    lines := strings.count(data, "\n")

    previous_grids: [dynamic][]u8
    current_grid, next_grid := make([]u8, len(data) - lines), make([]u8, len(data) - lines)
    row_or_col_info := make([]int, newline)
    { // fill current_grid
        to_idx: int
        for c in data {
            if c == '\n' do continue

            current_grid[to_idx] = u8(c)
            to_idx += 1
        }
    }

    saved_grid, _ := slice.clone(current_grid)
    append(&previous_grids, saved_grid)

    cycle_count: int
    outer: for cycle_count < 1000000000 {
        cycle_grid(grid_width, current_grid, next_grid, row_or_col_info)
        cycle_count += 1

        for old_grid, i in previous_grids {
            if slice.simple_equal(current_grid, old_grid) {
                cycle := cycle_count - i
                // fmt.println("FOUND CYCLE", cycle_count, i, cycle)
                // for cycle_count < 1000000000 {
                //     cycle_count += cycle
                // }
                // cycle_count -= cycle

                // // fmt.println("cycles left:", 1000000000 - cycle_count)
                // assert(1000000000 - cycle_count < cycle)

                // for cycle_count < 1000000000 {
                //     cycle_grid(grid_width, current_grid, next_grid, row_or_col_info)
                //     cycle_count += 1
                // }


                // thanks @Matija in discord, I was being dumb and forgot I already had this
                // grid simulated and didn't need to simulate more
                current_grid = previous_grids[i + (1000000000 - cycle_count) % cycle]
                break outer
            }
        }

        cur_clone, _ := slice.clone(current_grid)
        append(&previous_grids, cur_clone)
    }


    load: int
    for c, i in current_grid {
        row := i / grid_width
        switch c {
        case 'O':
            load += lines - row
        }
    }

    return load
}

print_grid :: proc(grid_width: int, grid: []u8) {
    for i := 0; i < len(grid); i += grid_width {
        fmt.println(string(grid[i:i + grid_width]))
    }
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
    testing.expect_value(t, part_1(test_input), 136)
}

@(test)
part_2_test :: proc(t: ^testing.T) {
    testing.expect_value(t, part_2(test_input), 64)
}

input := #load("./input.txt", string)
test_input := `O....#....
O.OO#....#
.....##...
OO.#O....O
.O.....O#.
O.#..O.#.#
..O..#O..O
.......O..
#....###..
#OO..#....
`
