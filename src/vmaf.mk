# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := vmaf
$(PKG)_WEBSITE  := https://github.com/Netflix/vmaf
$(PKG)_DESCR    := Netflix Video Multi-Method Assessment Fusion (VMAF) C library
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 3.0.0
$(PKG)_CHECKSUM := 7178c4833639e6b989ecae73131d02f70735fdb3fc2c7d84bc36c9c3461d93b1
$(PKG)_GH_CONF  := Netflix/vmaf/tags,v
$(PKG)_DEPS     := cc meson-wrapper

define $(PKG)_BUILD
    '$(MXE_MESON_WRAPPER)' $(MXE_MESON_OPTS) \
        -Denable_float=true \
        -Denable_cuda=false \
        '$(BUILD_DIR)' '$(SOURCE_DIR)/libvmaf'

    '$(MXE_NINJA)' -C '$(BUILD_DIR)' -j '$(JOBS)'
    '$(MXE_NINJA)' -C '$(BUILD_DIR)' -j '$(JOBS)' install

    '$(TARGET)-gcc' '$(TEST_FILE)' \
		-o '$(PREFIX)/$(TARGET)/bin/test-$(PKG).exe' \
		`$(TARGET)-pkg-config libvmaf --cflags --libs`
endef
