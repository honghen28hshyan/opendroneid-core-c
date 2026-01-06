//
//  OpenDroneIDObjC.m
//  OpenDroneID Objective-C Bridge Implementation
//

#import "OpenDroneIDObjC.h"

// Error domain
NSString * const ODIDErrorDomain = @"org.opendroneid.error";

// MARK: - ODIDBasicID Implementation

@implementation ODIDBasicID

- (instancetype)init {
    self = [super init];
    if (self) {
        _uaType = 0;
        _idType = 0;
        _uasID = @"";
    }
    return self;
}

- (void)copyToC:(ODID_BasicID_data *)cData {
    if (!cData) return;
    
    odid_initBasicIDData(cData);
    cData->UAType = (ODID_uatype_t)_uaType;
    cData->IDType = (ODID_idtype_t)_idType;
    
    const char *idCString = [_uasID UTF8String];
    if (idCString) {
        strncpy(cData->UASID, idCString, ODID_ID_SIZE);
        cData->UASID[ODID_ID_SIZE] = '\0';
    }
}

- (void)copyFromC:(const ODID_BasicID_data *)cData {
    if (!cData) return;
    
    _uaType = cData->UAType;
    _idType = cData->IDType;
    _uasID = [NSString stringWithUTF8String:cData->UASID];
}

@end

// MARK: - ODIDLocation Implementation

@implementation ODIDLocation

- (instancetype)init {
    self = [super init];
    if (self) {
        _status = 0;
        _direction = 0.0f;
        _speedHorizontal = 0.0f;
        _speedVertical = 0.0f;
        _latitude = 0.0;
        _longitude = 0.0;
        _altitudeBaro = 0.0f;
        _altitudeGeo = 0.0f;
        _heightType = 0;
        _height = 0.0f;
        _horizAccuracy = 0;
        _vertAccuracy = 0;
        _baroAccuracy = 0;
        _speedAccuracy = 0;
        _tsAccuracy = 0;
        _timeStamp = 0.0f;
    }
    return self;
}

- (void)copyToC:(ODID_Location_data *)cData {
    if (!cData) return;
    
    odid_initLocationData(cData);
    cData->Status = (ODID_status_t)_status;
    cData->Direction = _direction;
    cData->SpeedHorizontal = _speedHorizontal;
    cData->SpeedVertical = _speedVertical;
    cData->Latitude = _latitude;
    cData->Longitude = _longitude;
    cData->AltitudeBaro = _altitudeBaro;
    cData->AltitudeGeo = _altitudeGeo;
    cData->HeightType = (ODID_Height_reference_t)_heightType;
    cData->Height = _height;
    cData->HorizAccuracy = (ODID_Horizontal_accuracy_t)_horizAccuracy;
    cData->VertAccuracy = (ODID_Vertical_accuracy_t)_vertAccuracy;
    cData->BaroAccuracy = (ODID_Vertical_accuracy_t)_baroAccuracy;
    cData->SpeedAccuracy = (ODID_Speed_accuracy_t)_speedAccuracy;
    cData->TSAccuracy = (ODID_Timestamp_accuracy_t)_tsAccuracy;
    cData->TimeStamp = _timeStamp;
}

- (void)copyFromC:(const ODID_Location_data *)cData {
    if (!cData) return;
    
    _status = cData->Status;
    _direction = cData->Direction;
    _speedHorizontal = cData->SpeedHorizontal;
    _speedVertical = cData->SpeedVertical;
    _latitude = cData->Latitude;
    _longitude = cData->Longitude;
    _altitudeBaro = cData->AltitudeBaro;
    _altitudeGeo = cData->AltitudeGeo;
    _heightType = cData->HeightType;
    _height = cData->Height;
    _horizAccuracy = cData->HorizAccuracy;
    _vertAccuracy = cData->VertAccuracy;
    _baroAccuracy = cData->BaroAccuracy;
    _speedAccuracy = cData->SpeedAccuracy;
    _tsAccuracy = cData->TSAccuracy;
    _timeStamp = cData->TimeStamp;
}

@end

// MARK: - ODIDAuth Implementation

@implementation ODIDAuth

