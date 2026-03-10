# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := de265
$(PKG)_DESCR    := libde265 is an open source implementation of the h.265 video codec
$(PKG)_WEBSITE  := https://github.com/strukturag/libde265
$(PKG)_VERSION  := 1.0.16
$(PKG)_CHECKSUM := ed12c931759c1575848832f70db5071a001ac813db4e4f568ee08aef6e234d4e
$(PKG)_GH_CONF  := strukturag/libde265/tags,v
$(PKG)_DEPS     := cc libjpeg-turbo sdl2

define $(PKG)_BUILD
	mkdir -p '$(BUILD_DIR)'
	cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' \
		-DCMAKE_INSTALL_PREFIX='$(PREFIX)/$(TARGET)' \
		-DCMAKE_BUILD_TYPE=Release \
		-DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) \
		-DENABLE_DECODER=ON \
		-DENABLE_ENCODER=ON \
		-DENABLE_SDL=ON \
		-DCMAKE_POSITION_INDEPENDENT_CODE=ON \
		-DCMAKE_CXX_STANDARD=17 \
		$(if $(APPLE),-DBUILD_FRAMEWORK=OFF,) \
		-DCMAKE_VERBOSE_MAKEFILE=ON

	$(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
	$(MAKE) -C '$(BUILD_DIR)' -j 1 install

	# Compile the test program
	'$(TARGET)-g++' \
		'$(TEST_FILE)' -DLIBDE265_STATIC_BUILD \
		-o '$(PREFIX)/$(TARGET)/bin/test-$(PKG).exe' \
		`$(TARGET)-pkg-config libde265 --cflags --libs`
	cp '$(SOURCE_DIR)/testdata/girlshy.h265' '$(PREFIX)/$(TARGET)/bin/'
endef
