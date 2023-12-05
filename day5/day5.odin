package day5

import "core:fmt"
import "core:mem"
import "core:os"
import "core:slice"
import "core:strconv"
import "core:strings"
import "core:testing"
import "core:time"

atoi :: proc(s: string) -> int {
    v, _ := strconv.parse_int(s)
    return v
}

part_1 :: proc(data: string) -> int {
    data := data
    colon_idx := strings.index(data, ":")
    data = data[colon_idx + 2:]
    newline_idx := strings.index(data, "\n")
    values_1 := make([dynamic]int, 0, 20)
    values_2 := make([dynamic]int, 0, 20)
    seeds := data[:newline_idx]
    for v in strings.split_iterator(&seeds, " ") {
        append(&values_1, atoi(v))
        append(&values_2, 0)
    }

    data = data[newline_idx + 2:]
    source := &values_2
    dest := &values_1
    for mappings in strings.split_iterator(&data, "\n\n") {        
        source, dest = dest, source
        copy(dest[:], source[:])

        mappings := mappings
        header_end := strings.index(mappings, "\n")
        mappings = mappings[header_end + 1:]
        for mapping in strings.split_lines_iterator(&mappings) {
            mapping := mapping
            values: [3]int // dst, src, range
            cur := 0
            for c in mapping {
                if c == ' ' || c == '\n' {
                    cur += 1
                } else {
                    values[cur] = values[cur] * 10 + int(c - '0')
                }
            }
            for value, i in source {
                if values[1] <= value && value <= values[1] + values[2] {
                    dest[i] = values[0] + (value - values[1])
                    // fmt.println("mapped", value, "->", dest[i])
                }
            }
        }
    }

    return slice.min(dest[:])
}

part_2 :: proc(data: string) -> int {
    data := data
    colon_idx := strings.index(data, ":")
    data = data[colon_idx + 2:]
    newline_idx := strings.index(data, "\n")
    values_1 := make([dynamic][2]int, 0, 200)
    values_2 := make([dynamic][2]int, 0, 200)

    seeds := data[:newline_idx]
    seed_range: [2]int = -1
    for v in strings.split_iterator(&seeds, " ") {
        value := atoi(v)
        if seed_range[0] == -1 {
            seed_range[0] = value
        } else {
            seed_range[1] = value
            append(&values_1, seed_range)
            seed_range = -1
        }
    }

    data = data[newline_idx + 2:]
    source := &values_2
    dest := &values_1
    for mappings in strings.split_iterator(&data, "\n\n") {        
        source, dest = dest, source
        clear(dest)

        mappings := mappings
        header_end := strings.index(mappings, "\n")
        mappings = mappings[header_end + 1:]
        for mapping in strings.split_lines_iterator(&mappings) {
            mapping := mapping
            values: [3]int // dst, src, range
            cur := 0
            for c in mapping {
                if c == ' ' || c == '\n' {
                    cur += 1
                } else {
                    values[cur] = values[cur] * 10 + int(c - '0')
                }
            }

            dst_range := [2]int{values[0], values[2]}
            src_range_min := values[1]
            src_range_max := values[1] + values[2]

            reserve(source, 2 * len(source))
            for i := 0; i < len(source); {
                range := source[i]
                range_min := range[0]
                range_max := range[0] + range[1]
                switch {
                case src_range_max <= range_min || src_range_min >= range_max: // no overlap
                    // noop
                    i += 1
                case src_range_min >= range_min && src_range_max <= range_max: // mapping fully inside range
                    pre_range := [2]int{range_min, src_range_min - range_min}
                    overlap := [2]int{src_range_min, values[2]}
                    post_range := [2]int{src_range_max, range_max - src_range_max}

                    converted := [2]int{dst_range[0] + (overlap[0] - src_range_min), overlap[1]}

                    append(dest, converted)
                    unordered_remove(source, i)
                    if pre_range[1] > 0 do append(source, pre_range)
                    if post_range[1] > 0 do append(source, post_range)
                
                case src_range_min <= range_min && src_range_max > range_min: // mapping spills left
                    post_range := [2]int{src_range_max, range_max - src_range_max}
                    overlap := [2]int{range_min, min(range_max, src_range_max) - range_min}

                    converted := [2]int{dst_range[0] + (overlap[0] - src_range_min), overlap[1]}

                    append(dest, converted)
                    unordered_remove(source, i)
                    if post_range[1] > 0 do append(source, post_range)

                case src_range_min < range_max && src_range_max >= range_max: // mapping spills right
                    pre_range := [2]int{range_min, src_range_min - range_min}
                    overlap_start := max(range_min, src_range_min)
                    overlap := [2]int{overlap_start, range_max - overlap_start}

                    converted := [2]int{dst_range[0] + (overlap_start - src_range_min), overlap[1]}
                    append(dest, converted)
                    unordered_remove(source, i)

                    if pre_range[1] > 0 do append(source, pre_range)
                }
            }
        }

        for range in source do append(dest, range)
    }

    min_loc := max(int)
    for r in dest {
        min_loc = min(min_loc, r[0])
    }

    return min_loc
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
    testing.expect_value(t, part_1(test_input), 35)
}

@(test)
part_2_test :: proc(t: ^testing.T) {
    testing.expect_value(t, part_2(test_input), 46)
}

input := #load("./input.txt", string)
test_input := `seeds: 79 14 55 13

seed-to-soil map:
50 98 2
52 50 48

soil-to-fertilizer map:
0 15 37
37 52 2
39 0 15

fertilizer-to-water map:
49 53 8
0 11 42
42 0 7
57 7 4

water-to-light map:
88 18 7
18 25 70

light-to-temperature map:
45 77 23
81 45 19
68 64 13

temperature-to-humidity map:
0 69 1
1 0 69

humidity-to-location map:
60 56 37
56 93 4`
