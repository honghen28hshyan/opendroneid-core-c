//
//  OpenDroneID.swift
//  OpenDroneID Swift Library - Main Interface
//

import Foundation
import OpenDroneIDObjC

// MARK: - OpenDroneID Encoder

/// Swift encoder for OpenDroneID messages
public class OpenDroneIDEncoder {
    
    private let objcEncoder = ODIDEncoder()
    
    public init() {}
    
    /// Encode a Basic ID message
    /// - Parameter basicID: The Basic ID data to encode
    /// - Returns: Encoded message data
    /// - Throws: OpenDroneIDError if encoding fails
    public func encodeBasicID(_ basicID: BasicIDData) throws -> Data {
        let objcBasicID = ODIDBasicID()
        objcBasicID.uaType = Int32(basicID.uaType.rawValue)
        objcBasicID.idType = Int32(basicID.idType.rawValue)
        objcBasicID.uasID = basicID.uasID
        
        var error: NSError?
        guard let data = objcEncoder.encodeBasicID(objcBasicID, error: &error) else {
            throw OpenDroneIDError.encodingFailed(error?.localizedDescription ?? "Unknown error")
        }
        
        return data
    }
    
    /// Encode a Location message
    /// - Parameter location: The Location data to encode
    /// - Returns: Encoded message data
    /// - Throws: OpenDroneIDError if encoding fails
    public func encodeLocation(_ location: LocationData) throws -> Data {
        let objcLocation = ODIDLocation()
        objcLocation.status = Int32(location.status.rawValue)
        objcLocation.direction = location.direction
        objcLocation.speedHorizontal = location.speedHorizontal
        objcLocation.speedVertical = location.speedVertical
        objcLocation.latitude = location.latitude
        objcLocation.longitude = location.longitude
        objcLocation.altitudeBaro = location.altitudeBaro
        objcLocation.altitudeGeo = location.altitudeGeo
        objcLocation.heightType = Int32(location.heightType.rawValue)
        objcLocation.height = location.height
        objcLocation.horizAccuracy = Int32(location.horizAccuracy.rawValue)
        objcLocation.vertAccuracy = Int32(location.vertAccuracy.rawValue)
        objcLocation.baroAccuracy = Int32(location.baroAccuracy.rawValue)
        objcLocation.speedAccuracy = Int32(location.speedAccuracy.rawValue)
        objcLocation.tsAccuracy = Int32(location.tsAccuracy.rawValue)
        objcLocation.timeStamp = location.timeStamp
        
        var error: NSError?
        guard let data = objcEncoder.encodeLocation(objcLocation, error: &error) else {
            throw OpenDroneIDError.encodingFailed(error?.localizedDescription ?? "Unknown error")
        }
        
        return data
    }
    
    /// Encode an Auth message
    /// - Parameter auth: The Auth data to encode
    /// - Returns: Encoded message data
    /// - Throws: OpenDroneIDError if encoding fails
    public func encodeAuth(_ auth: AuthData) throws -> Data {
        let objcAuth = ODIDAuth()
        objcAuth.authType = Int32(auth.authType.rawValue)
        objcAuth.dataPage = Int32(auth.dataPage)
        objcAuth.lastPageIndex = Int32(auth.lastPageIndex)
        objcAuth.length = Int32(auth.length)
        objcAuth.timestamp = auth.timestamp
        objcAuth.authData = auth.authData
        
        var error: NSError?
        guard let data = objcEncoder.encodeAuth(objcAuth, error: &error) else {
            throw OpenDroneIDError.encodingFailed(error?.localizedDescription ?? "Unknown error")
        }
        
        return data
    }
    
    /// Encode a Self ID message
    /// - Parameter selfID: The Self ID data to encode
    /// - Returns: Encoded message data
    /// - Throws: OpenDroneIDError if encoding fails
    public func encodeSelfID(_ selfID: SelfIDData) throws -> Data {
        let objcSelfID = ODIDSelfID()
        objcSelfID.descType = Int32(selfID.descType.rawValue)
        objcSelfID.desc = selfID.desc
        
        var error: NSError?
        guard let data = objcEncoder.encodeSelfID(objcSelfID, error: &error) else {
            throw OpenDroneIDError.encodingFailed(error?.localizedDescription ?? "Unknown error")
        }
        
        return data
    }
    
