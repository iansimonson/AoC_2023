package day7

import "core:fmt"
import "core:mem"
import "core:os"
import "core:slice"
import "core:strconv"
import "core:strings"
import "core:testing"
import "core:time"

// the bit_set is just a nicety
// could easily just do 1 << Hand_Type
// ourself
Hand :: bit_set[Hand_Type;u8]
Hand_Type :: enum {
    High,
    Pair,
    Two_Pair,
    Three_Kind,
    Full_House,
    Four_Kind,
    Five_Kind,
}

hand_transition :: #force_inline proc(hand: Hand_Type, match_val: u8, loc := #caller_location) -> (result: Hand_Type) {
    result = hand
    switch hand {
    case .High:
        if match_val == 2 do result = .Pair
        else do assert(match_val == 1, loc = loc)
    case .Pair:
        if match_val == 2 do result = .Two_Pair
        else if match_val == 3 do result = .Three_Kind
        else do assert(match_val == 1, loc = loc)
    case .Two_Pair:
        if match_val == 3 do result = .Full_House
        else do assert(match_val == 1, loc = loc)
    case .Three_Kind:
        if match_val == 2 do result = .Full_House
        else if match_val == 4 do result = .Four_Kind
        else do assert(match_val == 1, loc = loc)
    case .Four_Kind:
        if match_val == 5 do result = .Five_Kind
        else do assert(match_val == 1, loc = loc)
    case .Five_Kind, .Full_House:
        // can only transition to this shouldn't be in this state here
        assert(false, loc = loc)
    case:
        assert(false, loc = loc)
    }
    return
}

CHAR_MAP := [26]u8 {
    'T' - 'A' = 10,
    'J' - 'A' = 11,
    'Q' - 'A' = 12,
    'K' - 'A' = 13,
    'A' - 'A' = 14,
}

CHAR_MAP_2 := [26]u8 {
    'T' - 'A' = 10,
    'Q' - 'A' = 12,
    'K' - 'A' = 13,
    'A' - 'A' = 14,
}

CHAR_MAP_3 := [255]u8 {
    'T' = 10,
    'Q' = 12,
    'K' = 13,
    'A' = 14,
    '2'  = 2,
    '3'  = 3,
    '4'  = 4,
    '5'  = 5,
    '6'  = 6,
    '7'  = 7,
    '8'  = 8,
    '9'  = 9,
}

bet_mask: u64 = 0xFFFF

part_1 :: proc(data: string) -> int {
    all_hands := make([dynamic]u64, 0, 150)

    matches: [15]u8 // map of our current hand
    buffer: [8]u8 // for fun :)
    hand_idx := 1
    bet: u16
    hand: Hand_Type // nil == High
    for c, i in data {
        switch c {
        case '0' ..= '9':
            if hand_idx < 6 {     // parsing hand still
                buffer[hand_idx] = u8(c) - '0'
                hand_idx += 1
                matches[c - '0'] += 1
                match_val := matches[c - '0']

                hand = hand_transition(hand, match_val)

            } else {
                bet = bet * 10 + u16(c - '0')
            }
        case 'T', 'J', 'Q', 'K', 'A':
            num_val := CHAR_MAP[c - 'A']
            buffer[hand_idx] = num_val
            hand_idx += 1
            matches[num_val] += 1
            match_val := matches[num_val]

            hand = hand_transition(hand, match_val)
        case ' ':
            hand_val := transmute(u8) Hand{hand}
            buffer[0] = hand_val
        case '\n':
            buf_val := u64(transmute(u64be)buffer)
            buf_val += u64(bet)

            append(&all_hands, buf_val)
            hand_idx = 1
            matches = {}
            hand = .High
            bet = 0

        }
    }
    slice.sort_by(all_hands[:], proc(p1, p2: u64) -> bool {
        return (p1 & ~bet_mask) < (p2 & ~bet_mask)
    });

    result: int
    for hand, i in all_hands {
        result += (i + 1) * int(hand & bet_mask)
    }
    return result
}

