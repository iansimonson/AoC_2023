package day21

import "core:fmt"
import "core:math"
import "core:mem"
import "core:os"
import "core:slice"
import "core:strconv"
import "core:strings"
import "core:testing"
import "core:time"
import q "core:container/queue"

Pos :: [2]int
Par :: [2]bool
// grid containing extraneous newlines
GridN :: struct {
    data: []u8,
    width, height: int,
}

parity :: proc(pos: Pos) -> Par {
    return Par{pos.x % 2 == 0, pos.y % 2 == 0}
}

Node :: struct {
    p: Pos,
    prev_height: i8,
}

print_heightmap :: proc(m: $A/[]$T, width: int) {
    for i := 0; i < len(m); i += width {
        fmt.println(m[i:][:width])
    }
}


solve :: proc(grid: GridN, start: Pos, steps: int) -> int {
    s_idx := start.y * grid.width + start.x
    s_par := parity(start)

    height_grid := make([]i8, grid.height * grid.width)
    slice.fill(height_grid, -1)

    queue: q.Queue(Node)
    q.init(&queue)
    q.append(&queue, Node{start, -1})

    offsets := [4]Pos{{0, -1}, {0, 1}, {-1, 0}, {1, 0}}

    for q.len(queue) != 0 {
        next := q.pop_front(&queue)
        next_idx := next.p.y * grid.width + next.p.x
        if height_grid[next_idx] != -1 do continue
        
        if grid.data[next_idx] == '#' || grid.data[next_idx] == '\n' {
            height_grid[next_idx] = max(i8)
            continue
        }

        nheight := 1 + next.prev_height
        
        if nheight % 2 != 0 do height_grid[next_idx] = -1
        else do height_grid[next_idx] = nheight

        if nheight > i8(steps) do continue

        neighbors := [4]Pos{offsets[0] + next.p, offsets[1] + next.p, offsets[2] + next.p, offsets[3] + next.p} 
        q.append_elems(&queue, Node{neighbors[0], nheight}, Node{neighbors[1], nheight}, Node{neighbors[2], nheight}, Node{neighbors[3], nheight})
    }

    // print_heightmap(height_grid, grid.width)

    result: int
    for h in height_grid {
        if h != -1 && h <= i8(steps) do result += 1
    }

    return result
}

part_1 :: proc(data: string, steps: int) -> int {
    data := data
    newline := strings.index_byte(data, '\n')
    width := newline + 1
    height := len(data) / width

    s_idx := strings.index_byte(data, 'S')
    s_pos := Pos{s_idx % width, s_idx / width}

    return solve(GridN{transmute([]u8) data, width, height}, s_pos, steps)
}

/*
    I don't know if this makes sense for my math or not to begin with
    or I just have a bug in the program and I'm almost there.

    How I think it should work:

    Basically, the number of reachable squares in the grid is based
    on the parity of the step count you have. You can never reach a square
    1 space away no matter how many steps you take if you are taking an even
    number of steps.

    So the center grid has a set of reachable squares. that hasn't changed
    then the parity swaps in each cardinal direction, and _doesn't_ change in
    each diagonal region (b/c you take 2 steps)

    Remove the steps required to get to the 8 corners / center edge squares we are going
    to use becasue the end rows/cols of the grid are empty (as is the center row/col)
    Then step once into each surrounding grid (8 neighbors)

    For the centers, calculate the furthest number of grids we can go upward that can be
    fully reached. Given the heightmaps for reachable squares (num squares required to reach)

    The number of full grids reachable should be (steps_remaining - highest square reachable) / grid_dimension
    The remaining steps to simulate in this direction should be (steps_remaining % grid_dimension) + highest square reachable

    For the diagonals, it's the same thing but using the heightmap of the diagonal we are starting from
    there's some partial amount at the end also
    Since the overall floodfill is rhombus-ish shaped in nature, the number of diagonal squares
    should be the sum of 1...N or (N(N+1) / 2) squares

    These actually alternate parity as they grow out from the center so
    in terms of full grids it's actually the sum of the first N/2 odd numbers (N^2) * diagonal_odd_parity_reachable
    plus the sum of the first N/2 even numbers or N * (N + 1) * diagonal_even_parity_reachable

    Then...there should be N + 1 partial reachable grids...I think maybe this is where I'm going wrong
    because there's actually more than that and less at the same time and you can enter from multiple
    directions...maybe I need to actually flood-fill the borders from each point? but there are so many points

*/

