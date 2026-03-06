# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := openexr
$(PKG)_WEBSITE  := https://www.openexr.com/
$(PKG)_DESCR    := OpenEXR - high dynamic range image library
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 3.4.6
$(PKG)_CHECKSUM := f8cfe743a81c8cc1dd3cbaafa7fa76f75ad31456b0fc45a42b086d12530a4e35
$(PKG)_GH_CONF  := AcademySoftwareFoundation/openexr/tags,v
$(PKG)_DEPS     := cc imath pthreads zlib

define $(PKG)_BUILD
    mkdir -p '$(BUILD_DIR)'
    cd '$(BUILD_DIR)' && '$(TARGET)-cmake' '$(SOURCE_DIR)' \
        -DCMAKE_INSTALL_PREFIX='$(PREFIX)/$(TARGET)' \
        -DBUILD_SHARED_LIBS=OFF \
        -DILMBASE_ROOT_DIR='$(PREFIX)/$(TARGET)' \
        -DCMAKE_BUILD_TYPE=Release

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install

    '$(TARGET)-g++' \
        '$(TEST_FILE)' -o '$(PREFIX)/$(TARGET)/bin/test-$(PKG).exe' \
        `$(TARGET)-pkg-config OpenEXR --cflags --libs`
endef
