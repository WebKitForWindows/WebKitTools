include(vcpkg_common_functions)

set(VERSION 0.14)

# Get archive
vcpkg_download_distfile(ARCHIVE
    URLS "https://include-what-you-use.org/downloads/include-what-you-use-${VERSION}.src.tar.gz"
    FILENAME "include-what-you-use-${VERSION}.src.tar.gz"
    SHA512 ac328c6bdf834fde58bbf14c662fdf97aac22a24a85bce4a6475c73027b3ec1c558925efb5f0ac3addf446f21d29e37a70a7c5773c178f9ab7f12e90be7d69b4
)

# Extract archive
vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF ${VERSION}
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
file(INSTALL ${SOURCE_PATH}/LICENSE.TXT DESTINATION ${CURRENT_PACKAGES_DIR}/share/include-what-you-use RENAME copyright)
