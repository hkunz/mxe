# This file is part of MXE. See LICENSE.md for licensing information.
# Initial package scaffold generated with the "gsrc" tool:
# https://github.com/hkunz/git-fetcher

PKG             := osl
$(PKG)_WEBSITE  := https://open-shading-language.readthedocs.io/
$(PKG)_DESCR    := Advanced shading language for production GI renderers
$(PKG)_VERSION  := 1.15.3.0
$(PKG)_IGNORE   :=
$(PKG)_CHECKSUM := d11f14c7bd40ffe37e3a0e4739352a1f2b230517aad60669b953ff497ab42572
$(PKG)_GH_CONF  := AcademySoftwareFoundation/OpenShadingLanguage/tags,v
$(PKG)_DEPS     := cc imath llvm openimageio robin-map pthreads zlib partio pugixml

define $(PKG)_BUILD

	# configure package with cmake
	cd "$(BUILD_DIR)" && "$(TARGET)-cmake" "/home/a/workspace/OpenShadingLanguage" \
		-DCMAKE_INSTALL_PREFIX="$(PREFIX)/$(TARGET)" \
		-DCMAKE_PREFIX_PATH="$(PREFIX)/$(TARGET)" \
		-DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) \
		-DBUILD_MISSING_DEPS=OFF \
		-DCLANG_TIDY=OFF \
		-DCLANG_TIDY_FIX=OFF \
		-DCODECOV=OFF \
		-DEXTRA_WARNINGS=OFF \
		-DLINKSTATIC=OFF \
		-DOIIO_FMATH_SIMD_FRIENDLY=OFF \
		-DOSL_ALWAYS_PREFER_CONFIG=OFF \
		-DOSL_BUILD_PLUGINS=OFF \
		-DOSL_BUILD_PROFILER=OFF \
		-DOSL_BUILD_SHADERS=OFF \
		-DOSL_DEPENDENCY_BUILD_VERBOSE=OFF \
		-DOSL_INNER_NAMESPACE_INCLUDE_PATCH=OFF \
		-DOSL_NO_DEFAULT_TEXTURESYSTEM=ON \
		-DOSL_SUPPORTED_RELEASE=ON \
		-DOSL_USE_OPTIX=OFF \
		-DOSL_USTRINGREP_IS_HASH=OFF \
		-DSTOP_ON_WARNING=OFF \
		-DTIME_COMMANDS=OFF \
		-DUSE_CCACHE=OFF \
		-DUSE_FAST_MATH=ON \
		-DVEC_REPORT=OFF \
		-DVERBOSE=OFF \
		-DVISIBILITY_INLINES_HIDDEN=ON \
		-DUSE_PYTHON=OFF \
		-DPYTHON=OFF \
		-DCMAKE_BUILD_TYPE=Release

	# build package and install
	$(MAKE) -C "$(BUILD_DIR)" -j $(JOBS)
	$(MAKE) -C "$(BUILD_DIR)" -j 1 install

	# compile a test program to verify the library is usable
	"$(TARGET)-g++" -Wall -Wextra "$(TEST_FILE)" \
		-o "$(PREFIX)/$(TARGET)/bin/test-$(PKG).exe" \
		`"$(TARGET)-pkg-config" "$(PKG)comp" --cflags --libs`
endef
