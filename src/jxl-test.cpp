/*
    Minimal test program for JPEG XL library, verifying basic functionality
    and compatibility with MXE static builds on Windows.

    To compile with MXE (example):

    ./usr/bin/x86_64-w64-mingw32.static-g++ \
        src/jxl-test.cpp \
        -I usr/x86_64-w64-mingw32.static/include \
        -L usr/x86_64-w64-mingw32.static/lib \
        -ljxl -ljxl_threads -ljxl_cms -lhwy \
        -lbrotlienc -lbrotlidec -lbrotlicommon \
        -lwinpthread -lstdc++ -lm -llcms2_static \
        -DJXL_STATIC_DEFINE \
        -o usr/x86_64-w64-mingw32.static/bin/test-jxl.exe
*/


#include <jxl/encode.h>
#include <jxl/decode.h>
#include <stdio.h>

int main() {
    // Create encoder
    JxlEncoder* enc = JxlEncoderCreate(NULL);
    if (!enc) {
        printf("Failed to create JxlEncoder\n");
        return 1;
    }

    // Create decoder
    JxlDecoder* dec = JxlDecoderCreate(NULL);
    if (!dec) {
        printf("Failed to create JxlDecoder\n");
        JxlEncoderDestroy(enc);
        return 1;
    }

    printf("libjxl encoder and decoder created successfully\n");

    // Clean up
    JxlEncoderDestroy(enc);
    JxlDecoderDestroy(dec);

    return 0;
}
