# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := jxl
$(PKG)_WEBSITE  := https://github.com/libjxl/libjxl
$(PKG)_DESCR    := JPEG XL image codec reference implementation
$(PKG)_VERSION  := 0.11.2
$(PKG)_CHECKSUM := ab38928f7f6248e2a98cc184956021acb927b16a0dee71b4d260dc040a4320ea
$(PKG)_GH_CONF  := libjxl/libjxl/tags,v
$(PKG)_DEPS     := cc brotli sjpeg giflib libjpeg-turbo libpng highway lcms2

define $(PKG)_BUILD

	# Patch the upstream CMakeLists.txt to use CONFIG mode for LCMS2:
	# Replaces `find_package(LCMS2 2.12)` with `find_package(LCMS2 2.12 CONFIG)` 
	# so CMake can locate MXE-installed LCMS2. Fixes issue reported in:
	# https://github.com/libjxl/libjxl/pull/4655
	sed -i 's/find_package(LCMS2 2.12)/find_package(LCMS2 2.12 CONFIG)/' "$(SOURCE_DIR)/third_party/CMakeLists.txt"

	cd "$(BUILD_DIR)" && \
	$(TARGET)-cmake "$(SOURCE_DIR)" \
		-DCMAKE_TOOLCHAIN_FILE='$(MXE_CMAKE_TOOLCHAIN)' \
		-DCMAKE_INSTALL_PREFIX='$(PREFIX)/$(TARGET)' \
		-DCMAKE_PREFIX_PATH='$(PREFIX)/$(TARGET)' \
		-DCMAKE_BUILD_TYPE=Release \
		-DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) \
		-DJPEGXL_ENABLE_TOOLS=OFF \
		-DJPEGXL_ENABLE_EXAMPLES=OFF \
		-DJPEGXL_ENABLE_BENCHMARK=OFF \
		-DBUILD_TESTING=OFF \
		-DJPEGXL_ENABLE_DOXYGEN=OFF \
		-DJPEGXL_ENABLE_MANPAGES=OFF \
		-DJPEGXL_FORCE_SYSTEM_BROTLI=ON \
		-DJPEGXL_FORCE_SYSTEM_LCMS2=ON \
		-DJPEGXL_FORCE_SYSTEM_HWY=ON \
		-DJPEGXL_ENABLE_SJPEG=OFF \
		-DJPEGXL_ENABLE_SKCMS=OFF \
		-DJPEGXL_BUNDLE_LIBPNG=OFF \
		-DPROVISION_DEPENDENCIES=OFF

	$(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
	$(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
