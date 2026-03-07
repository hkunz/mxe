/*
    Minimal test program for the sjpeg library,
    verifying core functionality and compatible with MXE static builds on Windows.

    To compile with MXE (example):
    ./usr/bin/x86_64-w64-mingw32.static-g++ \
        src/sjpeg-test.cpp \
        -I usr/x86_64-w64-mingw32.static/include/ \
        -L usr/x86_64-w64-mingw32.static/lib/ \
        -lsjpeg \
        -o usr/x86_64-w64-mingw32.static/bin/test-sjpeg.exe
*/

#include <sjpeg.h>
#include <iostream>

int main() {
    int width = 1;
    int height = 1;
    unsigned char rgb[3] = { 255, 255, 255 };

    uint8_t* jpeg_buffer = nullptr;

    // quality: 1.0, progressive: 0, YUV mode: SJPEG_YUV_444
    size_t jpeg_size = SjpegEncode(rgb, width, height, 3, &jpeg_buffer,
                                   1.0f, 0, SJPEG_YUV_444);

    if (!jpeg_buffer || jpeg_size == 0) {
        std::cerr << "SjpegEncode failed\n";
        return 1;
    }

    std::cout << "SjpegEncode succeeded. JPEG size: " << jpeg_size << " bytes\n";
    std::cout << "[sjpeg-test] Library loaded and API accessible: SUCCESS\n";

    free(jpeg_buffer); // buffer allocated by SjpegEncode
    return 0;
}
