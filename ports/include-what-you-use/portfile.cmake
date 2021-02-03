include(vcpkg_common_functions)

set(VERSION 0.15)

# Get archive
vcpkg_download_distfile(ARCHIVE
    URLS "https://include-what-you-use.org/downloads/include-what-you-use-${VERSION}.src.tar.gz"
    FILENAME "include-what-you-use-${VERSION}.src.tar.gz"
    SHA512 17e368c55103f956c91e6ab7c53c3a4528a21ea352f8217f61d2c741e635707b59c7bf7fec4ed25065f1ed8ec3073eca391123c715fbf624c2c722e61c334534
)

# Extract archive
vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF ${VERSION}
    NO_REMOVE_ONE_LEVEL
)

# Run CMake build
vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    PATCHES ${PATCHES}
)

vcpkg_install_cmake()

# Allow empty include directory
set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

# Prepare distribution
file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools/include-what-you-use)
file(RENAME ${CURRENT_PACKAGES_DIR}/bin/fix_includes.py ${CURRENT_PACKAGES_DIR}/tools/include-what-you-use/fix_includes.py)
file(RENAME ${CURRENT_PACKAGES_DIR}/bin/include-what-you-use.exe ${CURRENT_PACKAGES_DIR}/tools/include-what-you-use/include-what-you-use.exe)
file(RENAME ${CURRENT_PACKAGES_DIR}/bin/iwyu_tool.py ${CURRENT_PACKAGES_DIR}/tools/include-what-you-use/iwyu_tool.py)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug)
file(INSTALL ${SOURCE_PATH}/LICENSE.TXT DESTINATION ${CURRENT_PACKAGES_DIR}/share/include-what-you-use RENAME copyright)
