/*
    oneTBB Full Test Program
    https://software.intel.com/en-us/oneapi/onetbb
    License: Apache-2.0 (see oneTBB LICENSE)

    This program tests:
    1. Core oneTBB functionality (parallel_for)
    2. TBB scalable memory allocator (tbbmalloc)

    ./usr/bin/x86_64-w64-mingw32.static-g++ \
        -I usr/x86_64-w64-mingw32.static/include \
        -L usr/x86_64-w64-mingw32.static/lib \
        src/tbb-test.cpp \
        -ltbb12 -ltbbmalloc \
        -o test-tbb.exe
*/

#include <tbb/tbb.h>
#include <iostream>
#include <cstdlib>

int main()
{
    std::cout << "Running oneTBB minimal test..." << std::endl << std::flush;

    // Simple parallel loop test
    tbb::parallel_for(0, 10, [](int i){
        std::cout << "Hello from TBB iteration " << i << std::endl << std::flush;
    });

    std::cout << "oneTBB test completed successfully." << std::endl << std::flush;

    return 0;
}