part_2 :: proc(data: string, steps: int) -> (result: int) {
    data := data
    newline := strings.index_byte(data, '\n')
    width := newline + 1
    height := len(data) / width

    grid := GridN{transmute([]u8) data, width, height}

    s_idx := strings.index_byte(data, 'S')
    s_pos := Pos{s_idx % width, s_idx / width}

    s_height_map := gen_heightmap(grid, s_pos)

    center_reachable := reachable(grid, s_height_map, steps)

    fmt.println(center_reachable)

    // empty rows/cols are locations we can travel through a grid with minimum steps
    // in horizontal/vertical directions. it _happens_ to be the case that in the main grid
    // it's the center row/column that's also empty
    empty_rows: [dynamic]int
    outer_rows: for j in 0..<grid.height {
        for i in 0..<(grid.width - 1) {
            char := grid.data[j * grid.width + i]
            if  char != '.' && char != 'S' do continue outer_rows
        }
        append(&empty_rows, j)
    }
    empty_cols: [dynamic]int
    outer_cols: for i in 0..<grid.width - 1 {
        for j in 0..<grid.height {
            char := grid.data[j * grid.width + i]
            if  char != '.' && char != 'S' do continue outer_cols
        }
        append(&empty_cols, i)
    }


    //heightmaps of the 8 squares of interest
    // in order: top-left, top-mid, top-right
    // left-mid, right-mid, bottom-left
    // bottom-mid, bottom-right

    top_row_heightmaps := make([][]int, len(empty_cols))
    bottom_row_heightmaps := make([][]int, len(empty_cols))
    left_column_heightmaps := make([][]int, len(empty_rows))
    right_column_heightmaps := make([][]int, len(empty_rows))
    for col, i in empty_cols {
        top_row_heightmaps[i] = gen_heightmap(grid, Pos{col, 0})
        bottom_row_heightmaps[i] = gen_heightmap(grid, Pos{col, grid.height - 1})
    }
    for row, i in empty_rows {
        left_column_heightmaps[i] = gen_heightmap(grid, Pos{0, row})
        right_column_heightmaps[i] = gen_heightmap(grid, Pos{grid.width - 2, row})
    }

    top_steps_left := make([]int, len(top_row_heightmaps))
    bottom_steps_left := make([]int, len(bottom_row_heightmaps))
    left_steps_left := make([]int, len(left_column_heightmaps))
    right_steps_left := make([]int, len(right_column_heightmaps))

    for col, i in empty_cols {
        top_steps_left[i] = max(0, steps - s_height_map[col])
        bottom_steps_left[i] = max(0, steps - s_height_map[(grid.height - 1) * grid.width + col])
    }
    for row, i in empty_rows {
        left_steps_left[i] = max(0, steps - s_height_map[row * grid.width])
        right_steps_left[i] = max(0, steps - s_height_map[row * grid.width + grid.width - 2])
    }

    fmt.println(top_steps_left)
    assert(slice.simple_equal(top_steps_left, right_steps_left))
    assert(slice.simple_equal(bottom_steps_left, right_steps_left))
    // ALL THE SAME HEIGHTMAPS AND SUCH... SO WE CAN JUST CALC IN ONE DIRECTION
    // AND THEN CALC THE PARTIALS LATER
    steps_remaining := make([]int, len(top_steps_left))
    copy(steps_remaining, top_steps_left)

    steps_remaining[1] -= 1 // step into new grid
    steps_remaining[0] -= 2 // step over then up into diag grid
    steps_remaining[2] -= 2
    fmt.println("SR:", steps_remaining)
    // these are the same in all directions


    parities: [3]int
    for sr, i in steps_remaining {
        parities[i] = sr % 2
    }

    // four centers:
    mid_odd_parity := reachable(grid, bottom_row_heightmaps[1], (steps / 2) + 1)
    mid_even_parity := reachable(grid, bottom_row_heightmaps[1], steps / 2)

    mid_reachables: [4]int
    mid_height_maps: [4][]int
    mid_height_maps[0] = top_row_heightmaps[1]
    mid_height_maps[1] = left_column_heightmaps[1]
    mid_height_maps[2] = right_column_heightmaps[1]
    mid_height_maps[3] = bottom_row_heightmaps[1]
    mid_max_heights: [4]int
    mid_max_heights[0] = slice.max(top_row_heightmaps[1])
    mid_max_heights[1] = slice.max(left_column_heightmaps[1])
    mid_max_heights[2] = slice.max(right_column_heightmaps[1])
    mid_max_heights[3] = slice.max(bottom_row_heightmaps[1])
    mid_odd_parities: [4]int
    mid_odd_parities[0] = reachable(grid, top_row_heightmaps[1], (steps / 2) + 1)
    mid_odd_parities[1] = reachable(grid, left_column_heightmaps[1], (steps / 2) + 1)
    mid_odd_parities[2] = reachable(grid, right_column_heightmaps[1], (steps / 2) + 1)
    mid_odd_parities[3] = reachable(grid, bottom_row_heightmaps[1], (steps / 2) + 1)
    mid_even_parities: [4]int
    mid_even_parities[0] = reachable(grid, top_row_heightmaps[1], (steps / 2))
    mid_even_parities[1] = reachable(grid, left_column_heightmaps[1], (steps / 2))
    mid_even_parities[2] = reachable(grid, right_column_heightmaps[1], (steps / 2))
    mid_even_parities[3] = reachable(grid, bottom_row_heightmaps[1], (steps / 2))

    mid_full_grids: [4]int
    mid_steps_remaining: [4]int

    for m, i in mid_max_heights {
        mid_full_grids[i] = (steps_remaining[1] - m) / grid.height
        mid_steps_remaining[i] = (steps_remaining[1] % grid.height) + m
    }
    for {
        for i in 0..<len(mid_reachables) {
            mid_reachables[i] += reachable(grid, mid_height_maps[i], mid_steps_remaining[i])
            if mid_steps_remaining[i] > grid.height {
                mid_steps_remaining[i] -= grid.height
            } else {
                mid_steps_remaining[i] = 0
            }
        }
        if slice.all_of(mid_steps_remaining[:], 0) do break
    }

    fmt.println("MIDS:")
    fmt.println(mid_full_grids)
    fmt.println(mid_reachables)
    fmt.println("========")


    corner_max_heights: [4]int
    corner_reachables: [4]int
    corner_max_heights[0] = slice.max(top_row_heightmaps[0])
    corner_max_heights[1] = slice.max(top_row_heightmaps[2])
    corner_max_heights[2] = slice.max(bottom_row_heightmaps[0])
    corner_max_heights[3] = slice.max(bottom_row_heightmaps[2])
    
    corner_height_maps: [4][]int
    corner_height_maps[0] = top_row_heightmaps[0]
    corner_height_maps[1] = top_row_heightmaps[2]
    corner_height_maps[2] = bottom_row_heightmaps[0]
    corner_height_maps[3] = bottom_row_heightmaps[2]

    corner_odd_parities: [4]int
    corner_odd_parities[0] = reachable(grid, top_row_heightmaps[0], (steps / 2) + 1)
    corner_odd_parities[1] = reachable(grid, top_row_heightmaps[2], (steps / 2) + 1)
    corner_odd_parities[2] = reachable(grid, bottom_row_heightmaps[0], (steps / 2) + 1)
    corner_odd_parities[3] = reachable(grid, bottom_row_heightmaps[2], (steps / 2) + 1)

    corner_even_parities: [4]int
    corner_even_parities[0] = reachable(grid, top_row_heightmaps[0], (steps / 2))
    corner_even_parities[1] = reachable(grid, top_row_heightmaps[2], (steps / 2))
    corner_even_parities[2] = reachable(grid, bottom_row_heightmaps[0], (steps / 2))
    corner_even_parities[3] = reachable(grid, bottom_row_heightmaps[2], (steps / 2))

    corner_full_grids: [4]int
    corner_steps_remaining: [4]int

    for m, i in corner_max_heights {
        corner_full_grids[i] = (steps_remaining[0] - m) / grid.height
        corner_steps_remaining[i] = (steps_remaining[0] % grid.height) + m
    }
    for {
        for i in 0..<len(corner_reachables) {
            corner_reachables[i] += reachable(grid, corner_height_maps[i], corner_steps_remaining[i])
            if corner_steps_remaining[i] > grid.height {
                corner_steps_remaining[i] -= grid.height
            } else {
                corner_steps_remaining[i] = 0
            }
        }
        if slice.all_of(corner_steps_remaining[:], 0) do break
    }

    fmt.println("CORNERS:")
    fmt.println(corner_full_grids)
    fmt.println(corner_reachables)
    fmt.println("========")


    // MIDS SUM:
    mid_sum: int
    for fg, i in mid_full_grids {
        mid_sum += (fg + 1) / 2 * mid_odd_parities[i] + (fg / 2) * mid_even_parities[i]
    }
    mid_sum += math.sum(mid_reachables[:])

    // CORNERS:
    // something weird with the diagonals... need to do N full grids + n - 1 full grids + n - 2 full grids + ... + 
    corner_sum: int
    for fg, i in corner_full_grids {
        corner_sum += corner_reachables[i] * (fg + 1)
        num_odd_nums := (fg + 1) / 2
        num_even_nums := fg / 2
        corner_sum += num_odd_nums * num_odd_nums * corner_odd_parities[i]
        corner_sum += num_even_nums * (num_even_nums + 1) * corner_even_parities[i]
    }

    fmt.println(mid_sum, corner_sum)

    return mid_sum + corner_sum + center_reachable
}

