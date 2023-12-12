package day12

import "core:fmt"
import "core:math"
import "core:mem"
import "core:os"
import "core:slice"
import "core:strconv"
import "core:strings"
import "core:testing"
import "core:time"

@(disabled = !(ODIN_DEBUG || ODIN_TEST))
debug_print :: proc(args: ..any) {
    fmt.println(..args)
}

part_1 :: proc(data: string) -> (result: int) {
    data := data
    sizes := make([dynamic]int, 0, 16)
    for line in strings.split_lines_iterator(&data) {
        line := line
        clear(&sizes)
        fields, ok := strings.split_by_byte_iterator(&line, ' ')
        assert(ok)
        for num in strings.split_by_byte_iterator(&line, ',') {
            append(&sizes, strconv.atoi(num))
        }

        sizes_left := sizes[:]
        fields_left := transmute([]u8) fields
        matched := count_matches(fields_left, sizes_left)
        if matched == 0 {
            fmt.panicf("AHH: %s, %v", fields, sizes_left)
        }
        result += matched
    }

    return
}

// Checks if the size of the run of springs
// can fit into the current set of fields
// either by overlaying #s or ?s
fits :: proc(fields: []u8, size: int) -> bool {
    if len(fields) < size do return false

    for i in 0..<size {
        if fields[i] == '.' do return false
    }

    if size < len(fields) && fields[size] == '#' do return false

    return true
}

count_matches :: proc(fields: []u8, sizes: []int) -> (result: int) {
    
    debug_print("LOOKING AT:", string(fields), sizes)
    if len(fields) == 0 {
        debug_print("NO FIELDS")
        if len(sizes) != 0 {
            debug_print("sizes left, no match")
            return 0 // no valid matches here, invalidate above
        }
        else {
            debug_print("matched end")
            return 1
        } 
    } else if len(sizes) == 0 {
        debug_print("NO SIZES")
        for c in fields {
            if c == '#' { 
                debug_print("DID NOT CONSUME ALL")
                return 0 // we haven't consumed all the #s
            }
        }
        debug_print("CONSUMED ALL")
        return 1
    }

    f_len := len(fields)
    for i in 0..<f_len {
        c := fields[i]
        rest := fields[i:]
        
        debug_print("CHECKING:", string(rest), sizes)
        if len(rest) < sizes[0] {
            debug_print("NOT ENOUGH SIZE")
            break
        }

        if c == '?' && fits(rest, sizes[0]) {
            debug_print("FITS ?")
            if len(rest) < sizes[0] + 1 {
                if len(sizes) == 1 {
                    debug_print("At the end of fields and sizes this is a match!!")
                    result += 1
                } else {
                    debug_print("At the end of fields but no match")
                }
            } else {
                result += count_matches(rest[sizes[0] + 1:], sizes[1:])
            }
        } else if c == '#' {
            if fits(rest, sizes[0]) {
                debug_print("FITS # - breaking after this")
                if len(rest) < sizes[0] + 1 {
                    if len(sizes) == 1 {
                        debug_print("At the end of fields and sizes this is a match!!")
                        result += 1
                    } else {
                        debug_print("At the end of fields but no match")
                    }
                } else {
                    result += count_matches(rest[sizes[0] + 1:], sizes[1:])
                }
            }
            debug_print("CANT SATISFY REQS ANYMORE")
            break // we hit a required # so we _have_ to match the current value or just not
        }
    }
    return
}

part_2 :: proc(data: string) -> (result: int) {
    data := data
    five_sizes := make([dynamic]int, 0, 16)
    sizes := make([dynamic]int, 0, 16)
    five_fields := make([dynamic]u8, 0, 16)
    cache = make(map[State]int) // sets the arena allocator

    for line in strings.split_lines_iterator(&data) {
        line := line
        clear(&sizes)
        clear(&five_fields)
        clear(&five_sizes)
        clear(&cache)

        fields_str, ok := strings.split_by_byte_iterator(&line, ' ')
        fields := transmute([]u8) fields_str
        assert(ok)
        for num in strings.split_by_byte_iterator(&line, ',') {
            append(&sizes, strconv.atoi(num))
        }

        for i in 0..<5 {
            append(&five_fields, ..fields[:])
            append(&five_sizes, ..sizes[:])
            if i < 4 {
                append(&five_fields, '?')
            }
        }

        sizes_left := five_sizes[:]
        fields_left := five_fields[:]

        debug_print(string(five_fields[:]), five_sizes[:])
        matched := cached_count_matches(fields_left, sizes_left)
        if matched == 0 {
            fmt.panicf("AHH: %s, %v", fields, sizes_left)
        }
        result += matched
    }

    return
}

State :: struct {
    fptr, sptr: uintptr,
    fsize, ssize: int,
}

cache: map[State]int

to_state :: proc(f: []u8, s: []int) -> State {
    return {uintptr(raw_data(f)), uintptr(raw_data(s)), len(f), len(s)}
}

cached_count_matches :: proc(fields: []u8, sizes: []int) -> int {
    S := to_state(fields, sizes)
    if result, exists := cache[S];exists {
        return result
    }

    result: int

    if len(fields) == 0 {
        if len(sizes) != 0 {
            cache[S] = 0
            return 0 // no valid matches here, invalidate above
        }
        else {
            cache[S] = 1
            return 1
        } 
    } else if len(sizes) == 0 {
        for c in fields {
            if c == '#' { 
                cache[S] = 0
                return 0 // we haven't consumed all the #s
            }
        }
        cache[S] = 1
        return 1
    }

    f_len := len(fields)
    for i in 0..<f_len {
        c := fields[i]
        rest := fields[i:]
        
        if len(rest) < sizes[0] {
            break
        }

        if c == '?' && fits(rest, sizes[0]) {
            if len(rest) < sizes[0] + 1 {
                if len(sizes) == 1 {
                    result += 1
                }
            } else {
                result += cached_count_matches(rest[sizes[0] + 1:], sizes[1:])
            }
        } else if c == '#' {
            if fits(rest, sizes[0]) {
                if len(rest) < sizes[0] + 1 {
                    if len(sizes) == 1 {
                        result += 1
                    }
                } else {
                    result += cached_count_matches(rest[sizes[0] + 1:], sizes[1:])
                }
            }
            break // we hit a required # so we _have_ to match the current value or just not
        }
    }

    cache[S] = result

    return result
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
    testing.expect_value(t, part_1(test_input), 21)
}

@(test)
part_2_test :: proc(t: ^testing.T) {
    testing.expect_value(t, part_2(test_input), 525152)
}

input := #load("./input.txt", string)
test_input := `???.### 1,1,3
.??..??...?##. 1,1,3
?#?#?#?#?#?#?#? 1,3,1,6
????.#...#... 4,1,1
????.######..#####. 1,6,5
?###???????? 3,2,1`
