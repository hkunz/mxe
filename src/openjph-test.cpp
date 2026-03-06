/*
    Minimal test program for OpenJPH library, compatible with MXE static builds.

    To compile with MXE (example):
    ./usr/bin/x86_64-w64-mingw32.static-g++ \
        src/openjph-test.cpp \
        -I usr/x86_64-w64-mingw32.static/include/ \
        -L usr/x86_64-w64-mingw32.static/lib/ \
        -lopenjph \
        -o usr/x86_64-w64-mingw32.static/bin/test-openjph.exe
*/

#include <iostream>
#include <openjph/ojph_version.h>
#include <openjph/ojph_codestream.h>

int main() {
    // Print OpenJPH version
    std::cout << "OpenJPH version: "
              << OPENJPH_VERSION_MAJOR << "."
              << OPENJPH_VERSION_MINOR
              << std::endl;

    // Minimal codestream object creation (no method calls)
    ojph::codestream cs;

    std::cout << "Codestream object created successfully!" << std::endl;
    return 0;
}
