//
//  SwiftExamples.swift
//  OpenDroneID iOS Framework Usage Examples
//
//  This file demonstrates how to use the OpenDroneID C library from Swift
//

import Foundation

// MARK: - Example 1: Creating and Encoding a Basic ID Message

func exampleBasicIDMessage() {
    print("=== Example 1: Basic ID Message ===")
    
    // Initialize the data structure
    var basicIDData = ODID_BasicID_data()
    odid_initBasicIDData(&basicIDData)
    
    // Set the UA (Unmanned Aircraft) type
    basicIDData.UAType = ODID_UATYPE_HELICOPTER_OR_MULTIROTOR
    
    // Set the ID type (Serial Number)
    basicIDData.IDType = ODID_IDTYPE_SERIAL_NUMBER
    
    // Set the UAS ID (max 20 characters)
    let uasID = "DRONE-12345"
    withUnsafeMutablePointer(to: &basicIDData.UASID) { ptr in
        _ = uasID.withCString { cString in
            strncpy(ptr.0, cString, Int(ODID_ID_SIZE))
        }
    }
    
    // Encode the message
    var encodedMessage = ODID_BasicID_encoded()
    let encodeResult = encodeBasicIDMessage(&encodedMessage, &basicIDData)
    
    if encodeResult == ODID_SUCCESS {
        print("✓ Basic ID message encoded successfully")
        print("  UA Type: \(basicIDData.UAType.rawValue)")
        print("  ID Type: \(basicIDData.IDType.rawValue)")
        print("  UAS ID: \(String(cString: &basicIDData.UASID.0))")
    } else {
        print("✗ Failed to encode Basic ID message")
    }
}

// MARK: - Example 2: Creating and Encoding a Location Message

func exampleLocationMessage() {
    print("\n=== Example 2: Location Message ===")
    
    // Initialize the data structure
    var locationData = ODID_Location_data()
    odid_initLocationData(&locationData)
    
    // Set location data
    locationData.Status = ODID_STATUS_AIRBORNE
    locationData.Direction = 135.5  // degrees
    locationData.SpeedHorizontal = 15.2  // m/s
    locationData.SpeedVertical = 2.5  // m/s
    locationData.Latitude = 37.7749  // San Francisco latitude
    locationData.Longitude = -122.4194  // San Francisco longitude
    locationData.AltitudeBaro = 100.5  // meters
    locationData.AltitudeGeo = 105.0  // meters
    locationData.HeightType = ODID_HEIGHT_REF_OVER_TAKEOFF
    locationData.Height = 50.0  // meters
    locationData.HorizAccuracy = ODID_HOR_ACC_10_METER
    locationData.VertAccuracy = ODID_VER_ACC_10_METER
    locationData.BaroAccuracy = ODID_VER_ACC_10_METER
    locationData.SpeedAccuracy = ODID_SPEED_ACC_10_METERS_PER_SECOND
    locationData.TSAccuracy = ODID_TIME_ACC_0_1_SECOND
    locationData.TimeStamp = 1234.5  // seconds after full hour
    
    // Encode the message
    var encodedMessage = ODID_Location_encoded()
    let encodeResult = encodeLocationMessage(&encodedMessage, &locationData)
    
    if encodeResult == ODID_SUCCESS {
        print("✓ Location message encoded successfully")
        print("  Status: \(locationData.Status.rawValue)")
        print("  Latitude: \(locationData.Latitude)")
        print("  Longitude: \(locationData.Longitude)")
        print("  Altitude (Baro): \(locationData.AltitudeBaro) m")
        print("  Speed (H): \(locationData.SpeedHorizontal) m/s")
        print("  Direction: \(locationData.Direction)°")
    } else {
        print("✗ Failed to encode Location message")
    }
}

// MARK: - Example 3: Creating and Encoding an Operator ID Message

