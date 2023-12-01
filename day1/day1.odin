package day1

import "core:fmt"
import "core:mem"
import "core:os"
import "core:testing"
import "core:time"
import "core:strings"

part_1 :: proc(data: string) -> int {
    data := data
    sum: int
    for line in strings.split_lines_iterator(&data) {
        first, last: int
        for c in line {
            if '0' <= c  && c <= '9' {
                first = int(c - '0')
                break
            }
        }
        #reverse for c in line {
            if '0' <= c && c <= '9' {
                last = int(c - '0')
                break
            }
        }
        sum += (first * 10 + last)
    }
    return sum
}

part_2 :: proc(data: string) -> int {
    data := data
    sum: int
    for line in strings.split_lines_iterator(&data) {
        line := line
        first, last: int
        loop1: for i in 0..<len(line) {
            c := line[i]
            switch c {
            case 'o':
                if strings.has_prefix(line[i:], "one") {
                    first = 1
                    break loop1
                }
            case 't':
                if strings.has_prefix(line[i:], "two") {
                    first = 2
                    break loop1
                } else if strings.has_prefix(line[i:], "three") {
                    first = 3
                    break loop1
                }
            case 'f':
                if strings.has_prefix(line[i:], "four") {
                    first = 4
                    break loop1
                } else if strings.has_prefix(line[i:], "five") {
                    first = 5
                    break loop1
                }
            case 's':
                if strings.has_prefix(line[i:], "six") {
                    first = 6
                    break loop1
                } else if strings.has_prefix(line[i:], "seven") {
                    first = 7
                    break loop1
                }
            case 'e':
                if strings.has_prefix(line[i:], "eight") {
                    first = 8
                    break loop1
                }
            case 'n':
                if strings.has_prefix(line[i:], "nine") {
                    first = 9
                    break loop1
                }
            case '0'..='9':
                first = int(c - '0')
                break loop1
            }
        }

        loop2: for i := len(line) - 1; i >= 0; i -= 1 {
            c := line[i]
            switch c {
            case 'o':
                if strings.has_prefix(line[i:], "one") {
                    last = 1
                    break loop2
                }
            case 't':
                if strings.has_prefix(line[i:], "two") {
                    last = 2
                    break loop2
                } else if strings.has_prefix(line[i:], "three") {
                    last = 3
                    break loop2
                }
            case 'f':
                if strings.has_prefix(line[i:], "four") {
                    last = 4
                    break loop2
                } else if strings.has_prefix(line[i:], "five") {
                    last = 5
                    break loop2
                }
            case 's':
                if strings.has_prefix(line[i:], "six") {
                    last = 6
                    break loop2
                } else if strings.has_prefix(line[i:], "seven") {
                    last = 7
                    break loop2
                }
            case 'e':
                if strings.has_prefix(line[i:], "eight") {
                    last = 8
                    break loop2
                }
            case 'n':
                if strings.has_prefix(line[i:], "nine") {
                    last = 9
                    break loop2
                }
            case '0'..='9':
                last = int(c - '0')
                break loop2
            }
        }

        sum += (first * 10 + last)
    }

    return sum
}

main :: proc() {
    arena_backing := make([]u8, 8 * mem.Megabyte)
    solution_arena: mem.Arena
    mem.arena_init(&solution_arena, arena_backing)

    alloc := mem.arena_allocator(&solution_arena)
    context.allocator = alloc

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
    testing.expect_value(t, part_1(test_input), 142)
}

@(test)
part_2_test :: proc(t: ^testing.T) {
    testing.expect_value(t, part_2(pt2_test_input), 281)
}

input := #load("./input.txt", string)
test_input := `1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet`

pt2_test_input := `two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen`