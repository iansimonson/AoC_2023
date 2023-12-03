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

    near_symbol :: proc(grid: []u8, idx, width: int) -> bool {
        neighbors := []int{idx - width - 1, idx - width, idx - width + 1, idx - 1, idx + 1, idx + width - 1, idx + width, idx + width + 1}
        for n in neighbors {
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
        switch v {
        case '0'..='9':
            if near_symbol(data, i, grid_width) {
                num_start := i
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

                num_end := i
                l_end: for num_end <= len(data) {
                    switch data[num_end] {
                    case '0'..='9':
                        num_end += 1
                    case:
                        break l_end// end of ranges is exclusive
                    }
                }
                value, _ := strconv.parse_int(string(data[num_start:num_end]))
                total += value
                i = num_end
                continue
            }
        }
        i += 1
    }
    
    return
}

part_2 :: proc(data: []u8) -> (total: int) {
    newline := strings.index(string(data), "\n")
    assert(newline != -1)
    grid_width := newline + 1

    for i in 0..<len(data) {
        switch data[i] {
        case '*':
            p1, p2 := -1, -1
            top_row_one_num: bool
            bottom_row_one_num: bool
            // find if two gears
            // at most 2 nums above, 2 below or one to each side
            if i - 1 >= 0 && is_digit(data[i-1]) {
                ns := num_start(data, i - 1)
                p1, _ = strconv.parse_int(string(data[ns:i]))
            }
            if i + 1 < len(data) && is_digit(data[i + 1]) {
                ns := num_end(data, i + 1)
                v, _ := strconv.parse_int(string(data[i + 1:ns]))
                if p1 == -1 {
                    p1 = v
                } else {
                    p2 = v
                }
            }

            if i - grid_width - 1 >= 0 && is_digit(data[i - grid_width - 1]) {
                if p1 != -1 && p2 != -1 do continue // more than 2 part numbers, not a gear

                ns := num_start(data, i - grid_width - 1)
                ne := num_end(data, i - grid_width - 1)

                v, _ := strconv.parse_int(string(data[ns:ne]))
                if p1 == -1 do p1 = v
                else do p2 = v

                if ne > i - grid_width do top_row_one_num = true
            }

            if !top_row_one_num && i - grid_width >= 0 && is_digit(data[i - grid_width]) {
                if p1 != -1 && p2 != -1 do continue // more than 2 part numbers, not a gear

                ns := num_start(data, i - grid_width)
                ne := num_end(data, i - grid_width)

                v, _ := strconv.parse_int(string(data[ns:ne]))
                if p1 == -1 do p1 = v
                else do p2 = v

                top_row_one_num = true
            }

            if !top_row_one_num && i - grid_width + 1 >= 0 && is_digit(data[i - grid_width + 1]) {
                if p1 != -1 && p2 != -1 do continue // more than 2 part numbers, not a gear

                ns := num_start(data, i - grid_width + 1)
                ne := num_end(data, i - grid_width + 1)

                v, _ := strconv.parse_int(string(data[ns:ne]))
                if p1 == -1 do p1 = v
                else do p2 = v
            }

            if i + grid_width - 1 < len(data) && is_digit(data[i + grid_width - 1]) {
                if p1 != -1 && p2 != -1 do continue // more than 2 part numbers, not a gear

                ns := num_start(data, i + grid_width - 1)
                ne := num_end(data, i + grid_width - 1)

                v, _ := strconv.parse_int(string(data[ns:ne]))
                if p1 == -1 do p1 = v
                else do p2 = v

                if ne > i + grid_width do bottom_row_one_num = true
            }

            if !bottom_row_one_num && i + grid_width < len(data) && is_digit(data[i + grid_width]) {
                if p1 != -1 && p2 != -1 do continue // more than 2 part numbers, not a gear

                ns := num_start(data, i + grid_width)
                ne := num_end(data, i + grid_width)

                v, _ := strconv.parse_int(string(data[ns:ne]))
                if p1 == -1 do p1 = v
                else do p2 = v


                bottom_row_one_num = true
            }

            if !bottom_row_one_num && i + grid_width + 1 < len(data) && is_digit(data[i + grid_width + 1]) {
                if p1 != -1 && p2 != -1 do continue // more than 2 part numbers, not a gear

                ns := num_start(data, i + grid_width + 1)
                ne := num_end(data, i + grid_width + 1)

                v, _ := strconv.parse_int(string(data[ns:ne]))
                if p1 == -1 do p1 = v
                else do p2 = v
            }

            if p1 != -1 && p2 != -1 {
                total += p1 * p2
            }

        case:
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