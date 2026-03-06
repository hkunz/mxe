# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := jxl
$(PKG)_WEBSITE  := https://github.com/libjxl/libjxl
$(PKG)_DESCR    := JPEG XL image codec reference implementation
$(PKG)_VERSION  := 0.11.2
$(PKG)_CHECKSUM := ab38928f7f6248e2a98cc184956021acb927b16a0dee71b4d260dc040a4320ea
$(PKG)_GH_CONF  := libjxl/libjxl/tags,v
$(PKG)_DEPS     := cc brotli giflib libjpeg-turbo libpng highway lcms2

define $(PKG)_BUILD
	# Patch CMakeLists.txt to point to MXE Highway
	sed -i -e '/find_package(PkgConfig)/i set(HWY_INCLUDE_DIR "'"$(PREFIX)/$(TARGET)/include"'")' \
	       -e '/find_package(PkgConfig)/i set(HWY_LIBRARY "'"$(PREFIX)/$(TARGET)/lib/libhwy.a"'")' \
	       '$(SOURCE_DIR)/CMakeLists.txt'

	cd '$(BUILD_DIR)' && '$(TARGET)-cmake' '$(SOURCE_DIR)' \
		-DCMAKE_TOOLCHAIN_FILE='$(MXE_CMAKE_TOOLCHAIN)' \
		-DCMAKE_INSTALL_PREFIX='$(PREFIX)/$(TARGET)' \
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
		-DJPEGXL_FORCE_SYSTEM_HWY=ON

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' install
endef
