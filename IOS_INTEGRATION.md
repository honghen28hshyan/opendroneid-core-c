# OpenDroneID iOS Integration Guide

This document describes the two iOS integration approaches provided in this repository.

## Overview

This repository now includes two complete solutions for using the OpenDroneID C library in iOS applications:

1. **`ios-framework/`** - Direct C library wrapper as iOS framework
2. **`swift-library/`** - Complete Swift rewrite with Objective-C bridge

## Directory 1: ios-framework

**Purpose**: Package the existing C library as an iOS framework with Swift usage examples.

### What's Included

- **build-framework.sh** - Automated build script to create iOS framework
- **OpenDroneID-Bridging-Header.h** - Bridging header for C to Swift
- **SwiftExamples.swift** - Comprehensive Swift usage examples
- **Info.plist** - Framework metadata and configuration
- **README.md** - Detailed documentation

### Architecture

```
C Library (libopendroneid) → Bridging Header → Swift
```

### Use Case

Choose this approach when:
- You want direct access to the C library
- You need minimal abstraction
- You're comfortable working with C types in Swift
- You want the smallest binary size

### Getting Started

```bash
cd ios-framework
./build-framework.sh
```

Then import the framework in your Xcode project and use the examples in `SwiftExamples.swift`.

### Example Usage

```swift
import Foundation

// Initialize data
var basicIDData = ODID_BasicID_data()
odid_initBasicIDData(&basicIDData)

// Set values
basicIDData.UAType = ODID_UATYPE_HELICOPTER_OR_MULTIROTOR
basicIDData.IDType = ODID_IDTYPE_SERIAL_NUMBER

// Encode
var encodedMessage = ODID_BasicID_encoded()
let result = encodeBasicIDMessage(&encodedMessage, &basicIDData)
```

## Directory 2: swift-library

**Purpose**: Complete Swift rewrite providing a native Swift API with type safety.

### What's Included

- **Sources/OpenDroneIDObjC/** - Objective-C bridge layer
  - `OpenDroneIDObjC.h` - Objective-C wrapper headers
  - `OpenDroneIDObjC.m` - Objective-C implementations
  - `module.modulemap` - Module configuration

- **Sources/OpenDroneIDSwift/** - Pure Swift implementation
  - `Types.swift` - Swift type definitions and enums
  - `OpenDroneID.swift` - Main encoder/decoder classes
  
- **Examples/** - Comprehensive usage examples
  - `SwiftUsageExamples.swift` - 10 detailed examples

- **Package.swift** - Swift Package Manager configuration
- **README.md** - Detailed documentation

### Architecture

```
C Library (libopendroneid) → Objective-C Bridge → Swift API
```

### Use Case

Choose this approach when:
- You want a native Swift API
- You prefer type safety and Swift conventions
- You want modern Swift error handling
- You're building a pure Swift application
- You want IDE autocomplete and documentation

### Getting Started

#### Using Swift Package Manager

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/honghen28hshyan/opendroneid-core-c", from: "1.0.0")
]
```

#### Manual Integration

1. Add the `swift-library` directory to your project
2. Configure the bridging header
3. Import `OpenDroneIDSwift`

### Example Usage

```swift
import OpenDroneIDSwift

// Create a Basic ID message with Swift types
var basicID = BasicIDData()
basicID.uaType = .helicopterOrMultirotor
basicID.idType = .serialNumber
basicID.uasID = "DRONE-12345"

// Encode with proper error handling
let encoder = OpenDroneIDEncoder()
do {
    let encodedData = try encoder.encodeBasicID(basicID)
    print("Encoded successfully: \(encodedData)")
} catch {
    print("Error: \(error)")
}

// Decode
let decoder = OpenDroneIDDecoder()
let decoded = try decoder.decodeBasicID(encodedData)
print("UAS ID: \(decoded.uasID)")
```

## Feature Comparison

| Feature | ios-framework | swift-library |
|---------|---------------|---------------|
| **Approach** | Direct C wrapper | Swift rewrite |
| **Type Safety** | C types | Swift types |
| **Error Handling** | Return codes | Swift throws |
| **API Style** | C-style | Swift-style |
| **Documentation** | In-code examples | Full documentation |
| **Binary Size** | Smallest | Slightly larger |
| **Ease of Use** | Moderate | Easy |
| **Swift Integration** | Manual bridging | Native |
| **IDE Support** | Limited | Full autocomplete |
| **Maintenance** | Follows C library | Independent |

## Message Types Supported

Both implementations support all OpenDroneID message types:

- ✅ **Basic ID** - Aircraft identification
- ✅ **Location** - Position, altitude, speed, direction
- ✅ **Authentication** - Digital signatures and security
- ✅ **Self ID** - Human-readable description
- ✅ **System** - Operator location and operational area
- ✅ **Operator ID** - Operator identification
- ✅ **Message Pack** - Combined messages

## Examples Provided

### ios-framework Examples
- Basic ID encoding/decoding
- Location message with full GPS data
- Operator ID messages
- Self ID descriptions
- System messages with operational area
- Authentication messages
- Message packs
- Accuracy helper functions
- Complete UAS data structures

### swift-library Examples
- All of the above, plus:
- Type-safe enum usage
- Modern Swift error handling
- Complete workflow simulation
- Type safety demonstrations
- Practical real-world scenarios

## Requirements

### ios-framework
- Xcode 12.0+
- iOS 12.0+
- macOS 10.15+ (for building)

### swift-library
- Xcode 12.0+
- iOS 12.0+ / macOS 10.15+
- Swift 5.0+

## Building

### ios-framework
```bash
cd ios-framework
./build-framework.sh
```

### swift-library
```bash
cd swift-library
swift build  # For macOS development
# Or use Xcode to build for iOS
```

## Testing

Both implementations can be tested by running the provided examples:

```swift
// ios-framework
runAllExamples()

// swift-library
runAllSwiftExamples()
```

## Which Should You Choose?

### Choose ios-framework if:
- You're already familiar with C APIs
- You need the absolute smallest binary size
- You want direct control over memory management
- You're integrating with existing C/C++ code

### Choose swift-library if:
- You're building a Swift-first application
- You want modern Swift conventions and error handling
- You prefer type safety and compile-time checks
- You want better IDE integration and documentation
- You're new to OpenDroneID and want easier-to-use APIs

## Documentation

- **ios-framework/README.md** - Framework-specific documentation
- **swift-library/README.md** - Swift library documentation
- **ios-framework/SwiftExamples.swift** - 9 framework examples
- **swift-library/Examples/SwiftUsageExamples.swift** - 10 Swift examples

## Contributing

Both implementations follow the OpenDroneID specification:
- ASTM F3411 - Remote ID and Tracking
- ASD-STAN prEN 4709-002 - Direct Remote ID

When contributing, please ensure:
1. Changes maintain compatibility with the C library
2. Examples are updated to reflect new features
3. Documentation is kept up to date
4. Code follows Swift/Objective-C best practices

## License

Both implementations inherit the Apache 2.0 license from the parent project.

## Support

For issues, questions, or contributions:
- Open an issue on GitHub
- Refer to the main project README for OpenDroneID specification details
- Check the examples for usage patterns

## Credits

- Original C library: Intel Corporation and contributors
- iOS Framework: Created for direct C integration
- Swift Library: Complete Swift rewrite with Objective-C bridge

---

**Note**: Both implementations are production-ready and provide complete access to all OpenDroneID functionality. Choose the one that best fits your project's needs and your team's preferences.