- (instancetype)init {
    self = [super init];
    if (self) {
        _authType = 0;
        _dataPage = 0;
        _lastPageIndex = 0;
        _length = 0;
        _timestamp = 0;
        _authData = [NSData data];
    }
    return self;
}

- (void)copyToC:(ODID_Auth_data *)cData {
    if (!cData) return;
    
    odid_initAuthData(cData);
    cData->AuthType = (ODID_authtype_t)_authType;
    cData->DataPage = _dataPage;
    cData->LastPageIndex = _lastPageIndex;
    cData->Length = _length;
    cData->Timestamp = _timestamp;
    
    NSUInteger length = MIN(_authData.length, MAX_AUTH_LENGTH);
    [_authData getBytes:cData->AuthData length:length];
}

- (void)copyFromC:(const ODID_Auth_data *)cData {
    if (!cData) return;
    
    _authType = cData->AuthType;
    _dataPage = cData->DataPage;
    _lastPageIndex = cData->LastPageIndex;
    _length = cData->Length;
    _timestamp = cData->Timestamp;
    _authData = [NSData dataWithBytes:cData->AuthData length:cData->Length];
}

@end

// MARK: - ODIDSelfID Implementation

@implementation ODIDSelfID

- (instancetype)init {
    self = [super init];
    if (self) {
        _descType = 0;
        _desc = @"";
    }
    return self;
}

- (void)copyToC:(ODID_SelfID_data *)cData {
    if (!cData) return;
    
    odid_initSelfIDData(cData);
    cData->DescType = (ODID_desctype_t)_descType;
    
    const char *descCString = [_desc UTF8String];
    if (descCString) {
        strncpy(cData->Desc, descCString, ODID_STR_SIZE);
        cData->Desc[ODID_STR_SIZE] = '\0';
    }
}

- (void)copyFromC:(const ODID_SelfID_data *)cData {
    if (!cData) return;
    
    _descType = cData->DescType;
    _desc = [NSString stringWithUTF8String:cData->Desc];
}

@end

// MARK: - ODIDSystem Implementation

@implementation ODIDSystem

- (instancetype)init {
    self = [super init];
    if (self) {
        _operatorLocationType = 0;
        _classificationType = 0;
        _operatorLatitude = 0.0;
        _operatorLongitude = 0.0;
        _areaCount = 0;
        _areaRadius = 0;
        _areaCeiling = 0.0f;
        _areaFloor = 0.0f;
        _categoryEU = 0;
        _classEU = 0;
        _operatorAltitudeGeo = 0.0f;
        _timestamp = 0;
    }
    return self;
}

- (void)copyToC:(ODID_System_data *)cData {
    if (!cData) return;
    
    odid_initSystemData(cData);
    cData->OperatorLocationType = (ODID_operator_location_type_t)_operatorLocationType;
    cData->ClassificationType = (ODID_classification_type_t)_classificationType;
    cData->OperatorLatitude = _operatorLatitude;
    cData->OperatorLongitude = _operatorLongitude;
    cData->AreaCount = _areaCount;
    cData->AreaRadius = _areaRadius;
    cData->AreaCeiling = _areaCeiling;
    cData->AreaFloor = _areaFloor;
    cData->CategoryEU = (ODID_category_EU_t)_categoryEU;
    cData->ClassEU = (ODID_class_EU_t)_classEU;
    cData->OperatorAltitudeGeo = _operatorAltitudeGeo;
    cData->Timestamp = _timestamp;
}

- (void)copyFromC:(const ODID_System_data *)cData {
    if (!cData) return;
    
    _operatorLocationType = cData->OperatorLocationType;
    _classificationType = cData->ClassificationType;
    _operatorLatitude = cData->OperatorLatitude;
    _operatorLongitude = cData->OperatorLongitude;
    _areaCount = cData->AreaCount;
    _areaRadius = cData->AreaRadius;
    _areaCeiling = cData->AreaCeiling;
    _areaFloor = cData->AreaFloor;
    _categoryEU = cData->CategoryEU;
    _classEU = cData->ClassEU;
    _operatorAltitudeGeo = cData->OperatorAltitudeGeo;
    _timestamp = cData->Timestamp;
}

@end

// MARK: - ODIDOperatorID Implementation

@implementation ODIDOperatorID

