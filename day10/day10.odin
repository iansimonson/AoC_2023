package day10

import "core:fmt"
import "core:mem"
import "core:os"
import "core:strconv"
import "core:strings"
import "core:testing"
import "core:time"
import ba "core:container/bit_array"

connecting_pipes :: proc(grid: []u8, grid_width: int, idx: int) -> [2]int {
    switch grid[idx] {
    case '|':
        return {-grid_width, grid_width} + idx
    case '-':
        return {-1, +1} + idx
    case 'L':
        return {-grid_width, 1} + idx
    case 'J':
        return {-grid_width, -1} + idx
    case '7':
        return {-1, grid_width} + idx
    case 'F':
        return {grid_width, 1} + idx
    case:
    }
    return {}
}

part_1 :: proc(data: string) -> int {
    data := data
    grid_width := -1
    grid: [dynamic]u8
    s_idx: int
    l_count: int
    for line in strings.split_lines_iterator(&data) {
        if grid_width == -1 {
            grid_width = len(line) + 2
            grid = make([dynamic]u8, 0, 10 * grid_width)
            for i in 0..<grid_width do append(&grid, u8('.'))
        }
        append(&grid, u8('.'))
        for c, i in line {
            if c == 'S' do s_idx = (i + 1) + (l_count + 1) * grid_width
            append(&grid, u8(c))
        }
        append(&grid, u8('.'))
        l_count += 1
    }
    for i in 0..<grid_width do append(&grid, u8('.'))
    offsets := []int{-grid_width, grid_width, -1, +1}
    
    fwd, bck: int
    fwd_idx, fwd_prev, bck_idx, bck_prev: int

    for offset in offsets {
        idcs := connecting_pipes(grid[:], grid_width, s_idx + offset)
        if idcs[0] == s_idx || idcs[1] == s_idx {
            if fwd_idx == 0 do fwd_idx = s_idx + offset
            else if bck_idx == 0 do bck_idx = s_idx + offset
            else do assert(false)
        }
    }
    fwd_prev, bck_prev = s_idx, s_idx

    assert(fwd_idx != 0 && bck_idx != 0)
    fwd += 1
    bck += 1
    for fwd_idx != bck_idx {
        fwd_idcs := connecting_pipes(grid[:], grid_width, fwd_idx)
        if fwd_idcs[0] == fwd_prev {
            fwd_idx, fwd_prev = fwd_idcs[1], fwd_idx
        } else {
            fwd_idx, fwd_prev = fwd_idcs[0], fwd_idx
        }

        bck_idcs := connecting_pipes(grid[:], grid_width, bck_idx)
        if bck_idcs[0] == bck_prev {
            bck_idx, bck_prev = bck_idcs[1], bck_idx
        } else {
            bck_idx, bck_prev = bck_idcs[0], bck_idx
        }
        fwd, bck = fwd + 1, bck + 1
    }

    assert(fwd == bck)


    return fwd
}

