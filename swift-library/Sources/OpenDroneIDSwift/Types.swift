//
//  Types.swift
//  OpenDroneID Swift Library - Type Definitions
//

import Foundation

// MARK: - Enumerations

/// UA (Unmanned Aircraft) Type
public enum UAType: Int {
    case none = 0
    case aeroplane = 1
    case helicopterOrMultirotor = 2
    case gyroplane = 3
    case hybridLift = 4
    case ornithopter = 5
    case glider = 6
    case kite = 7
    case freeBalloon = 8
    case captiveBalloon = 9
    case airship = 10
    case freeFallOrParachute = 11
    case rocket = 12
    case tetheredPoweredAircraft = 13
    case groundObstacle = 14
    case other = 15
}

/// ID Type
public enum IDType: Int {
    case none = 0
    case serialNumber = 1
    case cadRegistrationID = 2
    case utmAssigned = 3
    case specificSessionID = 4
}

/// Status
public enum Status: Int {
    case undeclared = 0
    case ground = 1
    case airborne = 2
    case emergency = 3
    case remoteIDSystemFailure = 4
}

/// Height Reference Type
public enum HeightReference: Int {
    case takeoff = 0
    case ground = 1
}

/// Horizontal Accuracy
public enum HorizontalAccuracy: Int {
    case unknown = 0
    case _10nm = 1           // >= 18.52 km (10 NM)
    case _4nm = 2            // < 18.52 km (10 NM)
    case _2nm = 3            // < 7.408 km (4 NM)
    case _1nm = 4            // < 3.704 km (2 NM)
    case _0_5nm = 5          // < 1852 m (1 NM)
    case _0_3nm = 6          // < 926 m (0.5 NM)
    case _0_1nm = 7          // < 555.6 m (0.3 NM)
    case _0_05nm = 8         // < 185.2 m (0.1 NM)
    case _30meter = 9        // < 92.6 m (0.05 NM)
    case _10meter = 10       // < 30 m
    case _3meter = 11        // < 10 m
    case _1meter = 12        // < 3 m
}

/// Vertical Accuracy
public enum VerticalAccuracy: Int {
    case unknown = 0
    case _150meter = 1       // >= 150 m
    case _45meter = 2        // < 150 m
    case _25meter = 3        // < 45 m
    case _10meter = 4        // < 25 m
    case _3meter = 5         // < 10 m
    case _1meter = 6         // < 3 m
}

/// Speed Accuracy
public enum SpeedAccuracy: Int {
    case unknown = 0
    case _10metersPerSecond = 1    // >= 10 m/s
    case _3metersPerSecond = 2     // < 10 m/s
    case _1metersPerSecond = 3     // < 3 m/s
    case _0_3metersPerSecond = 4   // < 1 m/s
}

/// Timestamp Accuracy
public enum TimestampAccuracy: Int {
    case unknown = 0
    case _0_1second = 1
    case _0_2second = 2
    case _0_3second = 3
    case _0_4second = 4
    case _0_5second = 5
    case _0_6second = 6
    case _0_7second = 7
    case _0_8second = 8
    case _0_9second = 9
    case _1_0second = 10
    case _1_1second = 11
    case _1_2second = 12
    case _1_3second = 13
    case _1_4second = 14
    case _1_5second = 15
}

/// Authentication Type
public enum AuthType: Int {
    case none = 0
    case uasIDSignature = 1
    case operatorIDSignature = 2
    case messageSetSignature = 3
    case networkRemoteID = 4
    case specificAuthentication = 5
}

/// Description Type
public enum DescType: Int {
    case text = 0
    case emergency = 1
    case extendedStatus = 2
}

/// Operator ID Type
public enum OperatorIDType: Int {
    case operatorID = 0
}

/// Operator Location Type
public enum OperatorLocationType: Int {
    case takeoff = 0
    case liveGNSS = 1
    case fixed = 2
}

/// Classification Type
public enum ClassificationType: Int {
    case undeclared = 0
    case eu = 1
}

