//
//  SwiftUsageExamples.swift
//  OpenDroneID Swift Library - Comprehensive Usage Examples
//

import Foundation
import OpenDroneIDSwift

// MARK: - Example 1: Basic ID Message

func exampleBasicIDMessage() {
    print("=== Example 1: Basic ID Message ===")
    
    // Create a Basic ID message
    var basicID = BasicIDData()
    basicID.uaType = .helicopterOrMultirotor
    basicID.idType = .serialNumber
    basicID.uasID = "SWIFT-DRONE-001"
    
    // Create encoder
    let encoder = OpenDroneIDEncoder()
    
    // Encode the message
    do {
        let encodedData = try encoder.encodeBasicID(basicID)
        print("✓ Basic ID encoded successfully")
        print("  Data size: \(encodedData.count) bytes")
        print("  UA Type: \(basicID.uaType)")
        print("  ID Type: \(basicID.idType)")
        print("  UAS ID: \(basicID.uasID)")
        
        // Decode it back
        let decoder = OpenDroneIDDecoder()
        let decoded = try decoder.decodeBasicID(encodedData)
        print("✓ Basic ID decoded successfully")
        print("  Decoded UAS ID: \(decoded.uasID)")
        
    } catch {
        print("✗ Error: \(error)")
    }
}

// MARK: - Example 2: Location Message

func exampleLocationMessage() {
    print("\n=== Example 2: Location Message ===")
    
    // Create a Location message
    var location = LocationData()
    location.status = .airborne
    location.direction = 135.5
    location.speedHorizontal = 15.2
    location.speedVertical = 2.5
    location.latitude = 37.7749  // San Francisco
    location.longitude = -122.4194
    location.altitudeBaro = 100.5
    location.altitudeGeo = 105.0
    location.heightType = .takeoff
    location.height = 50.0
    location.horizAccuracy = ._10meter
    location.vertAccuracy = ._10meter
    location.baroAccuracy = ._10meter
    location.speedAccuracy = ._10metersPerSecond
    location.tsAccuracy = ._0_1second
    location.timeStamp = 1234.5
    
    let encoder = OpenDroneIDEncoder()
    
    do {
        let encodedData = try encoder.encodeLocation(location)
        print("✓ Location encoded successfully")
        print("  Status: \(location.status)")
        print("  Position: (\(location.latitude), \(location.longitude))")
        print("  Altitude (Geo): \(location.altitudeGeo) m")
        print("  Speed (H): \(location.speedHorizontal) m/s")
        print("  Direction: \(location.direction)°")
        
        // Decode it back
        let decoder = OpenDroneIDDecoder()
        let decoded = try decoder.decodeLocation(encodedData)
        print("✓ Location decoded successfully")
        print("  Decoded Position: (\(decoded.latitude), \(decoded.longitude))")
        
    } catch {
        print("✗ Error: \(error)")
    }
}

// MARK: - Example 3: Operator ID Message

func exampleOperatorIDMessage() {
    print("\n=== Example 3: Operator ID Message ===")
    
    var operatorID = OperatorIDData()
    operatorID.operatorIdType = .operatorID
    operatorID.operatorId = "OPERATOR-SWIFT-1"
    
    let encoder = OpenDroneIDEncoder()
    
    do {
        let encodedData = try encoder.encodeOperatorID(operatorID)
        print("✓ Operator ID encoded successfully")
        print("  Operator ID: \(operatorID.operatorId)")
        
        let decoder = OpenDroneIDDecoder()
        let decoded = try decoder.decodeOperatorID(encodedData)
        print("✓ Operator ID decoded successfully")
        print("  Decoded Operator ID: \(decoded.operatorId)")
        
    } catch {
        print("✗ Error: \(error)")
    }
}

// MARK: - Example 4: Self ID Message

func exampleSelfIDMessage() {
    print("\n=== Example 4: Self ID Message ===")
    
    var selfID = SelfIDData()
    selfID.descType = .text
    selfID.desc = "Emergency Response"
    
    let encoder = OpenDroneIDEncoder()
    
    do {
        let encodedData = try encoder.encodeSelfID(selfID)
        print("✓ Self ID encoded successfully")
        print("  Description Type: \(selfID.descType)")
        print("  Description: \(selfID.desc)")
        
        let decoder = OpenDroneIDDecoder()
        let decoded = try decoder.decodeSelfID(encodedData)
        print("✓ Self ID decoded successfully")
        print("  Decoded Description: \(decoded.desc)")
        
    } catch {
        print("✗ Error: \(error)")
    }
}

// MARK: - Example 5: System Message