func exampleOperatorIDMessage() {
    print("\n=== Example 3: Operator ID Message ===")
    
    // Initialize the data structure
    var operatorIDData = ODID_OperatorID_data()
    odid_initOperatorIDData(&operatorIDData)
    
    // Set operator ID type
    operatorIDData.OperatorIdType = ODID_OPERATOR_ID
    
    // Set the operator ID (max 20 characters)
    let operatorID = "OPERATOR-001"
    withUnsafeMutablePointer(to: &operatorIDData.OperatorId) { ptr in
        _ = operatorID.withCString { cString in
            strncpy(ptr.0, cString, Int(ODID_ID_SIZE))
        }
    }
    
    // Encode the message
    var encodedMessage = ODID_OperatorID_encoded()
    let encodeResult = encodeOperatorIDMessage(&encodedMessage, &operatorIDData)
    
    if encodeResult == ODID_SUCCESS {
        print("✓ Operator ID message encoded successfully")
        print("  Operator ID: \(String(cString: &operatorIDData.OperatorId.0))")
    } else {
        print("✗ Failed to encode Operator ID message")
    }
}

// MARK: - Example 4: Creating and Encoding a Self ID Message

func exampleSelfIDMessage() {
    print("\n=== Example 4: Self ID Message ===")
    
    // Initialize the data structure
    var selfIDData = ODID_SelfID_data()
    odid_initSelfIDData(&selfIDData)
    
    // Set description type
    selfIDData.DescType = ODID_DESC_TYPE_TEXT
    
    // Set the description text (max 23 characters)
    let description = "Emergency Response"
    withUnsafeMutablePointer(to: &selfIDData.Desc) { ptr in
        _ = description.withCString { cString in
            strncpy(ptr.0, cString, Int(ODID_STR_SIZE))
        }
    }
    
    // Encode the message
    var encodedMessage = ODID_SelfID_encoded()
    let encodeResult = encodeSelfIDMessage(&encodedMessage, &selfIDData)
    
    if encodeResult == ODID_SUCCESS {
        print("✓ Self ID message encoded successfully")
        print("  Description: \(String(cString: &selfIDData.Desc.0))")
    } else {
        print("✗ Failed to encode Self ID message")
    }
}

// MARK: - Example 5: Creating and Encoding a System Message

func exampleSystemMessage() {
    print("\n=== Example 5: System Message ===")
    
    // Initialize the data structure
    var systemData = ODID_System_data()
    odid_initSystemData(&systemData)
    
    // Set system data
    systemData.OperatorLocationType = ODID_OPERATOR_LOCATION_TYPE_TAKEOFF
    systemData.ClassificationType = ODID_CLASSIFICATION_TYPE_EU
    systemData.OperatorLatitude = 37.7749  // San Francisco
    systemData.OperatorLongitude = -122.4194
    systemData.AreaCount = 1
    systemData.AreaRadius = 100  // meters
    systemData.AreaCeiling = 200.0  // meters
    systemData.AreaFloor = 0.0  // meters
    systemData.CategoryEU = ODID_CATEGORY_EU_OPEN
    systemData.ClassEU = ODID_CLASS_EU_CLASS_1
    systemData.OperatorAltitudeGeo = 10.0  // meters
    systemData.Timestamp = 12345  // seconds since 00:00:00 01/01/2019
    
    // Encode the message
    var encodedMessage = ODID_System_encoded()
    let encodeResult = encodeSystemMessage(&encodedMessage, &systemData)
    
    if encodeResult == ODID_SUCCESS {
        print("✓ System message encoded successfully")
        print("  Operator Location Type: \(systemData.OperatorLocationType.rawValue)")
        print("  Operator Latitude: \(systemData.OperatorLatitude)")
        print("  Operator Longitude: \(systemData.OperatorLongitude)")
        print("  Area Radius: \(systemData.AreaRadius) m")
        print("  Category EU: \(systemData.CategoryEU.rawValue)")
    } else {
        print("✗ Failed to encode System message")
    }
}

