package day3

import "core:fmt"
import "core:mem"
import "core:os"
import "core:strconv"
import "core:strings"
import "core:testing"
import "core:time"
import "core:slice"

part_1 :: proc(data: []u8) -> (total: int) {
    data := data

    newline := strings.index(string(data), "\n")
    assert(newline != -1)
    grid_width := newline + 1

    offsets := []int{-grid_width - 1, -grid_width, -grid_width + 1, -1, +1, grid_width - 1, grid_width, grid_width + 1}

    near_symbol :: proc(grid: []u8, offsets: []int, idx: int) -> bool {
        for offset in offsets {
            n := idx + offset
            if n < 0 || n > len(grid) do continue
            switch grid[n] {
            case '0'..='9', '.', '\n':
                // not a symbol
            case:
                return true
            }
        }
        return false
    }
    
    for i := 0; i < len(data); {
        v := data[i]
        if is_digit(v) && near_symbol(data, offsets, i) {
            ns, ne := num_start(data, i), num_end(data, i)
            value, _ := strconv.parse_int(string(data[ns:ne]))
            total += value
            i = ne
            continue
        } else {
            i += 1
        }
    }
    
    return
}

part_2 :: proc(data: []u8) -> (total: int) {
    newline := strings.index(string(data), "\n")
    assert(newline != -1)
    grid_width := newline + 1

    parse_part :: proc(data: []u8, offset: int, p1, p2: ^int) {
        ns := num_start(data, offset)
        ne := num_end(data, offset)
        v, _ := strconv.parse_int(string(data[ns:ne]))
        if p1^ == -1 do p1^ = v
        else do p2^ = v
    }

    for i in 0..<len(data) {
        if data[i] == '*' {
            p1, p2 := -1, -1

            if i - 1 >= 0 && is_digit(data[i-1]) {
                ns := num_start(data, i - 1)
                p1, _ = strconv.parse_int(string(data[ns:i]))
            }

            if i + 1 < len(data) && is_digit(data[i + 1]) {
                parse_part(data, i + 1, &p1, &p2)
            }

            // if the top center is a digit then we only have a single
            // number in the top row that is adjacent
            if i - grid_width >= 0 && is_digit(data[i - grid_width]) {
                if p1 != -1 && p2 != -1 do continue // more than 2 part numbers, not a gear

                parse_part(data, i - grid_width, &p1, &p2)
            } else {
                // we _might_ have two numbers, one that ends at top left and one that starts at top right
                if i - grid_width - 1 >= 0 && is_digit(data[i - grid_width - 1]) {
                    if p1 != -1 && p2 != -1 do continue
    
                    parse_part(data, i - grid_width - 1, &p1, &p2)
                }

                if  i - grid_width + 1 >= 0 && is_digit(data[i - grid_width + 1]) {
                    if p1 != -1 && p2 != -1 do continue
    
                    parse_part(data, i - grid_width + 1, &p1, &p2)
                }
            }

            // same here, check center bottom first to see if we have a single
            // or possibly two numbers
            if i + grid_width < len(data) && is_digit(data[i + grid_width]) {
                if p1 != -1 && p2 != -1 do continue

                parse_part(data, i + grid_width, &p1, &p2)
            } else {
                if i + grid_width - 1 < len(data) && is_digit(data[i + grid_width - 1]) {
                    if p1 != -1 && p2 != -1 do continue
    
                    parse_part(data, i + grid_width - 1, &p1, &p2)
                }

                if i + grid_width + 1 < len(data) && is_digit(data[i + grid_width + 1]) {
                    if p1 != -1 && p2 != -1 do continue
    
                    parse_part(data, i + grid_width + 1, &p1, &p2)
                }
            }

            if p1 != -1 && p2 != -1 {
                total += p1 * p2
            }
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

    pt2_start := time.now()
    pt2_ans := part_2(input)
    pt2_end := time.now()
    fmt.println("P2:", pt2_ans, "Time:", time.diff(pt2_start, pt2_end), "Memory Used:", solution_arena.peak_used)

    free_all(context.allocator)
}


@(test)
part_1_test :: proc(t: ^testing.T) {
    testing.expect_value(t, part_1(transmute([]u8) test_input), 4361)
}

@(test)
part_2_test :: proc(t: ^testing.T) {
    testing.expect_value(t, part_2(transmute([]u8) test_input), 467835)
}

input := #load("./input.txt")
test_input := `467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..`


num_start :: proc(data: []u8, start: int) -> (num_start: int) {
    num_start = start
    l_start: for num_start >= 0 {
        switch data[num_start] {
        case '0'..='9':
            num_start -= 1
        case:
            num_start += 1
            break l_start
        }
    }
    num_start = max(0, num_start)
    return
}

num_end :: proc(data: []u8, start: int) -> (num_end: int) {
    num_end = start
    l_end: for num_end <= len(data) {
        switch data[num_end] {
        case '0'..='9':
            num_end += 1
        case:
            break l_end// end of ranges is exclusive
        }
    }
    return
}

is_digit :: proc(c: u8) -> bool {
    return '0' <= c && c <= '9'
}