part_2 :: proc(data: string) -> int {
    all_hands := make([dynamic]u64, 0, 150)

    // all_hands := make([dynamic][2]u64, 0, 150)
    matches: [15]u8 // map of our current hand
    buffer: [8]u8 // for fun :)
    hand_idx := 1
    bet: u16
    hand: Hand_Type // nil == High
    jokers: int
    for c, i in data {
        switch c {
        case '0' ..= '9':
            if hand_idx < 6 {     // parsing hand still
                buffer[hand_idx] = u8(c) - '0'
                hand_idx += 1
                matches[c - '0'] += 1
                match_val := matches[c - '0']

                hand = hand_transition(hand, match_val)

            } else {
                bet = bet * 10 + u16(c - '0')
            }
        case 'T', 'Q', 'K', 'A':
            num_val := CHAR_MAP[c - 'A']
            buffer[hand_idx] = num_val
            hand_idx += 1
            matches[num_val] += 1
            match_val := matches[num_val]

            hand = hand_transition(hand, match_val)
        case 'J':
            buffer[hand_idx] = 0
            hand_idx += 1 // jokers are value 0 for tie break
            jokers += 1
            // save transition till the end
        case ' ':
            // card value itself only matters for tie breaking not hand value
            // but also account for hand of all jokers
            max_match := slice.max_index(matches[2:]) + 2
            for _ in 0..<jokers {
                matches[max_match] += 1
                match_val := matches[max_match]
                hand = hand_transition(hand, match_val)
            }

            hand_val := transmute(u8) Hand{hand}
            buffer[0] = hand_val
        case '\n':
            buf_val := u64(transmute(u64be)buffer)
            buf_val += u64(bet)

            append(&all_hands, buf_val)
            hand_idx = 1
            matches = {}
            hand = .High
            bet = 0
            jokers = 0

        }
    }

    slice.sort_by(all_hands[:], proc(p1, p2: u64) -> bool {
        return (p1 & ~(bet_mask)) < (p2 & ~(bet_mask))
    });

    result: int
    for hand, i in all_hands {
        result += (i + 1) * int(hand & bet_mask)
    }
    return result
}

fast_hands := make([dynamic]u64, 0, 1000)

Parse_State :: enum {
    Hand,
    Bet,
}

