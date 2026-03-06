# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := highway
$(PKG)_WEBSITE  := https://github.com/google/highway
$(PKG)_DESCR    := Google Highway SIMD library for portable vectorization
$(PKG)_VERSION  := 1.3.0
$(PKG)_CHECKSUM := 07b3c1ba2c1096878a85a31a5b9b3757427af963b1141ca904db2f9f4afe0bc2
$(PKG)_GH_CONF  := google/highway/tags
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
	cd '$(BUILD_DIR)' && '$(TARGET)-cmake' '$(SOURCE_DIR)' \
		-DCMAKE_TOOLCHAIN_FILE='$(MXE_CMAKE_TOOLCHAIN)' \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_INSTALL_PREFIX='$(PREFIX)/$(TARGET)' \
		-DHWY_CMAKE_HEADER_ONLY=OFF \
		-DHWY_ENABLE_CONTRIB=OFF \
		-DHWY_ENABLE_TESTS=OFF \
		-DHWY_ENABLE_EXAMPLES=OFF \
		-DHWY_ENABLE_INSTALL=ON

	$(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
	$(MAKE) -C '$(BUILD_DIR)' -j 1 install

	'$(TARGET)-g++' \
		'$(TEST_FILE) \
		-o '$(PREFIX)/$(TARGET)/bin/test-highway.exe' \
		`$(TARGET)-pkg-config libhwy --cflags --libs`
endef