    /// Encode a System message
    /// - Parameter system: The System data to encode
    /// - Returns: Encoded message data
    /// - Throws: OpenDroneIDError if encoding fails
    public func encodeSystem(_ system: SystemData) throws -> Data {
        let objcSystem = ODIDSystem()
        objcSystem.operatorLocationType = Int32(system.operatorLocationType.rawValue)
        objcSystem.classificationType = Int32(system.classificationType.rawValue)
        objcSystem.operatorLatitude = system.operatorLatitude
        objcSystem.operatorLongitude = system.operatorLongitude
        objcSystem.areaCount = system.areaCount
        objcSystem.areaRadius = system.areaRadius
        objcSystem.areaCeiling = system.areaCeiling
        objcSystem.areaFloor = system.areaFloor
        objcSystem.categoryEU = Int32(system.categoryEU.rawValue)
        objcSystem.classEU = Int32(system.classEU.rawValue)
        objcSystem.operatorAltitudeGeo = system.operatorAltitudeGeo
        objcSystem.timestamp = system.timestamp
        
        var error: NSError?
        guard let data = objcEncoder.encodeSystem(objcSystem, error: &error) else {
            throw OpenDroneIDError.encodingFailed(error?.localizedDescription ?? "Unknown error")
        }
        
        return data
    }
    
    /// Encode an Operator ID message
    /// - Parameter operatorID: The Operator ID data to encode
    /// - Returns: Encoded message data
    /// - Throws: OpenDroneIDError if encoding fails
    public func encodeOperatorID(_ operatorID: OperatorIDData) throws -> Data {
        let objcOperatorID = ODIDOperatorID()
        objcOperatorID.operatorIdType = Int32(operatorID.operatorIdType.rawValue)
        objcOperatorID.operatorId = operatorID.operatorId
        
        var error: NSError?
        guard let data = objcEncoder.encodeOperatorID(objcOperatorID, error: &error) else {
            throw OpenDroneIDError.encodingFailed(error?.localizedDescription ?? "Unknown error")
        }
        
        return data
    }
}

// MARK: - OpenDroneID Decoder

/// Swift decoder for OpenDroneID messages
public class OpenDroneIDDecoder {
    
    private let objcDecoder = ODIDDecoder()
    
    public init() {}
    
    /// Decode a Basic ID message
    /// - Parameter data: The encoded message data
    /// - Returns: Decoded Basic ID data
    /// - Throws: OpenDroneIDError if decoding fails
    public func decodeBasicID(_ data: Data) throws -> BasicIDData {
        var error: NSError?
        guard let objcBasicID = objcDecoder.decodeBasicID(data, error: &error) else {
            throw OpenDroneIDError.decodingFailed(error?.localizedDescription ?? "Unknown error")
        }
        
        var basicID = BasicIDData()
        basicID.uaType = UAType(rawValue: Int(objcBasicID.uaType)) ?? .none
        basicID.idType = IDType(rawValue: Int(objcBasicID.idType)) ?? .none
        basicID.uasID = objcBasicID.uasID
        
        return basicID
    }
    
