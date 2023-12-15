#include <chrono>
#include <cstdio>
#include <cstdint>
#include <cstddef>
#include <vector>
#include <fstream>
#include <array>

using i64 = int64_t;

std::vector<char> raw_data;
std::vector<char> big_grid_1;
std::vector<char> big_grid_2;
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
    big_grid_2.resize(raw_data.size(), '.');
    std::fill(row_col_data.begin(), row_col_data.end(), 0);
}

void aocloop_per_iter_cleanup() {
    big_grid_1 = raw_data;
    std::fill(big_grid_2.begin(), big_grid_2.end() , '.');
    std::fill(row_col_data.begin(), row_col_data.end() , 0);
}

void aocloop_bench_destroy() {
    // noop b/c vector handles it
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

i64 aocloop_do_work_2() {
    i64 result = 0;

    i64 idx = 0;
    for (auto &&c : big_grid_1) {
        idx += 1;
        i64 slide_to_row = row_col_data[idx % grid_width];
        
        switch (c) {
        case 'O': {

            i64 next_idx = ((idx % grid_width) * grid_width) + (grid_width - slide_to_row - 1);
            big_grid_2[next_idx] = 'O';
            row_col_data[idx % grid_width] += 1;
            result += idx / grid_width;
            break;
        }
        case '#': {

            i64 next_idx = (idx % grid_width) * grid_width + (grid_width - (idx / grid_width) - 1);
            big_grid_2[next_idx] = '#';
            row_col_data[(idx % grid_width)] = (idx / grid_width) + 1;
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

    const auto widths = std::array<int, 6>{1, 5, 10, 20, 50, 100};

    const i64 iterations = 100'000;


    for (const auto width : widths) {
        aocloop_bench_init(width);
        i64 result = 0;
        auto total_time = std::chrono::nanoseconds{};

        for (i64 i = 0; i < iterations; ++i) {
            aocloop_per_iter_cleanup();
            auto start = std::chrono::high_resolution_clock::now();
            result += work();
            auto end = std::chrono::high_resolution_clock::now();
            total_time += end - start;
        }

        aocloop_bench_destroy();

        printf("Width: %d time: %lld ns unused value: %lld", width, total_time.count() / iterations, result);
    }
}

int main() {
    load_data();

    bench(aocloop_do_work_1);
    bench(aocloop_do_work_1c);
    bench(aocloop_do_work_2);

}

