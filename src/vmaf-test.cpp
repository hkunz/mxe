/*
    Minimal test program for libvmaf library, compatible with MXE static builds.

    To compile with MXE (example):
    ./usr/bin/x86_64-w64-mingw32.static-g++ \
        src/vmaf-test.cpp \
        -I usr/x86_64-w64-mingw32.static/include/ \
        -I usr/x86_64-w64-mingw32.static/include/libvmaf \
        -L usr/x86_64-w64-mingw32.static/lib/ \
        -lvmaf -pthread -lm \
        -o usr/x86_64-w64-mingw32.static/bin/test-vmaf.exe
*/

#include <iostream>
#include <libvmaf/libvmaf.h>

int main() {
    std::cout << "VMAF version: " << vmaf_version() << std::endl;

    VmafConfiguration cfg;
    cfg.log_level = VMAF_LOG_LEVEL_NONE;

    std::cout << "VmafConfiguration object created successfully!" << std::endl;
    return 0;
}
