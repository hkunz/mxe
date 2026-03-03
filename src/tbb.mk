# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := tbb
$(PKG)_DESCR    := Intel oneAPI Threading Building Blocks (TBB) library
$(PKG)_WEBSITE  := https://software.intel.com/en-us/oneapi/onetbb
$(PKG)_IGNORE   :=
# Workaround for cross-compilation issue: https://github.com/uxlfoundation/oneTBB/issues/1988
$(PKG)_VERSION  := 2022.3.0-mxe-crosscompile
$(PKG)_CHECKSUM := 05b8cf6418030bd07969b1e9280f9fb55cc3a227adef881c5aa7c951a90ead9c
$(PKG)_GH_CONF  := hkunz/oneTBB/tags,v
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    rm -f "$(BUILD_DIR)/CMakeCache.txt"
    cd '$(BUILD_DIR)' && '$(TARGET)-cmake' '$(SOURCE_DIR)' \
        -DCMAKE_INSTALL_PREFIX=$(PREFIX)/$(TARGET) \
        -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) \
        -DBUILD_STATIC_LIBS=$(CMAKE_STATIC_BOOL) \
        -DTBB_BUILD_TESTS=OFF

    $(MAKE) -C "$(BUILD_DIR)" -j "$(JOBS)"
    $(MAKE) -C "$(BUILD_DIR)" -j 1 install

    $(TARGET)-g++ \
        -I '$(PREFIX)/$(TARGET)/include' \
        -L '$(PREFIX)/$(TARGET)/lib' \
        '$(TEST_FILE)' \
        -o '$(PREFIX)/$(TARGET)/bin/test-tbb.exe' \
        -ltbb12 \
        -ltbbmalloc
endef
