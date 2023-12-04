package day4

import "core:fmt"
import "core:mem"
import "core:os"
import "core:slice"
import "core:strconv"
import "core:strings"
import "core:testing"
import "core:time"

part_1 :: proc(data: string) -> (total: int) {
    data := data
    winning := make([dynamic]int, 0, 10)
    have := make([dynamic]int, 0, 25)

    for line in strings.split_lines_iterator(&data) {
        line := line
        clear(&winning)
        clear(&have)
        colon := strings.index(line, ":")
        assert(colon != -1)
        line = line[colon + 2:]
        wins, _ := strings.split_iterator(&line, "|")
        hs, _ := strings.split_iterator(&line, "|")
        for w in strings.split_iterator(&wins, " ") {
            if len(w) == 0 do continue

            v, _ := strconv.parse_int(w)
            append(&winning, v)
        }

        for w in strings.split_iterator(&hs, " ") {
            if len(w) == 0 do continue

            v, _ := strconv.parse_int(w)
            append(&have, v)
        }

        win := winning[:]
        haves := have[:]
        slice.sort(win)
        slice.sort(haves)
        matches: int
        for len(win) > 0 && len(haves) > 0 {
            if haves[0] == win[0] {
                matches += 1
                haves = haves[1:]
                win = win[1:]
            } else if haves[0] < win[0] {
                haves = haves[1:]
            } else if win[0] < haves[0] {
                win = win[1:]
            }
        }

        if matches > 0 {
            points := 1
            for i in 1..<matches {
                points *= 2
            }
            total += points
        }        
    }

    return
}

part_2 :: proc(data: string) -> (total: int) {
    data := data
    winning := make([dynamic]int, 0, 10)
    have := make([dynamic]int, 0, 25)
    cards := make([]int, 250) // larger than we have
    slice.fill(cards[:], 1)

    card: int
    for line in strings.split_lines_iterator(&data) {
        line := line
        clear(&winning)
        clear(&have)
        colon := strings.index(line, ":")
        assert(colon != -1)
        line = line[colon + 2:]
        wins, _ := strings.split_iterator(&line, "|")
        hs, _ := strings.split_iterator(&line, "|")
        for w in strings.split_iterator(&wins, " ") {
            if len(w) == 0 do continue

            v, _ := strconv.parse_int(w)
            append(&winning, v)
        }

        for w in strings.split_iterator(&hs, " ") {
            if len(w) == 0 do continue

            v, _ := strconv.parse_int(w)
            append(&have, v)
        }

        win := winning[:]
        haves := have[:]
        slice.sort(win)
        slice.sort(haves)
        matches: int
        for len(win) > 0 && len(haves) > 0 {
            if haves[0] == win[0] {
                matches += 1
                haves = haves[1:]
                win = win[1:]
            } else if haves[0] < win[0] {
                haves = haves[1:]
            } else if win[0] < haves[0] {
                win = win[1:]
            }
        }
        
        for i in 1..=matches {
            cards[card + i] += cards[card]
        }
        card += 1
    }

    for c in cards[:card] {
        total += c
    }


    return
}

part_2_better :: proc(data: string) -> (total: int) {
    data := data
    winning := make([dynamic]u16, 0, 10)
    have := make([dynamic]u16, 0, 25)
    cards := make([]int, 250) // larger than we have
    slice.fill(cards[:], 1)

    card: int
    for line in strings.split_lines_iterator(&data) {
        line := line
        clear(&winning)
        clear(&have)
        colon := strings.index(line, ":")
        assert(colon != -1)
        line = line[colon + 2:]
        wins, _ := strings.split_iterator(&line, "|")
        hs, _ := strings.split_iterator(&line, "|")
        for w in strings.split_iterator(&wins, " ") {
            if len(w) == 0 do continue
            w := w
            v := cast(^u16) raw_data(w)
            append(&winning, v^)
        }

        for w in strings.split_iterator(&hs, " ") {
            if len(w) == 0 do continue

            w := w
            v := cast(^u16) raw_data(w)
            append(&have, v^)
        }

        win := winning[:]
        haves := have[:]
        slice.sort(win)
        slice.sort(haves)
        matches: int
        for len(win) > 0 && len(haves) > 0 {
            if haves[0] == win[0] {
                matches += 1
                haves = haves[1:]
                win = win[1:]
            } else if haves[0] < win[0] {
                haves = haves[1:]
            } else if win[0] < haves[0] {
                win = win[1:]
            }
        }
        
        for i in 1..=matches {
            cards[card + i] += cards[card]
        }
        card += 1
    }

    for c in cards[:card] {
        total += c
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

    ptb2_start := time.now()
    ptb2_ans := part_2_better(input)
    ptb2_end := time.now()
    fmt.println("P2 (better):", ptb2_ans, "Time:", time.diff(ptb2_start, ptb2_end), "Memory Used:", solution_arena.peak_used)

    free_all(context.allocator)
    solution_arena.peak_used = 0

}


@(test)
part_1_test :: proc(t: ^testing.T) {
    testing.expect_value(t, part_1(test_input), 13)
}

@(test)
part_2_test :: proc(t: ^testing.T) {
    testing.expect_value(t, part_2(test_input), 30)
}

input := #load("./input.txt", string)
test_input := `Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11`
