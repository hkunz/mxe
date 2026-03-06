# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := lcms2
$(PKG)_WEBSITE  := https://github.com/mm2/Little-CMS
$(PKG)_DESCR    := Little CMS color management engine library
$(PKG)_URL      := https://github.com/mm2/Little-CMS/archive/refs/heads/master.tar.gz
# Repository is transitioning from Meson to CMake; waiting for stable tags
$(PKG)_VERSION  := master
$(PKG)_CHECKSUM := acdced72fdfbf6eefccc3c2dfd6552ef438b88fa3107356ebaa8b10b72bc8520
$(PKG)_GH_CONF  := mm2/Little-CMS/tags
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && '$(TARGET)-cmake' '$(SOURCE_DIR)' \
        -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) \
        -DBUILD_STATIC_LIBS=$(if $(CMAKE_SHARED_BOOL),OFF,ON) \
        -DCMAKE_INSTALL_PREFIX='$(PREFIX)/$(TARGET)' \
        -DCMAKE_BUILD_TYPE=Release \
        -DLCMS2_BUILD_TESTS=OFF

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install

    '$(TARGET)-gcc' \
        '$(TEST_FILE)' -o '$(PREFIX)/$(TARGET)/bin/test-lcms2.exe' \
        `$(TARGET)-pkg-config lcms2 --cflags --libs`
endef
