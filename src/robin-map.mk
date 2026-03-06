# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := robin-map
$(PKG)_DESCR    := Robin Map - fast hash map library (header-only)
$(PKG)_WEBSITE  := https://github.com/Tessil/robin-map
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.4.1
$(PKG)_CHECKSUM := 0e3f53a377fdcdc5f9fed7a4c0d4f99e82bbb64175233bd13427fef9a771f4a1
$(PKG)_GH_CONF  := Tessil/robin-map/tags,v
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    # Create include directory in target
    $(INSTALL) -d '$(PREFIX)/$(TARGET)/include/tsl'

    # Copy headers
    $(CP) -r '$(SOURCE_DIR)/include/tsl' '$(PREFIX)/$(TARGET)/include/'

    # Create cmake directory
    $(INSTALL) -d '$(PREFIX)/$(TARGET)/lib/cmake/tsl-robin-map'

    # Copy a minimal Config.cmake (simulate CMake install)
    echo "include_directories(\${CMAKE_CURRENT_LIST_DIR}/../../../../include)" \
        > '$(PREFIX)/$(TARGET)/lib/cmake/tsl-robin-map/tsl-robin-mapConfig.cmake'

    # Create dummy Targets.cmake (some projects need it)
    echo "# Dummy Targets file for MXE" \
        > '$(PREFIX)/$(TARGET)/lib/cmake/tsl-robin-map/tsl-robin-mapTargets.cmake'
endef
