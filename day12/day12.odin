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
import "core:thread"

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

/* this is ugly because of the debug prints
 go look at cached_count_matches
 which has more clear commentary
 */
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

/*
Part 2 is basically part 1 with a cache
*/

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

// Checks if the size of the run of springs
// can fit into the current set of fields
// WITHOUT violating the rules
// either by overlaying #s or ?s
// e.g. #????..### can fit any size up to 5
// # can only fit 1 (and is the end of input)
// ##. _can't_ fit 1 because there'd be no spacing
// between the ##s so the minimum size is 2
fits :: proc(fields: []u8, size: int) -> bool {
    if len(fields) < size do return false

    for i in 0..<size {
        if fields[i] == '.' do return false
    }

    if size < len(fields) && fields[size] == '#' do return false

    return true
}

/*

Here we recursively consume the next size run we're looking for
And check for any constraint violations

If we hit a ? we just do the same thing but iterate and consume again
until we hit either a # or a .

If we hit a # then we _have_ to be able to consume the next size now
or we're at a violation (0 matches) b/c we can't have broken springs
that aren't part of the list of sizes

For part 2 this would blow up, so instead we need to cache the calculations
similar to adding a cache for the fibbonaci number series

Since we _know_ we're just looking at two lists the entire time,
fields - a subslice of the whole set of fields, and sizes - the sub slice
of all the sizes we're looking for, the pointer value and size will be unique
so we can cache the result using those

Really the pointer values alone would be fine because the slices always
go to the end of the large slice, so the sizes are redundant, but whatever
*/

cached_count_matches :: proc(fields: []u8, sizes: []int) -> int {
    S := to_state(fields, sizes)
    if result, exists := cache[S];exists {
        return result
    }

    result: int

    if len(fields) == 0 {
        /* 
        Here we've run out of fields to check (end of input)
        but if we still have sizes to check then we haven't fullfilled
        the constraints of the puzzle because every size has to have a match
        in the input e.g. you _can't_ have (by definition) ##.# 2
        you would instead always have ##.# 2,1
        */
        if len(sizes) != 0 {
            cache[S] = 0
            return 0 // no valid matches here, invalidate above
        }
        else {
        /* BUT if we don't have any sizes then we've matched everything! YAY!
        this is exactly 1 arrangement that matched based on the consumed input
        and how we consumed previous input

        There might be others that satisfy the requirements but this one is ours
        */
            cache[S] = 1
            return 1
        } 
    } else if len(sizes) == 0 {
        /*
        If we still have input but we're out of sizes then one of two things is happening:
        A: the rest of our input is some combination of '.' and '?' e.g. ..?????
        in which case we can treat the ? as '.' and we're still ok, no more springs to match

        B: the input has some number of '#' like '..??..###' and we're in a violation
        because we have # in the input but no springs in the sizes

        Scan the rest of the input and if there is a '#' we're in violation and not matching
        otherwise WE FOUND AN ARRANGEMENT!
        */
        for c in fields {
            if c == '#' { 
                cache[S] = 0
                return 0 // we haven't consumed all the #s
            }
        }
        cache[S] = 1
        return 1
    }


    /*

        Here, if the input had no '?'s we'd really just want to skip to the next
        '#' and then verify we're ok by consuming the next size

        However there are ?s so we skip '.'s until either we see a ? or a #
        If we see a # then two things are possible:
        A. we can consume our next size _now_ and get 1 or more possible arrangements OR
        B. we can't consume now and we're in violation b/c we can't skip a # ever (otherwise there'd be another 1 in our size input)

        If we see a ? then we can pretend it's a # and consume like above, but if we get
        no matches then we can just pretend it was a . and move on
    */

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

@(thread_local)
tcache: map[State]int

results: []int

part_3 :: proc(data: string) -> int {
    p3_threaded :: proc(t: ^thread.Thread) {
        line_len := int(uintptr(t.data))
        line_ptr := cast([^]string) t.user_args[0]
        idx := t.user_index

        lines := line_ptr[:line_len]

        result: int
        five_sizes := make([dynamic]int, 0, 16)
        sizes := make([dynamic]int, 0, 16)
        five_fields := make([dynamic]u8, 0, 16)
        for line in lines {
            line := line
            clear(&sizes)
            clear(&five_fields)
            clear(&five_sizes)
            clear(&tcache)

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
            matched := tcached_count_matches(fields_left, sizes_left)
            if matched == 0 {
                fmt.panicf("AHH: %s, %v", fields_left, sizes_left)
            }
            result += matched
        }
        results[idx] = result
    }

    lines := strings.split_lines(data)

    ts := make([]^thread.Thread, 8)
    results = make([]int, 8)
    chunk_len := len(lines) / len(ts)
    for &t, i in ts {
        t = thread.create(p3_threaded)
        chunk := lines[i * chunk_len:]
        t.data = rawptr(uintptr(min(len(chunk), chunk_len)))
        t.user_index = i
        t.user_args[0] = raw_data(lines[i * chunk_len:])
    }

    for t in ts {
        thread.start(t)
    }

    thread.join_multiple(..ts)

    return math.sum(results)
}

tcached_count_matches :: proc(fields: []u8, sizes: []int) -> int {
    S := to_state(fields, sizes)
    if result, exists := tcache[S];exists {
        return result
    }

    result: int

    if len(fields) == 0 {

        if len(sizes) != 0 {
            tcache[S] = 0
            return 0 // no valid matches here, invalidate above
        }
        else {

            tcache[S] = 1
            return 1
        } 
    } else if len(sizes) == 0 {

        for c in fields {
            if c == '#' { 
                tcache[S] = 0
                return 0 // we haven't consumed all the #s
            }
        }
        tcache[S] = 1
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
                result += tcached_count_matches(rest[sizes[0] + 1:], sizes[1:])
            }
        } else if c == '#' {
            if fits(rest, sizes[0]) {
                if len(rest) < sizes[0] + 1 {
                    if len(sizes) == 1 {
                        result += 1
                    }
                } else {
                    result += tcached_count_matches(rest[sizes[0] + 1:], sizes[1:])
                }
            }
            break // we hit a required # so we _have_ to match the current value or just not
        }
    }

    tcache[S] = result

    return result
}

main :: proc() {
    arena_backing := make([]u8, 8 * mem.Megabyte)
    solution_arena: mem.Arena
    mem.arena_init(&solution_arena, arena_backing)

    alloc := mem.arena_allocator(&solution_arena)
    old_alloc := context.allocator
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

    context.allocator = old_alloc
    pt3_start := time.now()
    pt3_ans := part_3(input)
    pt3_end := time.now()
    fmt.println("P3:", pt3_ans, "Time:", time.diff(pt3_start, pt3_end))
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
