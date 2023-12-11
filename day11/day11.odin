package day11

import "core:fmt"
import "core:math"
import "core:mem"
import "core:os"
import "core:slice"
import "core:strconv"
import "core:strings"
import "core:testing"
import "core:time"

part_1 :: proc(data: string) -> (result: int) {
    data := data
    newline := strings.index_byte(data, '\n')
    grid_width := newline + 1

    galaxies := make([dynamic]int, 0, 100)
    xspansions := make([]int, grid_width - 1)
    yspansions := make([]int, grid_width - 1)
    yspansion: int

    found_galaxy_row: bool
    found_galaxy_col := make([]bool, grid_width - 1) // remove newline
    line_count: int
    for c, i in data {
        if c == '#' {
            append(&galaxies, i)
            found_galaxy_row = true
            col := i % grid_width
            found_galaxy_col[col] = true
        } else if c == '\n' {
            if !found_galaxy_row {
                yspansion += 1
            }
            yspansions[line_count] = yspansion
            found_galaxy_row = false
            line_count += 1
        }
    }

    xspansion: int
    for found, i in found_galaxy_col {
        if !found {
            xspansion += 1
        }
        xspansions[i] = xspansion
    }


    for g, i in galaxies {
        for j in i..<len(galaxies) {
            g2 := galaxies[j]
            g1coords := [2]int{g % grid_width, g / grid_width}
            g2coords := [2]int{g2 % grid_width, g2 / grid_width}
            diff := g2coords - g1coords

            yspansion_diff := abs(yspansions[g2coords.y] - yspansions[g1coords.y])
            xspansion_diff := abs(xspansions[g2coords.x] - xspansions[g1coords.x])

            distance := (abs(diff.x) + abs(diff.y)) + (yspansion_diff + xspansion_diff)

            result += distance
        }
    }

    return
}

part_2 :: proc(data: string) -> (result: int) {
    data := data
    newline := strings.index_byte(data, '\n')
    grid_width := newline + 1

    galaxies := make([dynamic]int, 0, 100)
    xspansions := make([]int, grid_width - 1)
    yspansions := make([]int, grid_width - 1)
    yspansion: int

    found_galaxy_row: bool
    found_galaxy_col := make([]bool, grid_width - 1) // remove newline
    line_count: int
    for c, i in data {
        if c == '#' {
            append(&galaxies, i)
            found_galaxy_row = true
            col := i % grid_width
            found_galaxy_col[col] = true
        } else if c == '\n' {
            if !found_galaxy_row {
                yspansion += 999_999
            }
            yspansions[line_count] = yspansion
            found_galaxy_row = false
            line_count += 1
        }
    }

    xspansion: int
    for found, i in found_galaxy_col {
        if !found {
            xspansion += 999_999
        }
        xspansions[i] = xspansion
    }


    for g, i in galaxies {
        for j in i..<len(galaxies) {
            g2 := galaxies[j]
            g1coords := [2]int{g % grid_width, g / grid_width}
            g2coords := [2]int{g2 % grid_width, g2 / grid_width}
            diff := g2coords - g1coords

            yspansion_diff := abs(yspansions[g2coords.y] - yspansions[g1coords.y])
            xspansion_diff := abs(xspansions[g2coords.x] - xspansions[g1coords.x])

            distance := (abs(diff.x) + abs(diff.y)) + (yspansion_diff + xspansion_diff)

            result += distance
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
    testing.expect_value(t, part_1(test_input), 374)
}

// no test for pt2 b/c I just changed 2 numbers from pt1
// and didn't rerun any tests for the 10x expansion
// @(test)
// part_2_test :: proc(t: ^testing.T) {
//     testing.expect_value(t, part_2(test_input), 1234)
// }

input := #load("./input.txt", string)
test_input := `...#......
.......#..
#.........
..........
......#...
.#........
.........#
..........
.......#..
#...#.....
`
