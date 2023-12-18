package day18

import "core:fmt"
import "core:math"
import "core:mem"
import "core:os"
import "core:slice"
import "core:strconv"
import "core:strings"
import "core:testing"
import "core:time"

/*
    Since we kinda already did the loop around a ring and flood-fill
    on a previous day, I feel ok just looking up and learning how to
    do the digital 2d application of green's theorem for this
*/
Point :: [2]int

// normally up is a negative direction
// but we'll make the grid "normal" math grid
offsets := [256]Point{
    'R' = {1, 0},
    'L' = {-1, 0},
    'U' = {0, 1},
    'D' = {0, -1},

    '0' = {1, 0},
    '1' = {0, -1},
    '2' = {-1, 0},
    '3' = {0, 1},
}

part_1 :: proc(data: string) -> int {
    points := make([dynamic]Point, 0, 680)
    
    current_point: Point
    append(&points, current_point)

    data := data
    perimeter: int
    for line in strings.split_lines_iterator(&data) {

        offset := offsets[line[0]]
        length := strconv.atoi(line[2:])
        assert(length != 0)

        current_point += (offset * length)
        append(&points, current_point)
        perimeter += length
    }
    assert(current_point == {0, 0})

    two_area: int
    for i in 1..<len(points) {
        two_area += (points[i].x + points[i - 1].x) * (points[i].y - points[i - 1].y)
    }
    area := abs(two_area / 2)
    internal_points := area - (perimeter / 2) + 1
    return internal_points + perimeter
}

part_2 :: proc(data: string) -> int {
    points := make([dynamic]Point, 0, 680)
    
    current_point: Point
    append(&points, current_point)

    data := data
    perimeter: int
    for line in strings.split_lines_iterator(&data) {

        hash := strings.index_byte(line, '#')
        length, lok := strconv.parse_int(line[hash+1:][:5], base = 16)
        assert(lok)
        assert(length != 0)

        offset := offsets[line[hash+6]]

        current_point += (offset * length)
        append(&points, current_point)
        perimeter += length
    }
    assert(current_point == {0, 0})

    two_area: int
    for i in 1..<len(points) {
        two_area += (points[i].x + points[i - 1].x) * (points[i].y - points[i - 1].y)
    }
    area := abs(two_area / 2)
    internal_points := area - (perimeter / 2) + 1
    return internal_points + perimeter
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
    testing.expect_value(t, part_1(test_input), 62)
}

@(test)
part_2_test :: proc(t: ^testing.T) {
    testing.expect_value(t, part_2(test_input), 952_408_144_115)
}

input := #load("./input.txt", string)
test_input := `R 6 (#70c710)
D 5 (#0dc571)
L 2 (#5713f0)
D 2 (#d2c081)
R 2 (#59c680)
D 2 (#411b91)
L 5 (#8ceee2)
U 2 (#caa173)
L 1 (#1b58a2)
U 2 (#caa171)
R 2 (#7807d2)
U 3 (#a77fa3)
L 2 (#015232)
U 2 (#7a21e3)`
