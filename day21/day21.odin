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

part_2 :: proc(data: string, steps: int) -> (result: int) {
    data := data
    newline := strings.index_byte(data, '\n')
    width := newline + 1
    height := len(data) / width

    grid := GridN{transmute([]u8) data, width, height}

    s_idx := strings.index_byte(data, 'S')
    s_pos := Pos{s_idx % width, s_idx / width}

    s_height_map := gen_heightmap(grid, s_pos)

    d1, d2, d3, d4 := Pos{0, 0}, Pos{newline - 1, 0}, Pos{0, height - 1}, Pos{newline - 1, height - 1}
    d1_idx, d2_idx, d3_idx, d4_idx := p2idx(d1, width), p2idx(d2, width), p2idx(d3, width), p2idx(d4, width)
    s_d1, s_d2, s_d3, s_d4 := s_height_map[d1_idx], s_height_map[d2_idx], s_height_map[d3_idx], s_height_map[d4_idx]

    fmt.println(steps)
    debug_print(s_d1, s_d2, s_d3, s_d4)
    result += reachable(grid, s_height_map, steps)

    steps_left := [4]int{steps - s_d1, steps - s_d2, steps - s_d3, steps - s_d4}
    steps_left[0] = max(0, steps_left[0])
    steps_left[1] = max(0, steps_left[1])
    steps_left[2] = max(0, steps_left[2])
    steps_left[3] = max(0, steps_left[3])
    print_heightmap(s_height_map, grid.width)
    fmt.println(steps_left)
    if math.sum(steps_left[:]) <= 0 do return // we finish in S_0

    d1_height_map := gen_heightmap(grid, Pos{0, 0})
    d2_height_map := gen_heightmap(grid, Pos{newline - 1, 0})
    d3_height_map := gen_heightmap(grid, Pos{0, height - 1})
    d4_height_map := gen_heightmap(grid, Pos{newline - 1, height - 1})

    d1_full_reachable: [2]int
    d2_full_reachable: [2]int
    d3_full_reachable: [2]int
    d4_full_reachable: [2]int

    // calc fully reachable squares based on parity of step count
    d1_full_reachable[steps % 2], d1_full_reachable[ (steps + 1) % 2] = reachable(grid, d1_height_map, steps), reachable(grid, d1_height_map, steps + 1)
    d2_full_reachable[steps % 2], d2_full_reachable[ (steps + 1) % 2] = reachable(grid, d2_height_map, steps), reachable(grid, d2_height_map, steps + 1)
    d3_full_reachable[steps % 2], d3_full_reachable[ (steps + 1) % 2] = reachable(grid, d3_height_map, steps), reachable(grid, d3_height_map, steps + 1)
    d4_full_reachable[steps % 2], d4_full_reachable[ (steps + 1) % 2] = reachable(grid, d4_height_map, steps), reachable(grid, d4_height_map, steps + 1)

    // just a helper function
    calc_in_dir :: proc(grid: GridN, steps_left, mod_size: int, height_map: []int, full_reach: [2]int) -> (dim, n_reachable, part_reachable: int) {
        if steps_left > 0 {
            remaining_steps :=  steps_left - 1
            full_squares := remaining_steps / mod_size
            end_steps := remaining_steps % mod_size
            fulls := (full_squares + 1) / 2 * full_reach[remaining_steps % 2] + full_squares / 2 * full_reach[(remaining_steps + 1) % 2]
            ends := reachable(grid, height_map, end_steps)

            dim = full_squares + 1
            n_reachable = fulls + ends
            part_reachable = ends
        }
        return
    }

    d1_left_dim, d1_left_reachable, d1_left_partial := calc_in_dir(grid, steps_left[0], grid.width - 1, d2_height_map, d2_full_reachable)
    d1_up_dim, d1_up_reachable, d1_up_partial := calc_in_dir(grid, steps_left[0], grid.height, d3_height_map, d3_full_reachable)
    
    d2_right_dim, d2_right_reachable, d2_right_partial := calc_in_dir(grid, steps_left[1], grid.width - 1, d1_height_map, d1_full_reachable)
    d2_up_dim, d2_up_reachable, d2_up_partial := calc_in_dir(grid, steps_left[1], grid.height, d4_height_map, d4_full_reachable)

    d3_left_dim, d3_left_reachable, d3_left_partial := calc_in_dir(grid, steps_left[2], grid.width - 1, d4_height_map, d4_full_reachable)
    d3_down_dim, d3_down_reachable, d3_down_partial := calc_in_dir(grid, steps_left[2], grid.height, d1_height_map, d1_full_reachable)

    d4_right_dim, d4_right_reachable, d4_right_partial := calc_in_dir(grid, steps_left[3], grid.width - 1, d3_height_map, d3_full_reachable)
    d4_down_dim, d4_down_reachable, d4_down_partial := calc_in_dir(grid, steps_left[3], grid.height, d2_height_map, d2_full_reachable)

    max_left_dim := max(d1_left_dim, d3_left_dim)
    max_up_dim := max(d1_up_dim, d2_up_dim)
    max_right_dim := max(d2_right_dim, d4_right_dim)
    max_down_dim := max(d3_down_dim, d4_down_dim)

    // printed to prove it's NxN so just choose 1
    N := max_left_dim
    ND_partial := max_left_dim - 1
    ND_full := max_left_dim - 2

    Start_Parity_Count: int
    Other_Parity_Count: int
    for i in 1..=ND_full {
        if i % 2 == 1 {
            Other_Parity_Count += i
        } else {
            Start_Parity_Count += i
        }
    }
    parity_end_diag := (ND_partial % 2 == 1)

    max_left_reachable := max(d1_left_reachable, d3_left_reachable)
    max_up_reachable := max(d1_up_reachable, d2_up_reachable)
    max_right_reachable := max(d2_right_reachable, d4_right_reachable)
    max_down_reachable := max(d3_down_reachable, d4_down_reachable)

    result += max_left_reachable + max_right_reachable + max_left_reachable + max_down_reachable

    // left/up diagonal (n - 2)*(d4_full) d1 -> d4
    ld_sr := steps_left[0] - 1
    result += Start_Parity_Count * d4_full_reachable[ld_sr % 2] + Other_Parity_Count * d4_full_reachable[(ld_sr + 1) % 2]
    result += ND_partial * d3_left_partial

    // up/right diagonal - entering d2 -> d3
    // don't care at this point just want the parity
    urd_sr := steps_left[1] - 1
    result += Start_Parity_Count * d3_full_reachable[urd_sr % 2] + Other_Parity_Count * d3_full_reachable[(urd_sr + 1) % 2]
    result += ND_partial * d4_right_partial

    // right/down diagonal - entering d4 -> d1
    rdd_sr := steps_left[3] - 1
    result += Start_Parity_Count * d1_full_reachable[rdd_sr % 2] + Other_Parity_Count * d1_full_reachable[(rdd_sr + 1) % 2]
    result += ND_partial * d4_down_partial

    // down/left diagonal - entering d3 -> d2
    dld_sr := steps_left[2] - 1
    result += Start_Parity_Count * d2_full_reachable[dld_sr % 2] + Other_Parity_Count * d2_full_reachable[(dld_sr + 1) % 2]
    result += ND_partial * d3_down_partial

    return result
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
            height_grid[next_idx] = max(int)
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
        pt1_ans = part_1(input, 64)
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
        pt2_ans = part_2(input, 26_501_365)
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
    testing.expect_value(t, part_1(test_input, 6), 16)
}

@(test)
part_2_test :: proc(t: ^testing.T) {
    testing.expect_value(t, part_2(test_input, 6), 16)
    testing.expect_value(t, part_2(test_input, 10), 50)
    // testing.expect_value(t, part_2(test_input, 50), 1594)
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
