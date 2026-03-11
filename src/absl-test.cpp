/*
    absl-test.cpp - Minimal test for Abseil C++ library

    Purpose:
        Verify that a custom-generated absl.pc file works with MXE.
        This test exercises basic Abseil components like strings, time, and base utilities.

    Compilation (MXE example):
        ./usr/bin/x86_64-w64-mingw32.static-g++ src/absl-test.cpp \
            -I usr/x86_64-w64-mingw32.static/include \
            -L usr/x86_64-w64-mingw32.static/lib \
            -labsl_strings \
            -labsl_time \
            -labsl_raw_logging_internal \
            -labsl_cord \
            -labsl_synchronization \
            -labsl_malloc_internal \
            -labsl_status \
            -labsl_statusor \
            -labsl_int128 \
            -labsl_throw_delegate \
            -labsl_spinlock_wait \
            -labsl_base \
            -lpthread \
            -o usr/x86_64-w64-mingw32.static/bin/test-absl.exe

    Notes:
        - This is only a minimal sanity check; it does not cover the full Abseil API.
        - Modify include flags or linker flags if you built Abseil with additional modules.
*/

#include <absl/strings/str_cat.h>
#include <absl/strings/string_view.h>
#include <iostream>

int main() {
    absl::string_view a = "Hello";
    absl::string_view b = "World";
    std::string c = absl::StrCat(a, ", ", b, "!");
    std::cout << c << std::endl;
    return 0;
}
