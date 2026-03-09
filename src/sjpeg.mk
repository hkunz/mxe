# This file is part of MXE. See LICENSE.md for licensing information.

include src/common/pkgutils.mk

PKG             := sjpeg
$(PKG)_WEBSITE  := https://github.com/webmproject/sjpeg
$(PKG)_DESCR    := Lightweight JPEG encoder with simple C API and optional C++ interface
$(PKG)_URL      := https://github.com/webmproject/sjpeg/archive/refs/heads/master.tar.gz
# Using master because there are no tags yet (https://github.com/webmproject/sjpeg/issues/145)
$(PKG)_VERSION  := main
$(PKG)_CHECKSUM := 9a427a1002b4597010495e18057073a564b3cba3fcb697bd518563ef95c2ecce
$(PKG)_GH_CONF  := webmproject/sjpeg/tags
$(PKG)_DEPS     := cc jpeg libpng


define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && '$(TARGET)-cmake' '$(SOURCE_DIR)' \
        -DCMAKE_INSTALL_PREFIX='$(PREFIX)/$(TARGET)' \
		-DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) \
        -DCMAKE_BUILD_TYPE=Release \
        -DSJPEG_BUILD_EXAMPLES=OFF \
        -DSJPEG_ENABLE_SIMD=ON

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install

    # Generate pkg-config (.pc) file for sjpeg (https://github.com/webmproject/sjpeg/issues/143)
    $(call GENERATE_PC, \
        $(PREFIX)/$(TARGET), \
        sjpeg, \
        Lightweight JPEG encoder with simple C API and optional C++ interface, \
        $($(PKG)_VERSION), \
        libjpeg libpng, \
        , \
        -lsjpeg -ljpeg -lpng, \
    )

    '$(TARGET)-g++' \
        '$(TEST_FILE)' -o '$(PREFIX)/$(TARGET)/bin/test-$(PKG).exe' \
        `$(TARGET)-pkg-config $(PKG) --cflags --libs`
endef