part_2 :: proc(data: string) -> int {
    data := data
    grid_width := -1
    grid: [dynamic]u8

    s_idx: int
    l_count: int
    for line in strings.split_lines_iterator(&data) {
        if grid_width == -1 {
            grid_width = len(line) + 2
            grid = make([dynamic]u8, 0, 10 * grid_width)
            for i in 0..<grid_width do append(&grid, u8('.'))
        }
        append(&grid, u8('.'))
        for c, i in line {
            if c == 'S' do s_idx = (i + 1) + (l_count + 1) * grid_width
            append(&grid, u8(c))
        }
        append(&grid, u8('.'))
        l_count += 1
    }
    for i in 0..<grid_width do append(&grid, u8('.'))
    offsets := []int{-grid_width, grid_width, -1, +1}

    pipe_map := ba.create(len(grid))
    visited_starbord := ba.create(len(grid))
    visited_port := ba.create(len(grid))
    ba.set(pipe_map, s_idx)
    
    sfwd, sbck: int
    fwd_idx, fwd_prev, bck_idx, bck_prev: int

    for offset in offsets {
        idcs := connecting_pipes(grid[:], grid_width, s_idx + offset)
        if idcs[0] == s_idx || idcs[1] == s_idx {
            if fwd_idx == 0 do fwd_idx = s_idx + offset
            else if bck_idx == 0 do bck_idx = s_idx + offset
            else do assert(false)
        }
    }
    fwd_prev, bck_prev = s_idx, s_idx
    sfwd, sbck = fwd_idx, bck_idx

    assert(fwd_idx != 0 && bck_idx != 0)
    for fwd_idx != bck_idx {
        ba.set(pipe_map, fwd_idx)
        ba.set(pipe_map, bck_idx)

        fwd_idcs := connecting_pipes(grid[:], grid_width, fwd_idx)
        if fwd_idcs[0] == fwd_prev {
            fwd_idx, fwd_prev = fwd_idcs[1], fwd_idx
        } else {
            fwd_idx, fwd_prev = fwd_idcs[0], fwd_idx
        }

        bck_idcs := connecting_pipes(grid[:], grid_width, bck_idx)
        if bck_idcs[0] == bck_prev {
            bck_idx, bck_prev = bck_idcs[1], bck_idx
        } else {
            bck_idx, bck_prev = bck_idcs[0], bck_idx
        }
    }
    ba.set(pipe_map, fwd_idx)

    /*

    In case anyone sees this monstrosity:
    the idea is we traverse the pipe again in one direction this time.
    At every point on the pipe we flood-fill on the port and starboard side
    of the line. At the end, because we have an empty border around the input,
    exactly one of our two "visited" boards will have visited (0, 0) as the
    other was inside the loop

    Discard the "outside" bit array and then count all the visited spots on the "inside" array

    I was sleepy and couldnt think of a good way to determine direction of travel so its all
    offsets between previous location, now, and next location
    */

    fwd_idx, fwd_prev = sfwd, s_idx
    for fwd_idx != s_idx {
        enter_offset := fwd_idx - fwd_prev

        fwd_idcs := connecting_pipes(grid[:], grid_width, fwd_idx)
        if fwd_idcs[0] == fwd_prev {
            fwd_idx, fwd_prev = fwd_idcs[1], fwd_idx
        } else {
            fwd_idx, fwd_prev = fwd_idcs[0], fwd_idx
        }

        exit_offset := fwd_idx - fwd_prev
        switch {
        case enter_offset == 1 && exit_offset == 1:
            flood_fill(grid[:], grid_width, pipe_map, visited_starbord, fwd_prev + grid_width)
            flood_fill(grid[:], grid_width, pipe_map, visited_port, fwd_prev - grid_width)
        case enter_offset == 1 && exit_offset == -grid_width:
            flood_fill(grid[:], grid_width, pipe_map, visited_starbord, fwd_prev + grid_width)
            flood_fill(grid[:], grid_width, pipe_map, visited_starbord, fwd_prev + 1)
        case enter_offset == 1 && exit_offset == grid_width:
            flood_fill(grid[:], grid_width, pipe_map, visited_port, fwd_prev - grid_width)
            flood_fill(grid[:], grid_width, pipe_map, visited_port, fwd_prev + 1)

        case enter_offset == -1 && exit_offset == -1:
            flood_fill(grid[:], grid_width, pipe_map, visited_starbord, fwd_prev - grid_width)
            flood_fill(grid[:], grid_width, pipe_map, visited_port, fwd_prev + grid_width)
        case enter_offset == -1 && exit_offset == -grid_width:
            flood_fill(grid[:], grid_width, pipe_map, visited_port, fwd_prev - 1)
            flood_fill(grid[:], grid_width, pipe_map, visited_port, fwd_prev + grid_width)
        case enter_offset == -1 && exit_offset == grid_width:
            flood_fill(grid[:], grid_width, pipe_map, visited_starbord, fwd_prev - 1)
            flood_fill(grid[:], grid_width, pipe_map, visited_starbord, fwd_prev - grid_width)
        
        case enter_offset == -1 && exit_offset == -1:
            flood_fill(grid[:], grid_width, pipe_map, visited_starbord, fwd_prev - grid_width)
            flood_fill(grid[:], grid_width, pipe_map, visited_port, fwd_prev + grid_width)
        case enter_offset == -1 && exit_offset == -grid_width:
            flood_fill(grid[:], grid_width, pipe_map, visited_port, fwd_prev - 1)
            flood_fill(grid[:], grid_width, pipe_map, visited_port, fwd_prev + grid_width)
        case enter_offset == -1 && exit_offset == grid_width:
            flood_fill(grid[:], grid_width, pipe_map, visited_starbord, fwd_prev - 1)
            flood_fill(grid[:], grid_width, pipe_map, visited_starbord, fwd_prev - grid_width)
        
        case enter_offset == -grid_width && exit_offset == -grid_width:
            flood_fill(grid[:], grid_width, pipe_map, visited_starbord, fwd_prev + 1)
            flood_fill(grid[:], grid_width, pipe_map, visited_port, fwd_prev - 1)
        case enter_offset == -grid_width && exit_offset == 1:
            flood_fill(grid[:], grid_width, pipe_map, visited_port, fwd_prev - 1)
            flood_fill(grid[:], grid_width, pipe_map, visited_port, fwd_prev - grid_width)
        case enter_offset == -grid_width && exit_offset == -1:
            flood_fill(grid[:], grid_width, pipe_map, visited_starbord, fwd_prev + 1)
            flood_fill(grid[:], grid_width, pipe_map, visited_starbord, fwd_prev - grid_width)
        
        case enter_offset == grid_width && exit_offset == grid_width:
            flood_fill(grid[:], grid_width, pipe_map, visited_starbord, fwd_prev - 1)
            flood_fill(grid[:], grid_width, pipe_map, visited_port, fwd_prev + 1)
        case enter_offset == grid_width && exit_offset == 1:
            flood_fill(grid[:], grid_width, pipe_map, visited_starbord, fwd_prev - 1)
            flood_fill(grid[:], grid_width, pipe_map, visited_starbord, fwd_prev + grid_width)
        case enter_offset == grid_width && exit_offset == -1:
            flood_fill(grid[:], grid_width, pipe_map, visited_port, fwd_prev - 1)
            flood_fill(grid[:], grid_width, pipe_map, visited_port, fwd_prev + grid_width)
        }
    }

    // print_ba(len(grid), grid_width, visited_starbord)
    // print_ba(len(grid), grid_width, visited_port)

    v: ^ba.Bit_Array
    if ba.get(visited_starbord, 0) do v = visited_port
    else do v = visited_starbord

    result: int
    for i in 0..<len(grid) {
        if ba.get(v, i) do result += 1
    }

    return result
}