    /// Decode a Location message
    /// - Parameter data: The encoded message data
    /// - Returns: Decoded Location data
    /// - Throws: OpenDroneIDError if decoding fails
    public func decodeLocation(_ data: Data) throws -> LocationData {
        var error: NSError?
        guard let objcLocation = objcDecoder.decodeLocation(data, error: &error) else {
            throw OpenDroneIDError.decodingFailed(error?.localizedDescription ?? "Unknown error")
        }
        
        var location = LocationData()
        location.status = Status(rawValue: Int(objcLocation.status)) ?? .undeclared
        location.direction = objcLocation.direction
        location.speedHorizontal = objcLocation.speedHorizontal
        location.speedVertical = objcLocation.speedVertical
        location.latitude = objcLocation.latitude
        location.longitude = objcLocation.longitude
        location.altitudeBaro = objcLocation.altitudeBaro
        location.altitudeGeo = objcLocation.altitudeGeo
        location.heightType = HeightReference(rawValue: Int(objcLocation.heightType)) ?? .takeoff
        location.height = objcLocation.height
        location.horizAccuracy = HorizontalAccuracy(rawValue: Int(objcLocation.horizAccuracy)) ?? .unknown
        location.vertAccuracy = VerticalAccuracy(rawValue: Int(objcLocation.vertAccuracy)) ?? .unknown
        location.baroAccuracy = VerticalAccuracy(rawValue: Int(objcLocation.baroAccuracy)) ?? .unknown
        location.speedAccuracy = SpeedAccuracy(rawValue: Int(objcLocation.speedAccuracy)) ?? .unknown
        location.tsAccuracy = TimestampAccuracy(rawValue: Int(objcLocation.tsAccuracy)) ?? .unknown
        location.timeStamp = objcLocation.timeStamp
        
        return location
    }
    
    /// Decode an Auth message
    /// - Parameter data: The encoded message data
    /// - Returns: Decoded Auth data
    /// - Throws: OpenDroneIDError if decoding fails
    public func decodeAuth(_ data: Data) throws -> AuthData {
        var error: NSError?
        guard let objcAuth = objcDecoder.decodeAuth(data, error: &error) else {
            throw OpenDroneIDError.decodingFailed(error?.localizedDescription ?? "Unknown error")
        }
        
        var auth = AuthData()
        auth.authType = AuthType(rawValue: Int(objcAuth.authType)) ?? .none
        auth.dataPage = Int(objcAuth.dataPage)
        auth.lastPageIndex = Int(objcAuth.lastPageIndex)
        auth.length = Int(objcAuth.length)
        auth.timestamp = objcAuth.timestamp
        auth.authData = objcAuth.authData
        
        return auth
    }
    
    /// Decode a Self ID message
    /// - Parameter data: The encoded message data
    /// - Returns: Decoded Self ID data
    /// - Throws: OpenDroneIDError if decoding fails
    public func decodeSelfID(_ data: Data) throws -> SelfIDData {
        var error: NSError?
        guard let objcSelfID = objcDecoder.decodeSelfID(data, error: &error) else {
            throw OpenDroneIDError.decodingFailed(error?.localizedDescription ?? "Unknown error")
        }
        
        var selfID = SelfIDData()
        selfID.descType = DescType(rawValue: Int(objcSelfID.descType)) ?? .text
        selfID.desc = objcSelfID.desc
        
        return selfID
    }
    
    /// Decode a System message
    /// - Parameter data: The encoded message data
    /// - Returns: Decoded System data
    /// - Throws: OpenDroneIDError if decoding fails
    public func decodeSystem(_ data: Data) throws -> SystemData {
        var error: NSError?
        guard let objcSystem = objcDecoder.decodeSystem(data, error: &error) else {
            throw OpenDroneIDError.decodingFailed(error?.localizedDescription ?? "Unknown error")
        }
        
        var system = SystemData()
        system.operatorLocationType = OperatorLocationType(rawValue: Int(objcSystem.operatorLocationType)) ?? .takeoff
        system.classificationType = ClassificationType(rawValue: Int(objcSystem.classificationType)) ?? .undeclared
        system.operatorLatitude = objcSystem.operatorLatitude
        system.operatorLongitude = objcSystem.operatorLongitude
        system.areaCount = objcSystem.areaCount
        system.areaRadius = objcSystem.areaRadius
        system.areaCeiling = objcSystem.areaCeiling
        system.areaFloor = objcSystem.areaFloor
        system.categoryEU = CategoryEU(rawValue: Int(objcSystem.categoryEU)) ?? .undeclared
        system.classEU = ClassEU(rawValue: Int(objcSystem.classEU)) ?? .undeclared
        system.operatorAltitudeGeo = objcSystem.operatorAltitudeGeo
        system.timestamp = objcSystem.timestamp
        
        return system
    }
    
