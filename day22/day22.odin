package day22

import "core:fmt"
import "core:math"
import "core:math/linalg"
import "core:mem"
import "core:os"
import "core:slice"
import "core:strconv"
import "core:strings"
import "core:testing"
import "core:time"

Block :: struct {
    start, end: [3]int
}

part_1 :: proc(data: string) -> int {
    z_levels := make([dynamic][dynamic]Block, 1000)
    blocks := make([dynamic]Block, 0, 100)

    parse_and_land_blocks(data, &z_levels, &blocks)

    result: int
    block_outer: for block in blocks {
        fellow_blocks := &z_levels[block.end.z]
        z_outer: for above_block in z_levels[block.end.z + 1] {
            if intersects(block, above_block) {
                debug_print("Block", block, "intersects", above_block)
                for fellow_block in fellow_blocks {
                    if intersects(fellow_block, block) do continue // not going to be equal
                    if intersects(fellow_block, above_block) {
                        debug_print("Block", block, "intersects", above_block, "but is supported by", fellow_block)
                        continue z_outer
                    }
                }
                debug_print("Block", block, "intersects", above_block, "not supported. cannot delete")
                continue block_outer
            }
        }
        debug_print("Block", block, "has no blocks above or is fully supported")
        result += 1
    }

    return result
}

part_2 :: proc(data: string) -> int {
    z_levels := make([dynamic][dynamic]Block, 1000)
    blocks := make([dynamic]Block, 0, 100)

    parse_and_land_blocks(data, &z_levels, &blocks)

    supports := make(map[Block][dynamic]Block)
    for block in blocks {
        supports[block] = {}
        for block_below in z_levels[block.start.z - 1] {
            if intersects(block, block_below) {
                append(&supports[block], block_below)
            }
        }
    }

    blocks_moved: map[Block]struct{}

    result: int
    for block in blocks {
        debug_print("Checking block", block)
        clear(&blocks_moved)
        blocks_moved[block] = {}
        blocks_to_check: for other in blocks {
            if other == block do continue
            if other.start.z <= block.end.z do continue

            for b in supports[other] {
                if b not_in blocks_moved do continue blocks_to_check
            }
            debug_print("Block", other, "moves if", block, "deleted")
            blocks_moved[other] = {}
        }
        debug_print("Block", block, "moved", len(blocks_moved) - 1, "blocks")
        result += len(blocks_moved) - 1
    }

    return result
}

parse_and_land_blocks :: proc(data: string, z_levels: ^[dynamic][dynamic]Block, blocks: ^[dynamic]Block) {
    data := data
    cur_z_level: [10][10]int

    for line in strings.split_lines_iterator(&data) {
        line := line
        start_coords, _ := strings.split_by_byte_iterator(&line, '~')
        end_coords, _ := strings.split_by_byte_iterator(&line, '~')
        start_block: [3]int
        end_block: [3]int
        for i in 0..<3 {
            s, _ := strings.split_by_byte_iterator(&start_coords, ',')
            e, _ := strings.split_by_byte_iterator(&end_coords, ',')
            start_block[i] = strconv.atoi(s)
            end_block[i] = strconv.atoi(e)
        }
        append(blocks, Block{start_block, end_block})
    }
    debug_print(blocks)

    slice.sort_by(blocks[:], proc(i, j: Block) -> bool { return i.start.z < j.start.z})
    for &block in blocks {
        vec := block.end.xy - block.start.xy
        len := max(vec.x, vec.y) + 1 // inclusive range
        s := block.start.xy
        dir := [2]int{int(vec.x != 0), int(vec.y != 0)}
        min_z := 0
        for i in 0..< len {
            min_z = max(min_z, cur_z_level[s.y][s.x])
            s += dir
        }
        min_z += 1 //ground is zero, lowest block is 1
        z_diff := block.start.z - min_z
        block.start.z = min_z
        block.end.z -= z_diff
        
        s = block.start.xy
        for i in 0..< len {
            cur_z_level[s.y][s.x] = block.end.z
            s += dir
        }
    }

    for block in blocks {
        if block.start.z != block.end.z {
            for i in block.start.z..=block.end.z {
                append(&z_levels[i], block)
            }
        } else {
            append(&z_levels[block.start.z], block)
        }
    }
}

intersects :: proc(a, b: Block) -> bool {
    // we can discard z values
    a_vec := a.end.xy - a.start.xy
    b_vec := b.end.xy - b.start.xy

    // debug_print(a, a_vec)
    // debug_print(b, b_vec)

    // parallel and in same row/col
    if a_vec.x == 0 && b_vec.x == 0 {
        if a.start.x == b.start.x {
            return ((a.start.y <= b.end.y && a.start.y >= b.start.y) || (a.end.y <= b.end.y && a.end.y >= b.start.y)) || ((b.start.y <= a.end.y && b.start.y >= a.start.y) || (b.end.y <= a.end.y && b.end.y >= a.start.y))
        } else {
            return false
        }
    } else if a_vec.y == 0 && b_vec.y == 0 {
        if a.start.y == b.start.y {
            return ((a.start.x <= b.end.x && a.start.x >= b.start.x) || (a.end.x <= b.end.x && a.end.x >= b.start.x)) || ((b.start.x <= a.end.x && b.start.x >= a.start.x) || (b.end.x <= a.end.x && b.end.x >= a.start.x))
        } else {
            return false
        }
    }

    // inherently perpendicular
    return ((a.start.x <= b.start.x && a.end.x >= b.end.x) && (b.start.y <= a.start.y && b.end.y >= a.start.y)) ||
        ((a.start.y <= b.start.y && a.end.y >= b.end.y) && (b.start.x <= a.start.x && b.end.x >= a.end.x))
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
        pt1_ans = part_1(input)
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
    testing.expect_value(t, part_1(test_input), 5)
}

@(test)
part_2_test :: proc(t: ^testing.T) {
    testing.expect_value(t, part_2(test_input), 7)
}

@(disabled = !(ODIN_DEBUG || ODIN_TEST))
debug_print :: proc(args: ..any) {
    fmt.println(..args)
}

AVG_RUNTIME :: #config(AVG, false)

input := #load("./input.txt", string)
test_input := `1,0,1~1,2,1
0,0,2~2,0,2
0,2,3~2,2,3
0,0,4~0,2,4
2,0,5~2,2,5
0,1,6~2,1,6
1,1,8~1,1,9`