flood_fill :: proc(grid: []u8, grid_width: int, pipes, visited: ^ba.Bit_Array, start: int) {
    if start < 0 || start > len(grid) do return

    vv, _ := ba.get(visited, start)
    pv, _ := ba.get(pipes, start)
    if vv || pv do return

    ba.set(visited, start)
    flood_fill(grid, grid_width, pipes, visited, start - grid_width)
    flood_fill(grid, grid_width, pipes, visited, start + grid_width)
    flood_fill(grid, grid_width, pipes, visited, start - 1)
    flood_fill(grid, grid_width, pipes, visited, start + 1)
}

print_ba :: proc(l, gl: int, b: ^ba.Bit_Array) {
    x := make([]u8, l, context.temp_allocator)
    for &r, i in x {
        bv, _ := ba.get(b, i)
        if bv do r = u8('X')
        else do r = u8('I')
    }

    for i := 0; i < l; i += gl {
        fmt.println(string(x[i:i + gl]))
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
    testing.expect_value(t, part_1(test_input), 4)
}

@(test)
part_1_test_2 :: proc(t: ^testing.T) {
    testing.expect_value(t, part_1(test_input_2), 8)
}

@(test)
part_2_test :: proc(t: ^testing.T) {
    testing.expect_value(t, part_2(test_input_3), 4)
}

@(test)
part_2_test_sneaky :: proc(t: ^testing.T) {
    testing.expect_value(t, part_2(test_input_3b), 4)
}

@(test)
part_2_test_2 :: proc(t: ^testing.T) {
    testing.expect_value(t, part_2(test_input_4), 8)
}

@(test)
part_2_test_3 :: proc(t: ^testing.T) {
    testing.expect_value(t, part_2(test_input_5), 10)
}

input := #load("./input.txt", string)
test_input := `.....
.S-7.
.|.|.
.L-J.
.....`

test_input_2 := `..F7.
.FJ|.
SJ.L7
|F--J
LJ...`

test_input_3 := `...........
.S-------7.
.|F-----7|.
.||.....||.
.||.....||.
.|L-7.F-J|.
.|..|.|..|.
.L--J.L--J.
...........`

test_input_3b := `..........
.S------7.
.|F----7|.
.||....||.
.||....||.
.|L-7F-J|.
.|..||..|.
.L--JL--J.
..........`

test_input_4 := `.F----7F7F7F7F-7....
.|F--7||||||||FJ....
.||.FJ||||||||L7....
FJL7L7LJLJ||LJ.L-7..
L--J.L7...LJS7F-7L7.
....F-J..F7FJ|L7L7L7
....L7.F7||L7|.L7L7|
.....|FJLJ|FJ|F7|.LJ
....FJL-7.||.||||...
....L---J.LJ.LJLJ...`

test_input_5 := `FF7FSF7F7F7F7F7F---7
L|LJ||||||||||||F--J
FL-7LJLJ||||||LJL-77
F--JF--7||LJLJ7F7FJ-
L---JF-JLJ.||-FJLJJ7
|F|F-JF---7F7-L7L|7|
|FFJF7L7F-JF7|JL---7
7-L-JL7||F7|L7F-7F7|
L.L7LFJ|||||FJL7||LJ
L7JLJL-JLJLJL--JLJ.L`