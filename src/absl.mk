# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := absl
$(PKG)_WEBSITE  := https://abseil.io
$(PKG)_DESCR    := Abseil C++ Common utility library for Google-style C++ development
$(PKG)_VERSION  := 20260107.1
$(PKG)_CHECKSUM := 4314e2a7cbac89cac25a2f2322870f343d81579756ceff7f431803c2c9090195
$(PKG)_GH_CONF  := abseil/abseil-cpp/tags
$(PKG)_DEPS     := cc pthreads

define $(PKG)_BUILD

	cd "$(BUILD_DIR)" && '$(TARGET)-cmake' "$(SOURCE_DIR)" \
		-DCMAKE_INSTALL_PREFIX='$(PREFIX)/$(TARGET)' \
		-DCMAKE_PREFIX_PATH='$(PREFIX)/$(TARGET)' \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_POSITION_INDEPENDENT_CODE=ON \
		-DBUILD_SHARED_LIBS=OFF \
		-DABSL_ENABLE_INSTALL=ON \
		-DABSL_BUILD_TESTING=OFF \
		-DABSL_BUILD_TEST_HELPERS=OFF \
		-DABSL_USE_EXTERNAL_GOOGLETEST=OFF \
		-DABSL_USE_GOOGLETEST_HEAD=OFF \
		-DABSL_BUILD_MONOLITHIC_SHARED_LIBS=ON \
		-DBUILD_STATIC_LIBS=ON \
		-DABSL_USE_CCTZ_TIME_ZONE=ON

	$(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
	$(MAKE) -C '$(BUILD_DIR)' -j 1 install

	# Abseil provides many internal .pc files for each submodule, which is too granular for MXE testing.
	# To simplify and have a usable single entry point, we create our own combined absl.pc.
	$(call GENERATE_PC, \
		$(PREFIX)/$(TARGET), \
		absl, \
		Abseil C++ Common utility library for Google-style C++ development, \
		$($(PKG)_VERSION), \
		, \
		, \
		-labsl_base -labsl_strings -labsl_time -labsl_raw_logging_internal -labsl_hash -labsl_cord -labsl_synchronization -labsl_malloc_internal -labsl_status -labsl_statusor -labsl_int128 -labsl_throw_delegate -lpthread, \
	)

	'$(TARGET)-g++' \
		'$(TEST_FILE)' \
		-o '$(PREFIX)/$(TARGET)/bin/test-$(PKG).exe' \
		`$(TARGET)-pkg-config absl --cflags --libs`
endef
