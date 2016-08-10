#!/bin/bash

set -e

NAME="tuned-profiles-mongodb"
VERSION="1.0"
NAME_VERSION="${NAME}-${VERSION}"

BASE_DIR="${PWD}"
SRC_DIR="${BASE_DIR}/src"
BUILD_DIR="${BASE_DIR}/tmp"
RPMBUILD_DIR="${HOME}/rpmbuild"
STAGE_DIR="${BUILD_DIR}/${NAME_VERSION}"

SOURCE="${NAME_VERSION}.tar.gz"
SPEC="${NAME}.spec"

echo "Cleaning up any existing builds."
mkdir -p "${BUILD_DIR}"
rm -rf "${BUILD_DIR}"/* >/dev/null

echo "Staging files"
mkdir -p "${STAGE_DIR}"
cp -r "${SRC_DIR}"/* "${STAGE_DIR}"/
gzip "${STAGE_DIR}/share/man/man7/tuned-profiles-mongodb.7"

echo "Creating ${SOURCE}"
tar -C "${BUILD_DIR}" -cvzf "${BUILD_DIR}/${SOURCE}" "${NAME_VERSION}" >/dev/null

echo "Staging RPM build directory"
mkdir -p "${RPMBUILD_DIR}"/{RPMS,SRPMS,BUILD,SOURCES,SPECS,tmp}
cp "${BUILD_DIR}/${SOURCE}" "${RPMBUILD_DIR}/SOURCES/"
cp "${SPEC}" "${RPMBUILD_DIR}/SPECS/"

echo "Building RPM"
rpmbuild -ba ${RPMBUILD_DIR}/SPECS/${SPEC}

echo "Copying RPM"
cp "${RPMBUILD_DIR}/RPMS/noarch/${NAME_VERSION}"-*.rpm "${BASE_DIR}/"

echo "Build complete"
