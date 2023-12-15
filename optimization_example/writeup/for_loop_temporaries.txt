package opt_ex

import "core:slice"
import "core:os"
import "core:fmt"

data: []u8

@(init)
load_data :: proc() {
    data, _ = os.read_entire_file("./input.txt")

    fmt.println(len(data))
}

big_grid_1, big_grid_2: []u8
row_col_data: []int
grid_width: int

aocloop_bench_init :: proc(width: int) {
    grid_width = width
    total_size := grid_width * grid_width
    big_grid_1 = make([]u8, total_size)
    copy(big_grid_1, data)
    big_grid_2 = make([]u8, grid_width * grid_width)
    slice.fill(big_grid_2, '.')

    row_col_data = make([]int, grid_width)
}

aocloop_do_work_1 :: proc() -> int {
    result: int
    
    for c, i in big_grid_1 {
        row := i / grid_width
        col := i % grid_width
        
        slide_to_row := row_col_data[col]
        switch c {
        case u8('O'):
            next_idx := (col) * grid_width + (grid_width - slide_to_row - 1)
            big_grid_2[next_idx] = u8('O')
            row_col_data[col] += 1
            result += row
        case u8('#'):
            next_idx := (col) * grid_width + (grid_width - (row) - 1)
            big_grid_2[next_idx] = u8('#')
            row_col_data[(col)] = (row) + 1
        } 
    }

    return result
}

// TWICE AS SLOW AS _1
aocloop_do_work_1b :: proc() -> int {
    result: int
    
    for c, i in big_grid_1 {
        row := i / grid_width
        col := i %% grid_width // this alone is twice as slow
        
        slide_to_row := row_col_data[col]
        switch c {
        case u8('O'):
            next_idx := (col) * grid_width + (grid_width - slide_to_row - 1)
            big_grid_2[next_idx] = u8('O')
            row_col_data[col] += 1
            result += row
        case u8('#'):
            next_idx := (col) * grid_width + (grid_width - (row) - 1)
            big_grid_2[next_idx] = u8('#')
            row_col_data[(col)] = (row) + 1
        } 
    }

    return result
}

aocloop_do_work_2 :: proc() -> int {
    result: int
    
    for c, i in big_grid_1 {
        // row := i / grid_width
        // col := i % grid_width
        
        slide_to_row := row_col_data[i % grid_width]
        switch c {
        case u8('O'):
            next_idx := (i % grid_width) * grid_width + (grid_width - slide_to_row - 1)
            big_grid_2[next_idx] = u8('O')
            row_col_data[i % grid_width] += 1
            result += i / grid_width
        case u8('#'):
            next_idx := (i % grid_width) * grid_width + (grid_width - (i / grid_width) - 1)
            big_grid_2[next_idx] = u8('#')
            row_col_data[(i % grid_width)] = (i / grid_width) + 1
        } 
    }

    return result
}

aocloop_do_work_3 :: proc() -> int {
    result: int
    
    grid_height := len(big_grid_1) / grid_width
    for row in 0..< grid_height {
        for col in 0..<grid_width {
            c := big_grid_1[row * grid_width + col]

            slide_to_row := row_col_data[col]
            switch c {
            case u8('O'):
                next_idx := (col) * grid_width + (grid_width - slide_to_row - 1)
                big_grid_2[next_idx] = u8('O')
                row_col_data[col] += 1
                result += row
            case u8('#'):
                next_idx := (col) * grid_width + (grid_width - (row) - 1)
                big_grid_2[next_idx] = u8('#')
                row_col_data[(col)] = (row) + 1
            } 
        }
    }

    return result
}

aocloop_per_iter_cleanup :: proc() {
    copy(big_grid_1, data)
    slice.fill(big_grid_2, '.')
    slice.fill(row_col_data, 0)
}

aocloop_bench_destroy :: proc() {
    delete(big_grid_1)
    delete(big_grid_2)
    delete(row_col_data)
}