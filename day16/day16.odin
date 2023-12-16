package day16

import "core:fmt"
import "core:math"
import "core:mem"
import "core:os"
import "core:slice"
import "core:strconv"
import "core:strings"
import "core:testing"
import "core:time"

part_1 :: proc(data: string) -> int {
    total_size := len(data)
    grid_width := strings.index_byte(data, '\n') + 1
    grid_height := total_size / grid_width

    offsets := [Directions]int {
        .Up    = -grid_width,
        .Down  = grid_width,
        .Left  = -1,
        .Right = 1,
    }

    visited := make(map[Lazer]struct{})
    visited_idx := make(map[int]struct{})
    stack := make([dynamic]Lazer, 0, 100)
    append(&stack, Lazer{0, .Right})

    for len(stack) != 0 {
        ray := pop(&stack)
        if ray.index < 0 || ray.index >= total_size do continue
        if ray in visited do continue

        space := data[ray.index]        
        if space == '\n' do continue // we're done and dont add to visited

        visited[ray] = {}
        visited_idx[ray.index] = {}

        switch space {
        case '.':
            append(&stack, Lazer{ray.index + offsets[ray.direction], ray.direction})
        case '/':
            switch ray.direction {
            case .Up:
                append(&stack, Lazer{ray.index + offsets[.Right], .Right})
            case .Down:
                append(&stack, Lazer{ray.index + offsets[.Left], .Left})
            case .Left:
                append(&stack, Lazer{ray.index + offsets[.Down], .Down})
            case .Right:
                append(&stack, Lazer{ray.index + offsets[.Up], .Up})
            }
        case '\\':
            switch ray.direction {
            case .Up:
                append(&stack, Lazer{ray.index + offsets[.Left], .Left})
            case .Down:
                append(&stack, Lazer{ray.index + offsets[.Right], .Right})
            case .Left:
                append(&stack, Lazer{ray.index + offsets[.Up], .Up})
            case .Right:
                append(&stack, Lazer{ray.index + offsets[.Down], .Down})
            }
        case '-':
            switch ray.direction {
            case .Up:
                append(&stack, Lazer{ray.index + offsets[.Left], .Left})
                append(&stack, Lazer{ray.index + offsets[.Right], .Right})
            case .Down:
                append(&stack, Lazer{ray.index + offsets[.Left], .Left})
                append(&stack, Lazer{ray.index + offsets[.Right], .Right})
            case .Left, .Right:
                append(&stack, Lazer{ray.index + offsets[ray.direction], ray.direction})
            }
        case '|':
            switch ray.direction {
            case .Up, .Down:
                append(&stack, Lazer{ray.index + offsets[ray.direction], ray.direction})
            case .Left:
                append(&stack, Lazer{ray.index + offsets[.Up], .Up})
                append(&stack, Lazer{ray.index + offsets[.Down], .Down})
            case .Right:
                append(&stack, Lazer{ray.index + offsets[.Up], .Up})
                append(&stack, Lazer{ray.index + offsets[.Down], .Down})
            }
        }
    }

    return len(visited_idx)
}

part_2 :: proc(data: string) -> int {
    total_size := len(data)
    grid_width := strings.index_byte(data, '\n') + 1
    grid_height := total_size / grid_width

    offsets := [Directions]int {
        .Up    = -grid_width,
        .Down  = grid_width,
        .Left  = -1,
        .Right = 1,
    }

    visited := make(map[Lazer]struct{})
    visited_idx := make(map[int]struct{})
    stack := make([dynamic]Lazer, 0, 100)

    max_energized: int
    for i in 0..<grid_height {
        energized := calc_energized(&visited, &visited_idx, &stack, offsets, data, Lazer{i * grid_width, .Right})
        other_energized := calc_energized(&visited, &visited_idx, &stack, offsets, data, Lazer{i * grid_width + grid_width - 1, .Left})
        max_energized = max(max_energized, energized, other_energized)
    }

    for i in 0..<grid_width - 1 {
        energized := calc_energized(&visited, &visited_idx, &stack, offsets, data, Lazer{i, .Down})
        other_energized := calc_energized(&visited, &visited_idx, &stack, offsets, data, Lazer{(grid_height - 1) * grid_width + i, .Up})
        max_energized = max(max_energized, energized, other_energized)
    }

    return max_energized
}

Lazer :: struct {
    index:     int,
    direction: Directions,
}

Directions :: enum {
    Up,
    Down,
    Left,
    Right,
}

calc_energized :: proc(visited: ^map[Lazer]struct{}, visited_idx: ^map[int]struct{}, stack: ^[dynamic]Lazer, offsets: [Directions]int, data: string, start: Lazer) -> int {
    clear(visited)
    clear(visited_idx)
    clear(stack)
    append(stack, start)

    total_size := len(data)

    for len(stack) != 0 {
        ray := pop(stack)
        if ray.index < 0 || ray.index >= total_size do continue
        if ray in visited do continue

        space := data[ray.index]        
        if space == '\n' do continue // we're done and dont add to visited

        visited[ray] = {}
        visited_idx[ray.index] = {}

        switch space {
        case '.':
            append(stack, Lazer{ray.index + offsets[ray.direction], ray.direction})
        case '/':
            switch ray.direction {
            case .Up:
                append(stack, Lazer{ray.index + offsets[.Right], .Right})
            case .Down:
                append(stack, Lazer{ray.index + offsets[.Left], .Left})
            case .Left:
                append(stack, Lazer{ray.index + offsets[.Down], .Down})
            case .Right:
                append(stack, Lazer{ray.index + offsets[.Up], .Up})
            }
        case '\\':
            switch ray.direction {
            case .Up:
                append(stack, Lazer{ray.index + offsets[.Left], .Left})
            case .Down:
                append(stack, Lazer{ray.index + offsets[.Right], .Right})
            case .Left:
                append(stack, Lazer{ray.index + offsets[.Up], .Up})
            case .Right:
                append(stack, Lazer{ray.index + offsets[.Down], .Down})
            }
        case '-':
            switch ray.direction {
            case .Up:
                append(stack, Lazer{ray.index + offsets[.Left], .Left})
                append(stack, Lazer{ray.index + offsets[.Right], .Right})
            case .Down:
                append(stack, Lazer{ray.index + offsets[.Left], .Left})
                append(stack, Lazer{ray.index + offsets[.Right], .Right})
            case .Left, .Right:
                append(stack, Lazer{ray.index + offsets[ray.direction], ray.direction})
            }
        case '|':
            switch ray.direction {
            case .Up, .Down:
                append(stack, Lazer{ray.index + offsets[ray.direction], ray.direction})
            case .Left:
                append(stack, Lazer{ray.index + offsets[.Up], .Up})
                append(stack, Lazer{ray.index + offsets[.Down], .Down})
            case .Right:
                append(stack, Lazer{ray.index + offsets[.Up], .Up})
                append(stack, Lazer{ray.index + offsets[.Down], .Down})
            }
        }
    }

    return len(visited_idx)
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
    testing.expect_value(t, part_1(test_input), 46)
}

@(test)
part_2_test :: proc(t: ^testing.T) {
    testing.expect_value(t, part_2(test_input), 51)
}

input := #load("./input.txt", string)
test_input := `.|...\....
|.-.\.....
.....|-...
........|.
..........
.........\
..../.\\..
.-.-/..|..
.|....-|.\
..//.|....
`