func exampleSystemMessage() {
    print("\n=== Example 5: System Message ===")
    
    var system = SystemData()
    system.operatorLocationType = .takeoff
    system.classificationType = .eu
    system.operatorLatitude = 37.7749
    system.operatorLongitude = -122.4194
    system.areaCount = 1
    system.areaRadius = 100
    system.areaCeiling = 200.0
    system.areaFloor = 0.0
    system.categoryEU = .open
    system.classEU = .class1
    system.operatorAltitudeGeo = 10.0
    system.timestamp = 12345
    
    let encoder = OpenDroneIDEncoder()
    
    do {
        let encodedData = try encoder.encodeSystem(system)
        print("✓ System message encoded successfully")
        print("  Operator Location: (\(system.operatorLatitude), \(system.operatorLongitude))")
        print("  Area Radius: \(system.areaRadius) m")
        print("  Category EU: \(system.categoryEU)")
        print("  Class EU: \(system.classEU)")
        
        let decoder = OpenDroneIDDecoder()
        let decoded = try decoder.decodeSystem(encodedData)
        print("✓ System message decoded successfully")
        print("  Decoded Area Radius: \(decoded.areaRadius) m")
        
    } catch {
        print("✗ Error: \(error)")
    }
}

// MARK: - Example 6: Authentication Message

func exampleAuthMessage() {
    print("\n=== Example 6: Authentication Message ===")
    
    var auth = AuthData()
    auth.authType = .uasIDSignature
    auth.dataPage = 0
    auth.lastPageIndex = 0
    auth.length = 10
    auth.timestamp = 123456
    auth.authData = Data([0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A])
    
    let encoder = OpenDroneIDEncoder()
    
    do {
        let encodedData = try encoder.encodeAuth(auth)
        print("✓ Auth message encoded successfully")
        print("  Auth Type: \(auth.authType)")
        print("  Data Page: \(auth.dataPage)")
        print("  Auth Data Length: \(auth.authData.count) bytes")
        
        let decoder = OpenDroneIDDecoder()
        let decoded = try decoder.decodeAuth(encodedData)
        print("✓ Auth message decoded successfully")
        print("  Decoded Auth Type: \(decoded.authType)")
        
    } catch {
        print("✗ Error: \(error)")
    }
}

// MARK: - Example 7: Using Accuracy Utilities

func exampleAccuracyUtilities() {
    print("\n=== Example 7: Accuracy Utilities ===")
    
    // Convert float values to enum values
    let horizAccuracy = OpenDroneIDUtilities.createHorizontalAccuracy(5.0)
    let vertAccuracy = OpenDroneIDUtilities.createVerticalAccuracy(8.0)
    let speedAccuracy = OpenDroneIDUtilities.createSpeedAccuracy(2.5)
    let timeAccuracy = OpenDroneIDUtilities.createTimestampAccuracy(0.5)
    
    print("✓ Created accuracy enums:")
    print("  Horizontal (from 5.0m): \(horizAccuracy)")
    print("  Vertical (from 8.0m): \(vertAccuracy)")
    print("  Speed (from 2.5m/s): \(speedAccuracy)")
    print("  Timestamp (from 0.5s): \(timeAccuracy)")
    
    // Convert enum values back to floats
    let decodedHoriz = OpenDroneIDUtilities.decodeHorizontalAccuracy(horizAccuracy)
    let decodedVert = OpenDroneIDUtilities.decodeVerticalAccuracy(vertAccuracy)
    let decodedSpeed = OpenDroneIDUtilities.decodeSpeedAccuracy(speedAccuracy)
    let decodedTime = OpenDroneIDUtilities.decodeTimestampAccuracy(timeAccuracy)
    
    print("\n✓ Decoded accuracy values:")
    print("  Horizontal: \(decodedHoriz) m")
    print("  Vertical: \(decodedVert) m")
    print("  Speed: \(decodedSpeed) m/s")
    print("  Timestamp: \(decodedTime) s")
}

// MARK: - Example 8: Complete Workflow

