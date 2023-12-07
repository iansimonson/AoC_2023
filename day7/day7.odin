package day7

import "core:fmt"
import "core:mem"
import "core:os"
import "core:strconv"
import "core:strings"
import "core:testing"
import "core:time"

Hands :: bit_set[Hand_Type;u32]
Hand_Type :: enum {
    High,
    Pair,
    Two_Pair,
    Three_Kind,
    Full_House,
    Four_Kind,
    Five_Kind,
}

part_1 :: proc(data: string) -> int {
    
    matches: [max(u8)]u8
    all_hands := make([dynamic]u64, 0, 150)
    all_bets := make([dynamic]int, 0, 150)
    buffer: [8]u8
    hand_idx := 3
    hand: Hands
    for c, i in data {
        switch c {
        case '0'..='9', 'T', 'J', 'Q', 'K', 'A':
            buffer[hand_idx] = u8(c)
            matches[int(c)] += 1
            if hand == {} do hand = {.High}
            else if hand == {.High} && matches[int(c)] == 1 {
                // nothing
            } else if hand == {.High} && matches[int(c)] == 2 {
                hand = {.Pair}
            }
        case ' ':

        }
    }
}

part_2 :: proc(data: string) -> int {
    return 0
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
    testing.expect_value(t, part_1(test_input), 6440)
}

@(test)
part_2_test :: proc(t: ^testing.T) {
    testing.expect_value(t, part_2(test_input), 1234)
}

input := #load("./input.txt", string)
test_input := `32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483`