    /// Decode an Operator ID message
    /// - Parameter data: The encoded message data
    /// - Returns: Decoded Operator ID data
    /// - Throws: OpenDroneIDError if decoding fails
    public func decodeOperatorID(_ data: Data) throws -> OperatorIDData {
        var error: NSError?
        guard let objcOperatorID = objcDecoder.decodeOperatorID(data, error: &error) else {
            throw OpenDroneIDError.decodingFailed(error?.localizedDescription ?? "Unknown error")
        }
        
        var operatorID = OperatorIDData()
        operatorID.operatorIdType = OperatorIDType(rawValue: Int(objcOperatorID.operatorIdType)) ?? .operatorID
        operatorID.operatorId = objcOperatorID.operatorId
        
        return operatorID
    }
}

// MARK: - Utilities

/// Swift utilities for OpenDroneID
public class OpenDroneIDUtilities {
    
    /// Create a horizontal accuracy enum from a float value
    /// - Parameter accuracy: Accuracy in meters
    /// - Returns: Horizontal accuracy enum value
    public static func createHorizontalAccuracy(_ accuracy: Float) -> HorizontalAccuracy {
        let rawValue = ODIDUtilities.createHorizontalAccuracyEnum(accuracy)
        return HorizontalAccuracy(rawValue: Int(rawValue)) ?? .unknown
    }
    
    /// Create a vertical accuracy enum from a float value
    /// - Parameter accuracy: Accuracy in meters
    /// - Returns: Vertical accuracy enum value
    public static func createVerticalAccuracy(_ accuracy: Float) -> VerticalAccuracy {
        let rawValue = ODIDUtilities.createVerticalAccuracyEnum(accuracy)
        return VerticalAccuracy(rawValue: Int(rawValue)) ?? .unknown
    }
    
    /// Create a speed accuracy enum from a float value
    /// - Parameter accuracy: Accuracy in m/s
    /// - Returns: Speed accuracy enum value
    public static func createSpeedAccuracy(_ accuracy: Float) -> SpeedAccuracy {
        let rawValue = ODIDUtilities.createSpeedAccuracyEnum(accuracy)
        return SpeedAccuracy(rawValue: Int(rawValue)) ?? .unknown
    }
    
    /// Create a timestamp accuracy enum from a float value
    /// - Parameter accuracy: Accuracy in seconds
    /// - Returns: Timestamp accuracy enum value
    public static func createTimestampAccuracy(_ accuracy: Float) -> TimestampAccuracy {
        let rawValue = ODIDUtilities.createTimestampAccuracyEnum(accuracy)
        return TimestampAccuracy(rawValue: Int(rawValue)) ?? .unknown
    }
    
    /// Decode horizontal accuracy enum to float value
    /// - Parameter accuracy: Horizontal accuracy enum
    /// - Returns: Accuracy in meters
    public static func decodeHorizontalAccuracy(_ accuracy: HorizontalAccuracy) -> Float {
        return ODIDUtilities.decodeHorizontalAccuracy(Int32(accuracy.rawValue))
    }
    
    /// Decode vertical accuracy enum to float value
    /// - Parameter accuracy: Vertical accuracy enum
    /// - Returns: Accuracy in meters
    public static func decodeVerticalAccuracy(_ accuracy: VerticalAccuracy) -> Float {
        return ODIDUtilities.decodeVerticalAccuracy(Int32(accuracy.rawValue))
    }
    
    /// Decode speed accuracy enum to float value
    /// - Parameter accuracy: Speed accuracy enum
    /// - Returns: Accuracy in m/s
    public static func decodeSpeedAccuracy(_ accuracy: SpeedAccuracy) -> Float {
        return ODIDUtilities.decodeSpeedAccuracy(Int32(accuracy.rawValue))
    }
    
    /// Decode timestamp accuracy enum to float value
    /// - Parameter accuracy: Timestamp accuracy enum
    /// - Returns: Accuracy in seconds
    public static func decodeTimestampAccuracy(_ accuracy: TimestampAccuracy) -> Float {
        return ODIDUtilities.decodeTimestampAccuracy(Int32(accuracy.rawValue))
    }
}