- (instancetype)init {
    self = [super init];
    if (self) {
        _operatorIdType = 0;
        _operatorId = @"";
    }
    return self;
}

- (void)copyToC:(ODID_OperatorID_data *)cData {
    if (!cData) return;
    
    odid_initOperatorIDData(cData);
    cData->OperatorIdType = (ODID_operatorIdType_t)_operatorIdType;
    
    const char *idCString = [_operatorId UTF8String];
    if (idCString) {
        strncpy(cData->OperatorId, idCString, ODID_ID_SIZE);
        cData->OperatorId[ODID_ID_SIZE] = '\0';
    }
}

- (void)copyFromC:(const ODID_OperatorID_data *)cData {
    if (!cData) return;
    
    _operatorIdType = cData->OperatorIdType;
    _operatorId = [NSString stringWithUTF8String:cData->OperatorId];
}

@end

// MARK: - ODIDEncoder Implementation

@implementation ODIDEncoder

- (nullable NSData *)encodeBasicID:(ODIDBasicID *)basicID error:(NSError **)error {
    ODID_BasicID_data cData;
    [basicID copyToC:&cData];
    
    ODID_BasicID_encoded encoded;
    int result = encodeBasicIDMessage(&encoded, &cData);
    
    if (result != ODID_SUCCESS) {
        if (error) {
            *error = [NSError errorWithDomain:ODIDErrorDomain
                                         code:result
                                     userInfo:@{NSLocalizedDescriptionKey: @"Failed to encode Basic ID message"}];
        }
        return nil;
    }
    
    return [NSData dataWithBytes:&encoded length:sizeof(encoded)];
}

- (nullable NSData *)encodeLocation:(ODIDLocation *)location error:(NSError **)error {
    ODID_Location_data cData;
    [location copyToC:&cData];
    
    ODID_Location_encoded encoded;
    int result = encodeLocationMessage(&encoded, &cData);
    
    if (result != ODID_SUCCESS) {
        if (error) {
            *error = [NSError errorWithDomain:ODIDErrorDomain
                                         code:result
                                     userInfo:@{NSLocalizedDescriptionKey: @"Failed to encode Location message"}];
        }
        return nil;
    }
    
    return [NSData dataWithBytes:&encoded length:sizeof(encoded)];
}

- (nullable NSData *)encodeAuth:(ODIDAuth *)auth error:(NSError **)error {
    ODID_Auth_data cData;
    [auth copyToC:&cData];
    
    ODID_Auth_encoded encoded;
    int result = encodeAuthMessage(&encoded, &cData);
    
    if (result != ODID_SUCCESS) {
        if (error) {
            *error = [NSError errorWithDomain:ODIDErrorDomain
                                         code:result
                                     userInfo:@{NSLocalizedDescriptionKey: @"Failed to encode Auth message"}];
        }
        return nil;
    }
    
    return [NSData dataWithBytes:&encoded length:sizeof(encoded)];
}

- (nullable NSData *)encodeSelfID:(ODIDSelfID *)selfID error:(NSError **)error {
    ODID_SelfID_data cData;
    [selfID copyToC:&cData];
    
    ODID_SelfID_encoded encoded;
    int result = encodeSelfIDMessage(&encoded, &cData);
    
    if (result != ODID_SUCCESS) {
        if (error) {
            *error = [NSError errorWithDomain:ODIDErrorDomain
                                         code:result
                                     userInfo:@{NSLocalizedDescriptionKey: @"Failed to encode SelfID message"}];
        }
        return nil;
    }
    
    return [NSData dataWithBytes:&encoded length:sizeof(encoded)];
}

- (nullable NSData *)encodeSystem:(ODIDSystem *)system error:(NSError **)error {
    ODID_System_data cData;
    [system copyToC:&cData];
    
    ODID_System_encoded encoded;
    int result = encodeSystemMessage(&encoded, &cData);
    
    if (result != ODID_SUCCESS) {
        if (error) {
            *error = [NSError errorWithDomain:ODIDErrorDomain
                                         code:result
                                     userInfo:@{NSLocalizedDescriptionKey: @"Failed to encode System message"}];
        }
        return nil;
    }
    
    return [NSData dataWithBytes:&encoded length:sizeof(encoded)];
}