func exampleCompleteWorkflow() {
    print("\n=== Example 8: Complete Workflow ===")
    print("Simulating a complete drone ID broadcast scenario\n")
    
    let encoder = OpenDroneIDEncoder()
    let decoder = OpenDroneIDDecoder()
    
    // Step 1: Create and encode Basic ID
    var basicID = BasicIDData()
    basicID.uaType = .helicopterOrMultirotor
    basicID.idType = .serialNumber
    basicID.uasID = "MISSION-ALPHA-01"
    
    guard let encodedBasicID = try? encoder.encodeBasicID(basicID) else {
        print("✗ Failed to encode Basic ID")
        return
    }
    print("✓ Step 1: Basic ID encoded (\(encodedBasicID.count) bytes)")
    
    // Step 2: Create and encode Location
    var location = LocationData()
    location.status = .airborne
    location.latitude = 40.7128
    location.longitude = -74.0060  // New York
    location.altitudeGeo = 150.0
    location.speedHorizontal = 12.0
    location.direction = 180.0
    location.horizAccuracy = ._10meter
    
    guard let encodedLocation = try? encoder.encodeLocation(location) else {
        print("✗ Failed to encode Location")
        return
    }
    print("✓ Step 2: Location encoded (\(encodedLocation.count) bytes)")
    
    // Step 3: Create and encode Operator ID
    var operatorID = OperatorIDData()
    operatorID.operatorId = "PILOT-ALPHA"
    
    guard let encodedOperatorID = try? encoder.encodeOperatorID(operatorID) else {
        print("✗ Failed to encode Operator ID")
        return
    }
    print("✓ Step 3: Operator ID encoded (\(encodedOperatorID.count) bytes)")
    
    // Step 4: Create and encode Self ID
    var selfID = SelfIDData()
    selfID.desc = "Aerial Survey"
    
    guard let encodedSelfID = try? encoder.encodeSelfID(selfID) else {
        print("✗ Failed to encode Self ID")
        return
    }
    print("✓ Step 4: Self ID encoded (\(encodedSelfID.count) bytes)")
    
    // Simulate transmission and reception
    print("\n📡 Simulating wireless transmission...")
    
    // Decode received messages
    guard let decodedBasicID = try? decoder.decodeBasicID(encodedBasicID),
          let decodedLocation = try? decoder.decodeLocation(encodedLocation),
          let decodedOperatorID = try? decoder.decodeOperatorID(encodedOperatorID),
          let decodedSelfID = try? decoder.decodeSelfID(encodedSelfID) else {
        print("✗ Failed to decode messages")
        return
    }
    
    print("✓ All messages decoded successfully\n")
    
    // Display received information
    print("📱 Received Drone Information:")
    print("  Aircraft: \(decodedBasicID.uaType)")
    print("  ID: \(decodedBasicID.uasID)")
    print("  Position: (\(decodedLocation.latitude), \(decodedLocation.longitude))")
    print("  Altitude: \(decodedLocation.altitudeGeo) m")
    print("  Speed: \(decodedLocation.speedHorizontal) m/s")
    print("  Direction: \(decodedLocation.direction)°")
    print("  Operator: \(decodedOperatorID.operatorId)")
    print("  Mission: \(decodedSelfID.desc)")
}

// MARK: - Example 9: Error Handling

func exampleErrorHandling() {
    print("\n=== Example 9: Error Handling ===")
    
    let decoder = OpenDroneIDDecoder()
    
    // Try to decode invalid data
    let invalidData = Data([0x00, 0x01, 0x02])
    
    do {
        _ = try decoder.decodeBasicID(invalidData)
        print("✗ Should have thrown an error")
    } catch OpenDroneIDError.decodingFailed(let message) {
        print("✓ Properly caught decoding error: \(message)")
    } catch {
        print("✓ Caught error: \(error)")
    }
}

// MARK: - Example 10: Type Safety Demonstration

func exampleTypeSafety() {
    print("\n=== Example 10: Type Safety Demonstration ===")
    
    // Swift's type system ensures we use the correct enums
    var location = LocationData()
    
    // These are all type-safe assignments
    location.status = .airborne  // Can't use wrong enum type
    location.heightType = .takeoff
    location.horizAccuracy = ._10meter
    location.vertAccuracy = ._3meter
    location.speedAccuracy = ._1metersPerSecond
    location.tsAccuracy = ._0_5second
    
    print("✓ Type-safe assignments:")
    print("  Status: \(location.status)")
    print("  Height Type: \(location.heightType)")
    print("  Horizontal Accuracy: \(location.horizAccuracy)")
    print("  Vertical Accuracy: \(location.vertAccuracy)")
    print("  Speed Accuracy: \(location.speedAccuracy)")
    print("  Timestamp Accuracy: \(location.tsAccuracy)")
    
    // Demonstrate enum raw values are accessible if needed
    print("\n✓ Raw values accessible:")
    print("  Status raw value: \(location.status.rawValue)")
    print("  Horiz accuracy raw value: \(location.horizAccuracy.rawValue)")
}

// MARK: - Main Demo Function

public func runAllSwiftExamples() {
    print("═══════════════════════════════════════════")
    print("OpenDroneID Swift Library - Usage Examples")
    print("═══════════════════════════════════════════\n")
    
    exampleBasicIDMessage()
    exampleLocationMessage()
    exampleOperatorIDMessage()
    exampleSelfIDMessage()
    exampleSystemMessage()
    exampleAuthMessage()
    exampleAccuracyUtilities()
    exampleCompleteWorkflow()
    exampleErrorHandling()
    exampleTypeSafety()
    
    print("\n═══════════════════════════════════════════")
    print("All examples completed successfully!")
    print("═══════════════════════════════════════════")
}

// Uncomment to run when integrated into an app:
// runAllSwiftExamples()