// MARK: - Example 6: Decoding a Basic ID Message

func exampleDecodeBasicID() {
    print("\n=== Example 6: Decoding Basic ID Message ===")
    
    // First, create and encode a message
    var originalData = ODID_BasicID_data()
    odid_initBasicIDData(&originalData)
    originalData.UAType = ODID_UATYPE_AEROPLANE
    originalData.IDType = ODID_IDTYPE_SERIAL_NUMBER
    
    let uasID = "TEST-DECODE-123"
    withUnsafeMutablePointer(to: &originalData.UASID) { ptr in
        _ = uasID.withCString { cString in
            strncpy(ptr.0, cString, Int(ODID_ID_SIZE))
        }
    }
    
    var encodedMessage = ODID_BasicID_encoded()
    _ = encodeBasicIDMessage(&encodedMessage, &originalData)
    
    // Now decode it
    var decodedData = ODID_BasicID_data()
    let decodeResult = decodeBasicIDMessage(&decodedData, &encodedMessage)
    
    if decodeResult == ODID_SUCCESS {
        print("✓ Basic ID message decoded successfully")
        print("  UA Type: \(decodedData.UAType.rawValue)")
        print("  ID Type: \(decodedData.IDType.rawValue)")
        print("  UAS ID: \(String(cString: &decodedData.UASID.0))")
    } else {
        print("✗ Failed to decode Basic ID message")
    }
}

// MARK: - Example 7: Working with Message Packs

func exampleMessagePack() {
    print("\n=== Example 7: Message Pack ===")
    
    // Initialize a message pack (combines multiple messages)
    var packData = ODID_MessagePack_data()
    odid_initMessagePackData(&packData)
    
    // Add a Basic ID message
    var basicIDData = ODID_BasicID_data()
    odid_initBasicIDData(&basicIDData)
    basicIDData.UAType = ODID_UATYPE_HELICOPTER_OR_MULTIROTOR
    basicIDData.IDType = ODID_IDTYPE_SERIAL_NUMBER
    let uasID = "PACK-TEST-001"
    withUnsafeMutablePointer(to: &basicIDData.UASID) { ptr in
        _ = uasID.withCString { cString in
            strncpy(ptr.0, cString, Int(ODID_ID_SIZE))
        }
    }
    packData.BasicID.0 = basicIDData
    packData.BasicIDValid.0 = 1
    
    // Add a Location message
    var locationData = ODID_Location_data()
    odid_initLocationData(&locationData)
    locationData.Status = ODID_STATUS_AIRBORNE
    locationData.Latitude = 40.7128
    locationData.Longitude = -74.0060
    locationData.AltitudeGeo = 150.0
    packData.Location = locationData
    packData.LocationValid = 1
    
    // Encode the message pack
    var encodedPack = ODID_MessagePack_encoded()
    let encodeResult = encodeMessagePack(&encodedPack, &packData)
    
    if encodeResult == ODID_SUCCESS {
        print("✓ Message pack encoded successfully")
        print("  Contains Basic ID: \(packData.BasicIDValid.0 != 0)")
        print("  Contains Location: \(packData.LocationValid != 0)")
    } else {
        print("✗ Failed to encode message pack")
    }
}

// MARK: - Example 8: Using Helper Functions for Accuracy