- (nullable NSData *)encodeOperatorID:(ODIDOperatorID *)operatorID error:(NSError **)error {
    ODID_OperatorID_data cData;
    [operatorID copyToC:&cData];
    
    ODID_OperatorID_encoded encoded;
    int result = encodeOperatorIDMessage(&encoded, &cData);
    
    if (result != ODID_SUCCESS) {
        if (error) {
            *error = [NSError errorWithDomain:ODIDErrorDomain
                                         code:result
                                     userInfo:@{NSLocalizedDescriptionKey: @"Failed to encode OperatorID message"}];
        }
        return nil;
    }
    
    return [NSData dataWithBytes:&encoded length:sizeof(encoded)];
}

@end

// MARK: - ODIDDecoder Implementation

@implementation ODIDDecoder

- (nullable ODIDBasicID *)decodeBasicID:(NSData *)data error:(NSError **)error {
    if (data.length < sizeof(ODID_BasicID_encoded)) {
        if (error) {
            *error = [NSError errorWithDomain:ODIDErrorDomain
                                         code:-1
                                     userInfo:@{NSLocalizedDescriptionKey: @"Invalid data size"}];
        }
        return nil;
    }
    
    ODID_BasicID_encoded encoded;
    [data getBytes:&encoded length:sizeof(encoded)];
    
    ODID_BasicID_data cData;
    int result = decodeBasicIDMessage(&cData, &encoded);
    
    if (result != ODID_SUCCESS) {
        if (error) {
            *error = [NSError errorWithDomain:ODIDErrorDomain
                                         code:result
                                     userInfo:@{NSLocalizedDescriptionKey: @"Failed to decode Basic ID message"}];
        }
        return nil;
    }
    
    ODIDBasicID *basicID = [[ODIDBasicID alloc] init];
    [basicID copyFromC:&cData];
    return basicID;
}

- (nullable ODIDLocation *)decodeLocation:(NSData *)data error:(NSError **)error {
    if (data.length < sizeof(ODID_Location_encoded)) {
        if (error) {
            *error = [NSError errorWithDomain:ODIDErrorDomain
                                         code:-1
                                     userInfo:@{NSLocalizedDescriptionKey: @"Invalid data size"}];
        }
        return nil;
    }
    
    ODID_Location_encoded encoded;
    [data getBytes:&encoded length:sizeof(encoded)];
    
    ODID_Location_data cData;
    int result = decodeLocationMessage(&cData, &encoded);
    
    if (result != ODID_SUCCESS) {
        if (error) {
            *error = [NSError errorWithDomain:ODIDErrorDomain
                                         code:result
                                     userInfo:@{NSLocalizedDescriptionKey: @"Failed to decode Location message"}];
        }
        return nil;
    }
    
    ODIDLocation *location = [[ODIDLocation alloc] init];
    [location copyFromC:&cData];
    return location;
}

- (nullable ODIDAuth *)decodeAuth:(NSData *)data error:(NSError **)error {
    if (data.length < sizeof(ODID_Auth_encoded)) {
        if (error) {
            *error = [NSError errorWithDomain:ODIDErrorDomain
                                         code:-1
                                     userInfo:@{NSLocalizedDescriptionKey: @"Invalid data size"}];
        }
        return nil;
    }
    
    ODID_Auth_encoded encoded;
    [data getBytes:&encoded length:sizeof(encoded)];
    
    ODID_Auth_data cData;
    int result = decodeAuthMessage(&cData, &encoded);
    
    if (result != ODID_SUCCESS) {
        if (error) {
            *error = [NSError errorWithDomain:ODIDErrorDomain
                                         code:result
                                     userInfo:@{NSLocalizedDescriptionKey: @"Failed to decode Auth message"}];
        }
        return nil;
    }
    
    ODIDAuth *auth = [[ODIDAuth alloc] init];
    [auth copyFromC:&cData];
    return auth;
}

