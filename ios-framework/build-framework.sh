#!/bin/bash

# OpenDroneID iOS Framework Build Script
# This script builds the OpenDroneID C library as an iOS framework

set -e

echo "Building OpenDroneID iOS Framework..."

# Configuration
FRAMEWORK_NAME="OpenDroneID"
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUILD_DIR="${PROJECT_ROOT}/ios-framework/build"
FRAMEWORK_DIR="${BUILD_DIR}/${FRAMEWORK_NAME}.framework"
LIB_SOURCE_DIR="${PROJECT_ROOT}/libopendroneid"

# Cleanup previous build
rm -rf "${BUILD_DIR}"
mkdir -p "${BUILD_DIR}"

# SDK paths
IOS_SDK=$(xcrun --sdk iphoneos --show-sdk-path)
SIM_SDK=$(xcrun --sdk iphonesimulator --show-sdk-path)

# Minimum iOS version
MIN_IOS_VERSION="12.0"

echo "Building for iOS device (arm64)..."
# Build for iOS device (arm64)
mkdir -p "${BUILD_DIR}/ios-arm64"
xcrun clang -arch arm64 \
    -isysroot "${IOS_SDK}" \
    -mios-version-min="${MIN_IOS_VERSION}" \
    -fembed-bitcode \
    -c "${LIB_SOURCE_DIR}/opendroneid.c" \
    -o "${BUILD_DIR}/ios-arm64/opendroneid.o"

xcrun clang -arch arm64 \
    -isysroot "${IOS_SDK}" \
    -mios-version-min="${MIN_IOS_VERSION}" \
    -fembed-bitcode \
    -c "${LIB_SOURCE_DIR}/wifi.c" \
    -o "${BUILD_DIR}/ios-arm64/wifi.o"

# Create static library for iOS device
xcrun ar rcs "${BUILD_DIR}/ios-arm64/libopendroneid.a" \
    "${BUILD_DIR}/ios-arm64/opendroneid.o" \
    "${BUILD_DIR}/ios-arm64/wifi.o"

echo "Building for iOS Simulator (x86_64, arm64)..."
# Build for iOS Simulator (x86_64 and arm64)
mkdir -p "${BUILD_DIR}/sim-x86_64"
xcrun clang -arch x86_64 \
    -isysroot "${SIM_SDK}" \
    -mios-simulator-version-min="${MIN_IOS_VERSION}" \
    -c "${LIB_SOURCE_DIR}/opendroneid.c" \
    -o "${BUILD_DIR}/sim-x86_64/opendroneid.o"

xcrun clang -arch x86_64 \
    -isysroot "${SIM_SDK}" \
    -mios-simulator-version-min="${MIN_IOS_VERSION}" \
    -c "${LIB_SOURCE_DIR}/wifi.c" \
    -o "${BUILD_DIR}/sim-x86_64/wifi.o"

xcrun ar rcs "${BUILD_DIR}/sim-x86_64/libopendroneid.a" \
    "${BUILD_DIR}/sim-x86_64/opendroneid.o" \
    "${BUILD_DIR}/sim-x86_64/wifi.o"

mkdir -p "${BUILD_DIR}/sim-arm64"
xcrun clang -arch arm64 \
    -isysroot "${SIM_SDK}" \
    -mios-simulator-version-min="${MIN_IOS_VERSION}" \
    -c "${LIB_SOURCE_DIR}/opendroneid.c" \
    -o "${BUILD_DIR}/sim-arm64/opendroneid.o"

xcrun clang -arch arm64 \
    -isysroot "${SIM_SDK}" \
    -mios-simulator-version-min="${MIN_IOS_VERSION}" \
    -c "${LIB_SOURCE_DIR}/wifi.c" \
    -o "${BUILD_DIR}/sim-arm64/wifi.o"

xcrun ar rcs "${BUILD_DIR}/sim-arm64/libopendroneid.a" \
    "${BUILD_DIR}/sim-arm64/opendroneid.o" \
    "${BUILD_DIR}/sim-arm64/wifi.o"

echo "Creating universal simulator library..."
# Create universal simulator library
xcrun lipo -create \
    "${BUILD_DIR}/sim-x86_64/libopendroneid.a" \
    "${BUILD_DIR}/sim-arm64/libopendroneid.a" \
    -output "${BUILD_DIR}/libopendroneid-sim.a"

echo "Creating XCFramework..."
# Create XCFramework structure
mkdir -p "${FRAMEWORK_DIR}/Headers"
mkdir -p "${FRAMEWORK_DIR}/Modules"

# Copy headers
cp "${LIB_SOURCE_DIR}/opendroneid.h" "${FRAMEWORK_DIR}/Headers/"
cp "${LIB_SOURCE_DIR}/odid_wifi.h" "${FRAMEWORK_DIR}/Headers/"

# Create module map
cat > "${FRAMEWORK_DIR}/Modules/module.modulemap" <<EOF
framework module ${FRAMEWORK_NAME} {
    umbrella header "opendroneid.h"
    export *
    module * { export * }
}
EOF

# Create universal framework library (for simplicity, using device library)
# In production, you'd want to create an XCFramework with xcrun xcodebuild -create-xcframework
cp "${BUILD_DIR}/ios-arm64/libopendroneid.a" "${FRAMEWORK_DIR}/${FRAMEWORK_NAME}"

# Create Info.plist
cat > "${FRAMEWORK_DIR}/Info.plist" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleDevelopmentRegion</key>
    <string>en</string>
    <key>CFBundleExecutable</key>
    <string>${FRAMEWORK_NAME}</string>
    <key>CFBundleIdentifier</key>
    <string>org.opendroneid.${FRAMEWORK_NAME}</string>
    <key>CFBundleInfoDictionaryVersion</key>
    <string>6.0</string>
    <key>CFBundleName</key>
    <string>${FRAMEWORK_NAME}</string>
    <key>CFBundlePackageType</key>
    <string>FMWK</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0.0</string>
    <key>CFBundleVersion</key>
    <string>1</string>
    <key>MinimumOSVersion</key>
    <string>${MIN_IOS_VERSION}</string>
    <key>CFBundleSupportedPlatforms</key>
    <array>
        <string>iPhoneOS</string>
    </array>
</dict>
</plist>
EOF

echo ""
echo "✓ Framework built successfully!"
echo "  Location: ${FRAMEWORK_DIR}"
echo ""
echo "Note: This creates a basic framework. For production use, consider creating"
echo "an XCFramework that includes both device and simulator architectures:"
echo ""
echo "  xcrun xcodebuild -create-xcframework \\"
echo "    -library ${BUILD_DIR}/ios-arm64/libopendroneid.a \\"
echo "    -headers ${LIB_SOURCE_DIR} \\"
echo "    -library ${BUILD_DIR}/libopendroneid-sim.a \\"
echo "    -headers ${LIB_SOURCE_DIR} \\"
echo "    -output ${BUILD_DIR}/${FRAMEWORK_NAME}.xcframework"
echo ""