/// EU Category
public enum CategoryEU: Int {
    case undeclared = 0
    case open = 1
    case specific = 2
    case certified = 3
}

/// EU Class
public enum ClassEU: Int {
    case undeclared = 0
    case class0 = 1
    case class1 = 2
    case class2 = 3
    case class3 = 4
    case class4 = 5
    case class5 = 6
    case class6 = 7
}

// MARK: - Data Structures

/// Basic ID Data
public struct BasicIDData {
    public var uaType: UAType
    public var idType: IDType
    public var uasID: String
    
    public init() {
        self.uaType = .none
        self.idType = .none
        self.uasID = ""
    }
}

/// Location Data
public struct LocationData {
    public var status: Status
    public var direction: Float           // Degrees (0-360)
    public var speedHorizontal: Float     // m/s
    public var speedVertical: Float       // m/s
    public var latitude: Double           // Degrees
    public var longitude: Double          // Degrees
    public var altitudeBaro: Float        // Meters
    public var altitudeGeo: Float         // Meters
    public var heightType: HeightReference
    public var height: Float              // Meters
    public var horizAccuracy: HorizontalAccuracy
    public var vertAccuracy: VerticalAccuracy
    public var baroAccuracy: VerticalAccuracy
    public var speedAccuracy: SpeedAccuracy
    public var tsAccuracy: TimestampAccuracy
    public var timeStamp: Float           // Seconds after full hour
    
    public init() {
        self.status = .undeclared
        self.direction = 0.0
        self.speedHorizontal = 0.0
        self.speedVertical = 0.0
        self.latitude = 0.0
        self.longitude = 0.0
        self.altitudeBaro = 0.0
        self.altitudeGeo = 0.0
        self.heightType = .takeoff
        self.height = 0.0
        self.horizAccuracy = .unknown
        self.vertAccuracy = .unknown
        self.baroAccuracy = .unknown
        self.speedAccuracy = .unknown
        self.tsAccuracy = .unknown
        self.timeStamp = 0.0
    }
}

/// Authentication Data
public struct AuthData {
    public var authType: AuthType
    public var dataPage: Int
    public var lastPageIndex: Int
    public var length: Int
    public var timestamp: UInt32
    public var authData: Data
    
    public init() {
        self.authType = .none
        self.dataPage = 0
        self.lastPageIndex = 0
        self.length = 0
        self.timestamp = 0
        self.authData = Data()
    }
}

/// Self ID Data
public struct SelfIDData {
    public var descType: DescType
    public var desc: String
    
    public init() {
        self.descType = .text
        self.desc = ""
    }
}

/// System Data
public struct SystemData {
    public var operatorLocationType: OperatorLocationType
    public var classificationType: ClassificationType
    public var operatorLatitude: Double
    public var operatorLongitude: Double
    public var areaCount: UInt16
    public var areaRadius: UInt16
    public var areaCeiling: Float
    public var areaFloor: Float
    public var categoryEU: CategoryEU
    public var classEU: ClassEU
    public var operatorAltitudeGeo: Float
    public var timestamp: UInt32
    
    public init() {
        self.operatorLocationType = .takeoff
        self.classificationType = .undeclared
        self.operatorLatitude = 0.0
        self.operatorLongitude = 0.0
        self.areaCount = 0
        self.areaRadius = 0
        self.areaCeiling = 0.0
        self.areaFloor = 0.0
        self.categoryEU = .undeclared
        self.classEU = .undeclared
        self.operatorAltitudeGeo = 0.0
        self.timestamp = 0
    }
}

/// Operator ID Data
public struct OperatorIDData {
    public var operatorIdType: OperatorIDType
    public var operatorId: String
    
    public init() {
        self.operatorIdType = .operatorID
        self.operatorId = ""
    }
}

// MARK: - Error Types

public enum OpenDroneIDError: Error {
    case encodingFailed(String)
    case decodingFailed(String)
    case invalidData(String)
    case invalidParameter(String)
}
