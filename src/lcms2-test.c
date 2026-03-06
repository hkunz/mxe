#include <stdio.h>
#include "lcms2.h"

/*
    Minimal test program for the Little CMS 2 (lcms2) library,
    verifying core functionality and compatible with MXE static builds on Windows.

    To compile with MXE (example):
    ./usr/bin/x86_64-w64-mingw32.static-gcc \
        src/lcms2-test.c \
        -I usr/x86_64-w64-mingw32.static/include/ \
        -L usr/x86_64-w64-mingw32.static/lib/ \
        -llcms2 \
        -o usr/x86_64-w64-mingw32.static/bin/test-lcms2.exe

*/

int main() {
    printf("Little CMS 2 test program\n");

    // Create a simple sRGB profile
    cmsHPROFILE profile = cmsCreate_sRGBProfile();
    if (!profile) {
        printf("Failed to create sRGB profile\n");
        return 1;
    }

    printf("sRGB profile created successfully\n");

    // Check profile type
    cmsUInt32Number signature = cmsGetDeviceClass(profile);
    printf("Profile class signature: 0x%08X\n", signature);

    // Clean up
    cmsCloseProfile(profile);
    printf("Profile closed\n");

    return 0;
}