// height map from a start point
reachable :: proc(grid: GridN, height_map: []int, steps: int) -> int {
    result: int
    step_parity := steps % 2
    for j in 0..<grid.height {
        for i in 0..<grid.width - 1 {
            idx := p2idx(Pos{i, j}, grid.width)
            height := height_map[idx]
            if height <= steps && (height % 2 == step_parity) {
                result += 1
            }
        }
    }

    return result
}

p2idx :: proc(p: Pos, w: int) -> int {
    return p.y * w + p.x
} 

Node2 :: struct {
    p: Pos,
    prev_height: int,
}

gen_heightmap :: proc(grid: GridN, start: Pos) -> []int {
    s_idx := start.y * grid.width + start.x

    height_grid := make([]int, grid.height * grid.width)
    slice.fill(height_grid, -1)

    queue: q.Queue(Node2)
    q.init(&queue)
    q.append(&queue, Node2{start, -1})

    offsets := [4]Pos{{0, -1}, {0, 1}, {-1, 0}, {1, 0}}

    valid :: proc(g: GridN, p: Pos) -> bool {
        return (p.x >= 0 && p.x < g.width) && (p.y >= 0 && p.y < g.height)
    }

    for q.len(queue) != 0 {
        next := q.pop_front(&queue)
        next_idx := next.p.y * grid.width + next.p.x
        if height_grid[next_idx] != -1 do continue
        
        if grid.data[next_idx] == '#' || grid.data[next_idx] == '\n' {
            height_grid[next_idx] = -2
            continue
        }

        nheight := 1 + next.prev_height
        height_grid[next_idx] = nheight

        neighbors := [4]Pos{offsets[0] + next.p, offsets[1] + next.p, offsets[2] + next.p, offsets[3] + next.p} 
        for n in neighbors {
            if valid(grid, n) {
                q.append(&queue, Node2{n, nheight})
            }
        }
    }

    return height_grid
}