- (nullable ODIDSelfID *)decodeSelfID:(NSData *)data error:(NSError **)error {
    if (data.length < sizeof(ODID_SelfID_encoded)) {
        if (error) {
            *error = [NSError errorWithDomain:ODIDErrorDomain
                                         code:-1
                                     userInfo:@{NSLocalizedDescriptionKey: @"Invalid data size"}];
        }
        return nil;
    }
    
    ODID_SelfID_encoded encoded;
    [data getBytes:&encoded length:sizeof(encoded)];
    
    ODID_SelfID_data cData;
    int result = decodeSelfIDMessage(&cData, &encoded);
    
    if (result != ODID_SUCCESS) {
        if (error) {
            *error = [NSError errorWithDomain:ODIDErrorDomain
                                         code:result
                                     userInfo:@{NSLocalizedDescriptionKey: @"Failed to decode SelfID message"}];
        }
        return nil;
    }
    
    ODIDSelfID *selfID = [[ODIDSelfID alloc] init];
    [selfID copyFromC:&cData];
    return selfID;
}

- (nullable ODIDSystem *)decodeSystem:(NSData *)data error:(NSError **)error {
    if (data.length < sizeof(ODID_System_encoded)) {
        if (error) {
            *error = [NSError errorWithDomain:ODIDErrorDomain
                                         code:-1
                                     userInfo:@{NSLocalizedDescriptionKey: @"Invalid data size"}];
        }
        return nil;
    }
    
    ODID_System_encoded encoded;
    [data getBytes:&encoded length:sizeof(encoded)];
    
    ODID_System_data cData;
    int result = decodeSystemMessage(&cData, &encoded);
    
    if (result != ODID_SUCCESS) {
        if (error) {
            *error = [NSError errorWithDomain:ODIDErrorDomain
                                         code:result
                                     userInfo:@{NSLocalizedDescriptionKey: @"Failed to decode System message"}];
        }
        return nil;
    }
    
    ODIDSystem *system = [[ODIDSystem alloc] init];
    [system copyFromC:&cData];
    return system;
}

- (nullable ODIDOperatorID *)decodeOperatorID:(NSData *)data error:(NSError **)error {
    if (data.length < sizeof(ODID_OperatorID_encoded)) {
        if (error) {
            *error = [NSError errorWithDomain:ODIDErrorDomain
                                         code:-1
                                     userInfo:@{NSLocalizedDescriptionKey: @"Invalid data size"}];
        }
        return nil;
    }
    
    ODID_OperatorID_encoded encoded;
    [data getBytes:&encoded length:sizeof(encoded)];
    
    ODID_OperatorID_data cData;
    int result = decodeOperatorIDMessage(&cData, &encoded);
    
    if (result != ODID_SUCCESS) {
        if (error) {
            *error = [NSError errorWithDomain:ODIDErrorDomain
                                         code:result
                                     userInfo:@{NSLocalizedDescriptionKey: @"Failed to decode OperatorID message"}];
        }
        return nil;
    }
    
    ODIDOperatorID *operatorID = [[ODIDOperatorID alloc] init];
    [operatorID copyFromC:&cData];
    return operatorID;
}

@end

// MARK: - ODIDUtilities Implementation

@implementation ODIDUtilities

+ (int)createHorizontalAccuracyEnum:(float)accuracy {
    return createEnumHorizontalAccuracy(accuracy);
}

+ (int)createVerticalAccuracyEnum:(float)accuracy {
    return createEnumVerticalAccuracy(accuracy);
}

+ (int)createSpeedAccuracyEnum:(float)accuracy {
    return createEnumSpeedAccuracy(accuracy);
}

+ (int)createTimestampAccuracyEnum:(float)accuracy {
    return createEnumTimestampAccuracy(accuracy);
}

+ (float)decodeHorizontalAccuracy:(int)accuracy {
    return decodeHorizontalAccuracy((ODID_Horizontal_accuracy_t)accuracy);
}

+ (float)decodeVerticalAccuracy:(int)accuracy {
    return decodeVerticalAccuracy((ODID_Vertical_accuracy_t)accuracy);
}

+ (float)decodeSpeedAccuracy:(int)accuracy {
    return decodeSpeedAccuracy((ODID_Speed_accuracy_t)accuracy);
}

+ (float)decodeTimestampAccuracy:(int)accuracy {
    return decodeTimestampAccuracy((ODID_Timestamp_accuracy_t)accuracy);
}

@end
