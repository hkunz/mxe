# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libspnav
$(PKG)_WEBSITE  := https://github.com/FreeSpacenav/libspnav
$(PKG)_DESCR    := The FreeSpacenav library for 3D input devices (e.g., SpaceMouse)
$(PKG)_VERSION  := 1.2
$(PKG)_FILE     := libspnav-$($(PKG)_VERSION).tar.gz
$(PKG)_CHECKSUM := dff9ca1102e894f26810c3ee8b3762fd03d4ea243d7ab408f763b6e957e3eb94
$(PKG)_SUBDIR   := libspnav-$($(PKG)_VERSION)
$(PKG)_URL      := https://github.com/FreeSpacenav/libspnav/releases/download/v$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_DEPS     :=

define $(PKG)_BUILD
    @echo "HARRY: SOURCE_DIR = '$(SOURCE_DIR)'"
    @echo "HARRY: PREFIX = '$(PREFIX)'"
    @echo "HARRY: TARGET = '$(TARGET)'"
    @echo "HARRY: JOBS = '$(JOBS)'"
    @echo "HARRY: PKG_FILE = '$($(PKG)_FILE)'"
    @echo "HARRY: PKG_SUBDIR = '$($(PKG)_SUBDIR)'"

    # Build everything in a single shell so HOST_TRIPLET is available
    cd '$(SOURCE_DIR)'; \
    HOST_TRIPLET=$$(echo "$(TARGET)" | sed 's/\.static$$//'); \
    echo "HARRY: TARGET before split = '$(TARGET)'"; \
    echo "HARRY: HOST_TRIPLET after split = $$HOST_TRIPLET"; \
    echo "HARRY: CONFIGURE CMD: ./configure --host=$$HOST_TRIPLET --prefix='$(PREFIX)/$(TARGET)' --disable-shared --enable-static"; \
    ./configure --host=$$HOST_TRIPLET --prefix='$(PREFIX)/$(TARGET)' --disable-shared --enable-static; \
    echo "HARRY: MAKE CMD: make -j '$(JOBS)'"; \
    make -j '$(JOBS)'; \
    echo "HARRY: INSTALL CMD: make install"; \
    make install; \
    echo "HARRY: BUILD DONE"
endef
