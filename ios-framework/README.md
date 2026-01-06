# OpenDroneID iOS Framework

This directory contains the iOS framework packaging of the OpenDroneID C library.

## Overview

This framework wraps the OpenDroneID C library for use in iOS applications, providing:
- Pre-built framework binary for iOS devices and simulator
- Swift usage examples
- Bridging header for C to Swift interoperability

## Building the Framework

Use the provided build script to create the iOS framework:

```bash
./build-framework.sh
```

This will create a universal framework that works on both iOS devices (arm64) and simulator (x86_64, arm64).

## Using the Framework

1. Add the framework to your Xcode project
2. Import the bridging header
3. Use the Swift examples as a reference

See `SwiftExamples.swift` for detailed usage examples.

## Requirements

- Xcode 12.0 or later
- iOS 12.0 or later
- macOS 10.15 or later (for building)

## Structure

- `build-framework.sh` - Build script to create the iOS framework
- `OpenDroneID-Bridging-Header.h` - Bridging header for Swift
- `SwiftExamples.swift` - Swift usage examples
- `Info.plist` - Framework configuration
