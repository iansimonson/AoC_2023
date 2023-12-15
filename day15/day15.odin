package day15

import "core:fmt"
import "core:math"
import "core:mem"
import "core:os"
import "core:slice"
import "core:strconv"
import "core:strings"
import "core:testing"
import "core:time"

part_1 :: proc(data: string) -> (result: int) {
    data := transmute([]u8) data

    hash: int
    for c in data {
        switch c {
        case ',', '\n':
            result += hash
            hash = 0
        case:
            hash = (hash + int(c)) * 17 % 256
        }
    }
    result += hash

    return
}

Node :: struct {
    label: string,
    lens: u8,
}

part_2 :: proc(data: string) -> (result: int) {
    
    boxes: [256][dynamic]Node
    for &box in boxes {
        box = make([dynamic]Node, 0, 100)
    }

    label_map: map[string]int

    data := transmute([]u8) data
    label_buffer: [100]u8
    label_size: int
    hash: int
    data_len := len(data)
    for i := 0; i < data_len; {
        c := data[i]

        switch c {
        case '=':
            assert(label_size > 0)
            label := string(label_buffer[:label_size])
            lens := data[i + 1] - '0'

            if box_idx, exists := label_map[label]; exists {
                boxes[hash][box_idx].lens = lens
            } else {
                safe_label := strings.clone(label)
                append(&boxes[hash], Node{safe_label, lens})
                label_map[safe_label] = len(boxes[hash]) - 1
            }
            i += 2
            continue
        case '-':
            assert(label_size > 0)
            label := string(label_buffer[:label_size])
            
            if box_idx, exists := label_map[label]; exists {
                ordered_remove(&boxes[hash], box_idx)
                delete_key(&label_map, label)
                if box_idx < len(boxes[hash]) {
                    for n in boxes[hash][box_idx:] {
                        assert(n.label in label_map)
                        label_map[n.label] -= 1
                    }               
                }
            }
        case ',', '\n':
            label_size = 0
            hash = 0
        case:
            hash = (hash + int(c)) * 17 % 256
            label_buffer[label_size] = c
            label_size += 1

        }
        i += 1
    }

    for box, box_num in boxes {
        for node, slot in box {
            result += (box_num + 1) * (slot + 1) * int(node.lens)
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
    testing.expect_value(t, part_1(test_input), 52)
    testing.expect_value(t, part_1(test_input_2), 1320)
}

@(test)
part_2_test :: proc(t: ^testing.T) {
    testing.expect_value(t, part_2(test_input_2), 145)
}

input := #load("./input.txt", string)
test_input := `HASH`
test_input_2 := `rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7`
