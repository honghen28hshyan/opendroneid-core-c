# OpenDroneID Swift Library

A complete Swift rewrite of the OpenDroneID C library, using Objective-C as a bridge layer.

## Overview

This is a pure Swift implementation of the OpenDroneID protocol that wraps the underlying C library through an Objective-C bridge. It provides a modern, type-safe Swift API for encoding and decoding Remote ID messages.

## Architecture

The library consists of three layers:

1. **C Layer** (`libopendroneid/`) - The original C implementation
2. **Objective-C Bridge** (`Sources/OpenDroneIDObjC/`) - Objective-C wrappers for the C functions
3. **Swift Layer** (`Sources/OpenDroneIDSwift/`) - Pure Swift API with Swift types and conventions

## Features

- ✅ Type-safe Swift API
- ✅ Comprehensive enum and struct definitions
- ✅ Encode/decode all OpenDroneID message types
- ✅ Support for message packs
- ✅ Helper utilities for accuracy conversions
- ✅ Comprehensive examples
- ✅ Swift Package Manager support

## Installation

### Swift Package Manager

Add this to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/honghen28hshyan/opendroneid-core-c", from: "1.0.0")
]
```

### Manual Integration

1. Copy the `swift-library` directory to your project
2. Add the C source files from `libopendroneid/` to your project
3. Configure the bridging header to include the Objective-C wrapper

## Usage

```swift
import OpenDroneIDSwift

// Create a Basic ID message
var basicID = BasicIDData()
basicID.uaType = .helicopterOrMultirotor
basicID.idType = .serialNumber
basicID.uasID = "DRONE-12345"

// Encode the message
let encoder = OpenDroneIDEncoder()
if let encoded = try? encoder.encodeBasicID(basicID) {
    // Use the encoded message
    print("Encoded successfully")
}

// Decode a message
let decoder = OpenDroneIDDecoder()
if let decoded = try? decoder.decodeBasicID(encoded) {
    print("UAS ID: \(decoded.uasID)")
}
```

See the `Examples` directory for more detailed usage examples.

## Project Structure

```
swift-library/
├── README.md                          # This file
├── Package.swift                      # Swift Package Manager configuration
├── Sources/
│   ├── OpenDroneIDObjC/              # Objective-C bridge layer
│   │   ├── OpenDroneIDObjC.h         # Public Objective-C header
│   │   ├── OpenDroneIDObjC.m         # Objective-C implementations
│   │   └── module.modulemap          # Module map
│   └── OpenDroneIDSwift/             # Pure Swift implementation
│       ├── OpenDroneID.swift         # Main Swift types
│       ├── Encoder.swift             # Encoding functions
│       ├── Decoder.swift             # Decoding functions
│       ├── Types.swift               # Swift type definitions
│       └── Utilities.swift           # Helper utilities
└── Examples/
    └── SwiftUsageExamples.swift      # Comprehensive examples
```

## Supported Message Types

- ✅ Basic ID
- ✅ Location
- ✅ Authentication
- ✅ Self ID
- ✅ System
- ✅ Operator ID
- ✅ Message Pack

## Requirements

- iOS 12.0+ / macOS 10.15+
- Swift 5.0+
- Xcode 12.0+

## License

Apache 2.0 - See LICENSE file

## Contributing

Contributions are welcome! Please feel free to submit pull requests.