super_speedy_part_2 :: proc(data: string) -> int {
    clear(&fast_hands)

    // all_hands := make([dynamic][2]u64, 0, 150)
    matches: [15]u8 // map of our current hand
    buffer: [8]u8 // for fun :)
    hand_idx := 1
    bet: u16
    hand: Hand_Type // nil == High
    jokers: int
    state: Parse_State
    for i := 0; i < len(data); {
        c := data[i]
        if state == .Hand {
            is_valid := ('2' <= c && c <= '9') || (c == 'T') || c == 'J' || c == 'Q' || c == 'K' || c == 'A'
            assert(is_valid)

            { // manually unroll loop
                c := data[i + 0]
                offset := CHAR_MAP_3[c]
                buffer[hand_idx + 0] = offset

                if c != 'J' {
                    matches[offset] += 1
                    match_val := matches[offset]
    
                    hand = hand_transition(hand, match_val)
                } else {
                    jokers += 1
                }
            }
            { // 1
                c := data[i + 1]
                offset := CHAR_MAP_3[c]
                buffer[hand_idx + 1] = offset

                if c != 'J' {
                    matches[offset] += 1
                    match_val := matches[offset]
    
                    hand = hand_transition(hand, match_val)
                } else {
                    jokers += 1
                }
            }
            { // 2
                c := data[i + 2]
                offset := CHAR_MAP_3[c]
                buffer[hand_idx + 2] = offset

                if c != 'J' {
                    matches[offset] += 1
                    match_val := matches[offset]
    
                    hand = hand_transition(hand, match_val)
                } else {
                    jokers += 1
                }
            }
            { // 3
                c := data[i + 3]
                offset := CHAR_MAP_3[c]
                buffer[hand_idx + 3] = offset

                if c != 'J' {
                    matches[offset] += 1
                    match_val := matches[offset]
    
                    hand = hand_transition(hand, match_val)
                } else {
                    jokers += 1
                }
            }
            { // 4
                c := data[i + 4]
                offset := CHAR_MAP_3[c]
                buffer[hand_idx + 4] = offset

                if c != 'J' {
                    matches[offset] += 1
                    match_val := matches[offset]
    
                    hand = hand_transition(hand, match_val)
                } else {
                    jokers += 1
                }
            }

            max_match := slice.max_index(matches[2:]) + 2
            for _ in 0..<jokers {
                matches[max_match] += 1
                match_val := matches[max_match]
                hand = hand_transition(hand, match_val)
            }

            assert(data[i + 5] == ' ')
            state = Parse_State(!bool(state))
            i = i + 6
            buffer[0] = u8(hand)
        } else if state == .Bet {
            // can be up to 4 characters (1000)
            assert('0' <= c && c <= '9')
            j: int
            for ;; j += 1 {
                c := data[i + j]
                if c == '\n' do break
                bet = bet * 10 + u16(c - '0') 
            }
            buf_val := u64(transmute(u64be)buffer)
            buf_val += u64(bet)

            append(&fast_hands, buf_val)

            i += j + 1
            state = .Hand
            jokers = 0
            bet = 0
            matches = {}
            hand = .High
        }
    }

    slice.sort_by(fast_hands[:], proc(p1, p2: u64) -> bool {
        return (p1 & ~(bet_mask)) < (p2 & ~(bet_mask))
    });

    result: int
    for hand, i in fast_hands {
        result += (i + 1) * int(hand & bet_mask)
    }
    return result
}

main :: proc() {
    arena_backing := make([]u8, 8 * mem.Megabyte)
    solution_arena: mem.Arena
    mem.arena_init(&solution_arena, arena_backing)

    // alloc := mem.arena_allocator(&solution_arena)
    // context.allocator = alloc
    // context.temp_allocator = alloc

    iter := 10000

    pt1_start := time.now()
    pt1_ans := part_1(input)
    for i in 0..<iter {
        pt1_ans = part_1(input)
    }
    pt1_end := time.now()
    fmt.println("P1:", pt1_ans, "Time:", time.duration_microseconds(time.diff(pt1_start, pt1_end)) / f64(iter), "Memory Used:", solution_arena.peak_used)

    // free_all(context.allocator)
    // solution_arena.peak_used = 0

    pt2_start := time.now()
    pt2_ans := part_2(input)
    for i in 0..<iter {
        pt2_ans = part_2(input)
    }
    pt2_end := time.now()
    fmt.println("P2:", pt2_ans, "Time:", time.duration_microseconds(time.diff(pt2_start, pt2_end)) / f64(iter), "Memory Used:", solution_arena.peak_used)

    free_all(context.allocator)
    solution_arena.peak_used = 0

    spt2_start := time.now()
    spt2_ans := part_2(input)
    for i in 0..<iter {
        spt2_ans = super_speedy_part_2(input)
    }
    spt2_end := time.now()
    fmt.println("P2:", spt2_ans, "Time:", time.duration_microseconds(time.diff(spt2_start, spt2_end)) / f64(iter), "Memory Used:", solution_arena.peak_used)
}


@(test)
part_1_test :: proc(t: ^testing.T) {
    testing.expect_value(t, part_1(test_input), 6440)
}

@(test)
part_2_test :: proc(t: ^testing.T) {
    testing.expect_value(t, part_2(test_input), 5905)
}

@(test)
speedy_part_2_test :: proc(t: ^testing.T) {
    testing.expect_value(t, super_speedy_part_2(test_input), 5905)
}

input := #load("./input.txt", string)
test_input := `32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483
`