func exampleAccuracyHelpers() {
    print("\n=== Example 8: Accuracy Helper Functions ===")
    
    // Create accuracy enums from float values
    let horizAccuracy = createEnumHorizontalAccuracy(5.0)
    let vertAccuracy = createEnumVerticalAccuracy(8.0)
    let speedAccuracy = createEnumSpeedAccuracy(2.5)
    let timeAccuracy = createEnumTimestampAccuracy(0.5)
    
    print("✓ Created accuracy enums from values:")
    print("  Horizontal: \(horizAccuracy.rawValue) (from 5.0 meters)")
    print("  Vertical: \(vertAccuracy.rawValue) (from 8.0 meters)")
    print("  Speed: \(speedAccuracy.rawValue) (from 2.5 m/s)")
    print("  Timestamp: \(timeAccuracy.rawValue) (from 0.5 seconds)")
    
    // Decode accuracy values back to floats
    let decodedHoriz = decodeHorizontalAccuracy(horizAccuracy)
    let decodedVert = decodeVerticalAccuracy(vertAccuracy)
    let decodedSpeed = decodeSpeedAccuracy(speedAccuracy)
    let decodedTime = decodeTimestampAccuracy(timeAccuracy)
    
    print("\n✓ Decoded accuracy values:")
    print("  Horizontal: \(decodedHoriz) meters")
    print("  Vertical: \(decodedVert) meters")
    print("  Speed: \(decodedSpeed) m/s")
    print("  Timestamp: \(decodedTime) seconds")
}

// MARK: - Example 9: Complete UAS Data Example

func exampleCompleteUASData() {
    print("\n=== Example 9: Complete UAS Data ===")
    
    // Initialize complete UAS data
    var uasData = ODID_UAS_Data()
    odid_initUasData(&uasData)
    
    // Set Basic ID
    var basicID = ODID_BasicID_data()
    odid_initBasicIDData(&basicID)
    basicID.UAType = ODID_UATYPE_HELICOPTER_OR_MULTIROTOR
    basicID.IDType = ODID_IDTYPE_SERIAL_NUMBER
    let uasID = "UAS-COMPLETE-01"
    withUnsafeMutablePointer(to: &basicID.UASID) { ptr in
        _ = uasID.withCString { cString in
            strncpy(ptr.0, cString, Int(ODID_ID_SIZE))
        }
    }
    uasData.BasicID.0 = basicID
    uasData.BasicIDValid.0 = 1
    
    // Set Location
    var location = ODID_Location_data()
    odid_initLocationData(&location)
    location.Status = ODID_STATUS_AIRBORNE
    location.Latitude = 51.5074
    location.Longitude = -0.1278
    location.AltitudeGeo = 200.0
    location.Direction = 90.0
    location.SpeedHorizontal = 10.0
    uasData.Location = location
    uasData.LocationValid = 1
    
    // Set Operator ID
    var operatorID = ODID_OperatorID_data()
    odid_initOperatorIDData(&operatorID)
    let opID = "OP-12345"
    withUnsafeMutablePointer(to: &operatorID.OperatorId) { ptr in
        _ = opID.withCString { cString in
            strncpy(ptr.0, cString, Int(ODID_ID_SIZE))
        }
    }
    uasData.OperatorID = operatorID
    uasData.OperatorIDValid = 1
    
    print("✓ Complete UAS Data initialized")
    print("  Basic ID Valid: \(uasData.BasicIDValid.0 != 0)")
    print("  Location Valid: \(uasData.LocationValid != 0)")
    print("  Operator ID Valid: \(uasData.OperatorIDValid != 0)")
    print("  UAS ID: \(String(cString: &uasData.BasicID.0.UASID.0))")
    print("  Location: (\(uasData.Location.Latitude), \(uasData.Location.Longitude))")
    print("  Operator ID: \(String(cString: &uasData.OperatorID.OperatorId.0))")
}

// MARK: - Main Demo Function

func runAllExamples() {
    print("OpenDroneID Swift Examples")
    print("==========================\n")
    
    exampleBasicIDMessage()
    exampleLocationMessage()
    exampleOperatorIDMessage()
    exampleSelfIDMessage()
    exampleSystemMessage()
    exampleDecodeBasicID()
    exampleMessagePack()
    exampleAccuracyHelpers()
    exampleCompleteUASData()
    
    print("\n==========================")
    print("All examples completed!")
}

// Uncomment to run when integrated into an iOS app:
// runAllExamples()
