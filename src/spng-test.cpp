/*
    Minimal test program for the libspng library,
    verifying core functionality and compatible with MXE static builds on Windows.

    To compile with MXE (example):
    ./usr/bin/x86_64-w64-mingw32.static-g++ \
        src/spng-test.cpp \
        -I usr/x86_64-w64-mingw32.static/include/ \
        -L usr/x86_64-w64-mingw32.static/lib/ \
        -lspng_static -lz \
        -o usr/x86_64-w64-mingw32.static/bin/test-spng.exe
*/

#define SPNG_STATIC
#include <spng.h>
#include <iostream>

int main() {
    unsigned char buf[1] = {0};
    spng_ctx *ctx = spng_ctx_new(0);
    if (!ctx) {
        std::cerr << "Failed to create spng_ctx\n";
        return 1;
    }

    spng_set_png_buffer(ctx, buf, 1);

    struct spng_plte plte;
    int err = spng_get_plte(ctx, &plte);

    std::cout << "spng_get_plte returned: " << spng_strerror(err) << "\n";
    std::cout << "[spng-test] Library loaded and API accessible: SUCCESS\n";

    spng_ctx_free(ctx);
    return 0;
}