main :: proc() {
    // arena_backing := make([]u8, 8 * mem.Megabyte)
    // solution_arena: mem.Arena
    // mem.arena_init(&solution_arena, arena_backing)

    // alloc := mem.arena_allocator(&solution_arena)
    // context.allocator = alloc
    // context.temp_allocator = alloc

    when AVG_RUNTIME {
        iters := 10_000
    } else {
        iters := 1
    }

    pt1_ans: int
    pt1_total_time: time.Duration
    for i in 0..<iters {
        pt1_start := time.now()
        pt1_ans = part_1(input, 64)
        pt1_end := time.now()
        pt1_total_time += time.diff(pt1_start, pt1_end)
        // free_all(context.allocator)
    }

    fmt.println("P1:", pt1_ans, "Time:", pt1_total_time / time.Duration(iters))

    // free_all(context.allocator)
    // solution_arena.peak_used = 0

    pt2_ans: int
    pt2_total_time: time.Duration
    for i in 0..<iters {
        pt2_start := time.now()
        pt2_ans = part_2(input, 26_501_365)
        pt2_end := time.now()
        pt2_total_time += time.diff(pt2_start, pt2_end)
        // free_all(context.allocator)
    }
    fmt.println("P2:", pt2_ans, "Time:", pt2_total_time / time.Duration(iters))

    // free_all(context.allocator)
    // solution_arena.peak_used = 0
}


@(test)
part_1_test :: proc(t: ^testing.T) {
    testing.expect_value(t, part_1(test_input, 6), 16)
}

@(test)
part_2_test :: proc(t: ^testing.T) {
    testing.expect_value(t, part_2(test_input, 6), 16)
    testing.expect_value(t, part_2(test_input, 10), 50)
    testing.expect_value(t, part_2(test_input, 50), 1594)
    // testing.expect_value(t, part_2(test_input, 100), 6536)
    // testing.expect_value(t, part_2(test_input, 500), 167004)
    // testing.expect_value(t, part_2(test_input, 1000), 668697)
    // testing.expect_value(t, part_2(test_input, 5000), 16733044)
}

@(disabled = !(ODIN_DEBUG || ODIN_TEST))
debug_print :: proc(args: ..any) {
    fmt.println(..args)
}

AVG_RUNTIME :: #config(AVG, false)

input := #load("./input.txt", string)
test_input := `...........
.....###.#.
.###.##..#.
..#.#...#..
....#.#....
.##..S####.
.##..#...#.
.......##..
.##.#.####.
.##..##.##.
...........
`
