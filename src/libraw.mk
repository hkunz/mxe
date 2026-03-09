# This file is part of MXE. See LICENSE.md for licensing information.

include src/common/pkgutils.mk

PKG             := libraw
$(PKG)_WEBSITE  := https://libraw.org
$(PKG)_DESCR    := A library for reading RAW files obtained from digital photo cameras
$(PKG)_VERSION  := 0.21.1
$(PKG)_CHECKSUM := b63d7ffa43463f74afcc02f9083048c231349b41cc9255dec0840cf8a67b52e0
$(PKG)_GH_CONF  := LibRaw/LibRaw/tags
$(PKG)_DEPS     := cc jasper jpeg lcms zlib

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && autoreconf -fi
    cd '$(BUILD_DIR)' && '$(SOURCE_DIR)'/configure \
        $(MXE_CONFIGURE_OPTS) \
        --enable-jasper \
        --enable-jpeg \
        --enable-lcms \
        --disable-examples \
        CXXFLAGS='-std=gnu++11 $(if $(BUILD_SHARED),-DLIBRAW_BUILDLIB,-DLIBRAW_NODLL)' \
        LDFLAGS='-lws2_32'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' install

    $(call GENERATE_PC, \
        $(PREFIX)/$(TARGET), \
        libraw, \
        Raw image decoder library (non-thread-safe), \
        $($(PKG)_VERSION), \
        lcms2, \
        , \
        -lraw -lstdc++ -fopenmp, \
        -ljasper -lws2_32, \
        libraw, \
        -DLIBRAW_NODLL, \
    )

    $(call GENERATE_PC, \
        $(PREFIX)/$(TARGET), \
        libraw_r, \
        Raw image decoder library (thread-safe), \
        $($(PKG)_VERSION), \
        lcms2, \
        , \
        -lraw_r -lstdc++ -fopenmp, \
        -ljasper -lws2_32, \
        libraw, \
        -DLIBRAW_NODLL, \
    )

    '$(TARGET)-g++' -Wall -Wextra -std=c++11 \
        '$(TEST_FILE)' -o '$(PREFIX)/$(TARGET)/bin/test-$(PKG).exe' \
        `'$(TARGET)-pkg-config' libraw --cflags --libs`
endef
