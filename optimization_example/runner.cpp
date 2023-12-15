#include <cstdio>
#include <cstdint>
#include <cstddef>
#include <vector>
#include <fstream>
#include <array>

using i64 = int64_t;

std::vector<std::byte> raw_data;
std::vector<std::byte> big_grid_1;
std::vector<std::byte> big_grid_2;
std::vector<i64> row_col_data;
i64 grid_width;

void load_data() {
    std::ifstream f("./input.txt");
    f.seekg(0, std::ios::end);
    auto size = f.tellg();
    f.seekg(0);
    raw_data.resize(size);
    f.read(raw_data.data(), size);
}


void aocloop_bench_init(i64 width) {
    grid_width = width;
    i64 total_size = grid_width * grid_width;
    big_grid_1 = raw_data;
    big_grid_2.resize('.');
    std::fill(row_col_data.begin(), row_col_data.end(), 0);
}

i64 aocloop_do_work_1() {
    i64 result = 0;
    
    i64 idx = 0;
    for (auto &&c : big_grid_1) {
        idx += 1;
        i64 row = idx / grid_width;
        i64 col = idx % grid_width;

        i64 slide_to_row = row_col_data[col];

        switch (c) {
        case 'O': {
            i64 next_idx = (col * grid_width) + (grid_width - slide_to_row - 1);
            big_grid_2[next_idx] = 'O';
            row_col_data[col] += 1;
            result += row;
            break;
        }
        case '#': {
            i64 next_idx = col * grid_width + (grid_width - row - 1);
            big_grid_2[next_idx] = '#';
            row_col_data[col] = row + 1;
            break;
        }
        }
    }

    return result;
}

i64 aocloop_do_work_1c() {
    i64 result = 0;
    
    i64 idx = 0;
    for (auto &&c : big_grid_1) {
        idx += 1;
        
        switch (c) {
        case 'O': {
            i64 row = idx / grid_width;
            i64 col = idx % grid_width;
            i64 slide_to_row = row_col_data[col];

            i64 next_idx = (col * grid_width) + (grid_width - slide_to_row - 1);
            big_grid_2[next_idx] = 'O';
            row_col_data[col] += 1;
            result += row;
            break;
        }
        case '#': {
            i64 row = idx / grid_width;
            i64 col = idx % grid_width;

            i64 next_idx = col * grid_width + (grid_width - row - 1);
            big_grid_2[next_idx] = '#';
            row_col_data[col] = row + 1;
            break;
        }
        }
    }

    return result;
}

using WorkPtr = i64 (*)();

void bench(WorkPtr work) {
    printf("\n");
    printf("BENCHMARKING....\n");
    printf("=================================\n");

    const auto width = std::array{1, 5, 10, 20, 50, 100};

    memory := make([]byte, 2 * 1024 * 1024)
    arena: mem.Arena
    mem.arena_init(&arena, memory)

    context.allocator = mem.arena_allocator(&arena)

    iterations := 100_000

    for width in widths {
        aocloop_bench_init(width)
        result: int
        total_time: time.Duration

        for i in 0..<iterations {
            aocloop_per_iter_cleanup()
            start := time.now()
            result += work()
            loop_diff := time.since(start)
            total_time += loop_diff
        }

        aocloop_bench_destroy()
        free_all(context.allocator)

        fmt.println("Width:", width, "time:", int(total_time) / iterations, "ns", "unused value:", result)
    }
}

int main() {

}

