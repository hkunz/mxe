# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := openimageio
$(PKG)_DESCR    := OpenImageIO - Image processing library for graphics
$(PKG)_WEBSITE  := https://github.com/AcademySoftwareFoundation/OpenImageIO
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 3.1.11.0
$(PKG)_CHECKSUM := 992269ed9b24b17d283a2a05dd11dce582886e97b13b1793eca63b96251b095b
$(PKG)_GH_CONF  := AcademySoftwareFoundation/OpenImageIO/tags,v
$(PKG)_DEPS     := cc zlib libjpeg-turbo libpng tiff imath openexr boost fmt onetbb glm robin-map openjpeg openjph ptex dcmtk freetype giflib jxl libheif libraw libuhdr

define $(PKG)_BUILD
    rm -f '$(BUILD_DIR)/CMakeCache.txt'

    # Backup original build_Robinmap.cmake
    cp '$(SOURCE_DIR)/src/cmake/build_Robinmap.cmake' \
       '$(SOURCE_DIR)/src/cmake/build_Robinmap.cmake.bak'

    # Write patched build_Robinmap.cmake
    $(INSTALL) -d '$(SOURCE_DIR)/src/cmake/tmp_patch'
    echo '# build_dependency_with_cmake() commented out for MXE' > '$(SOURCE_DIR)/src/cmake/tmp_patch/build_Robinmap.cmake'
    echo 'set(Robinmap_ROOT "$(PREFIX)/$(TARGET)/lib/cmake/tsl-robin-map")' >> '$(SOURCE_DIR)/src/cmake/tmp_patch/build_Robinmap.cmake'
    echo 'set(Robinmap_REFIND TRUE)' >> '$(SOURCE_DIR)/src/cmake/tmp_patch/build_Robinmap.cmake'
    echo 'set(Robinmap_VERSION 1.4.1)' >> '$(SOURCE_DIR)/src/cmake/tmp_patch/build_Robinmap.cmake'
    echo 'set(ROBINMAP_INCLUDE_DIR "$(PREFIX)/$(TARGET)/include/tsl")' >> '$(SOURCE_DIR)/src/cmake/tmp_patch/build_Robinmap.cmake'
    echo 'message(STATUS "Robinmap_ROOT = ${Robinmap_ROOT}")' >> '$(SOURCE_DIR)/src/cmake/tmp_patch/build_Robinmap.cmake'
    echo 'message(STATUS "ROBINMAP_INCLUDE_DIR = ${ROBINMAP_INCLUDE_DIR}")' >> '$(SOURCE_DIR)/src/cmake/tmp_patch/build_Robinmap.cmake'

    # Replace original
    mv '$(SOURCE_DIR)/src/cmake/tmp_patch/build_Robinmap.cmake' '$(SOURCE_DIR)/src/cmake/build_Robinmap.cmake'

    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' \
        -DCMAKE_BUILD_TYPE=Release \
        -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) \
        -DBoost_USE_STATIC_LIBS=ON \
        -DUSE_PYTHON=0 \
        -DOIIO_BUILD_TOOLS=OFF \
        -DUSE_OPENVDB=OFF \
        -DUSE_OPENCOLORIO=OFF \
        -DUSE_WEBP=OFF \
        -DUSE_HEIF=OFF \
        -DUSE_FFMPEG=OFF \
        -DGLM_INCLUDE_DIR='$(PREFIX)/$(TARGET)/include' \
        -DBOOST_ROOT='$(PREFIX)/$(TARGET)' \
        -DZLIB_ROOT='$(PREFIX)/$(TARGET)' \
        -DTIFF_ROOT='$(PREFIX)/$(TARGET)' \
        -DJPEG_ROOT='$(PREFIX)/$(TARGET)' \
        -DPNG_ROOT='$(PREFIX)/$(TARGET)' \
        -DOpenEXR_ROOT='$(PREFIX)/$(TARGET)' \
        -DCMAKE_CXX_STANDARD=17 \
        -DCMAKE_INSTALL_PREFIX='$(PREFIX)/$(TARGET)'

    # Build and install OpenImageIO
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install

endef
