//
//  OpenDroneIDObjC.h
//  OpenDroneID Objective-C Bridge
//
//  This file provides an Objective-C wrapper around the C library
//

#import <Foundation/Foundation.h>

// Import the C library headers
#import "../../libopendroneid/opendroneid.h"
#import "../../libopendroneid/odid_wifi.h"

NS_ASSUME_NONNULL_BEGIN

// MARK: - Objective-C Wrapper Classes

/**
 * Objective-C wrapper for ODID_BasicID_data
 */
@interface ODIDBasicID : NSObject

@property (nonatomic) int uaType;
@property (nonatomic) int idType;
@property (nonatomic, strong) NSString *uasID;

- (instancetype)init;
- (void)copyToC:(ODID_BasicID_data *)cData;
- (void)copyFromC:(const ODID_BasicID_data *)cData;

@end

/**
 * Objective-C wrapper for ODID_Location_data
 */
@interface ODIDLocation : NSObject

@property (nonatomic) int status;
@property (nonatomic) float direction;
@property (nonatomic) float speedHorizontal;
@property (nonatomic) float speedVertical;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic) float altitudeBaro;
@property (nonatomic) float altitudeGeo;
@property (nonatomic) int heightType;
@property (nonatomic) float height;
@property (nonatomic) int horizAccuracy;
@property (nonatomic) int vertAccuracy;
@property (nonatomic) int baroAccuracy;
@property (nonatomic) int speedAccuracy;
@property (nonatomic) int tsAccuracy;
@property (nonatomic) float timeStamp;

- (instancetype)init;
- (void)copyToC:(ODID_Location_data *)cData;
- (void)copyFromC:(const ODID_Location_data *)cData;

@end

/**
 * Objective-C wrapper for ODID_Auth_data
 */
@interface ODIDAuth : NSObject

@property (nonatomic) int authType;
@property (nonatomic) int dataPage;
@property (nonatomic) int lastPageIndex;
@property (nonatomic) int length;
@property (nonatomic) uint32_t timestamp;
@property (nonatomic, strong) NSData *authData;

- (instancetype)init;
- (void)copyToC:(ODID_Auth_data *)cData;
- (void)copyFromC:(const ODID_Auth_data *)cData;

@end

/**
 * Objective-C wrapper for ODID_SelfID_data
 */
@interface ODIDSelfID : NSObject

@property (nonatomic) int descType;
@property (nonatomic, strong) NSString *desc;

- (instancetype)init;
- (void)copyToC:(ODID_SelfID_data *)cData;
- (void)copyFromC:(const ODID_SelfID_data *)cData;

@end

/**
 * Objective-C wrapper for ODID_System_data
 */
@interface ODIDSystem : NSObject

@property (nonatomic) int operatorLocationType;
@property (nonatomic) int classificationType;
@property (nonatomic) double operatorLatitude;
@property (nonatomic) double operatorLongitude;
@property (nonatomic) uint16_t areaCount;
@property (nonatomic) uint16_t areaRadius;
@property (nonatomic) float areaCeiling;
@property (nonatomic) float areaFloor;
@property (nonatomic) int categoryEU;
@property (nonatomic) int classEU;
@property (nonatomic) float operatorAltitudeGeo;
@property (nonatomic) uint32_t timestamp;

- (instancetype)init;
- (void)copyToC:(ODID_System_data *)cData;
- (void)copyFromC:(const ODID_System_data *)cData;

@end

/**
 * Objective-C wrapper for ODID_OperatorID_data
 */
@interface ODIDOperatorID : NSObject

@property (nonatomic) int operatorIdType;
@property (nonatomic, strong) NSString *operatorId;

- (instancetype)init;
- (void)copyToC:(ODID_OperatorID_data *)cData;
- (void)copyFromC:(const ODID_OperatorID_data *)cData;

@end

// MARK: - Encoder/Decoder

/**
 * Objective-C encoder for OpenDroneID messages
 */
@interface ODIDEncoder : NSObject

- (nullable NSData *)encodeBasicID:(ODIDBasicID *)basicID error:(NSError **)error;
- (nullable NSData *)encodeLocation:(ODIDLocation *)location error:(NSError **)error;
- (nullable NSData *)encodeAuth:(ODIDAuth *)auth error:(NSError **)error;
- (nullable NSData *)encodeSelfID:(ODIDSelfID *)selfID error:(NSError **)error;
- (nullable NSData *)encodeSystem:(ODIDSystem *)system error:(NSError **)error;
- (nullable NSData *)encodeOperatorID:(ODIDOperatorID *)operatorID error:(NSError **)error;

@end

/**
 * Objective-C decoder for OpenDroneID messages
 */
@interface ODIDDecoder : NSObject

- (nullable ODIDBasicID *)decodeBasicID:(NSData *)data error:(NSError **)error;
- (nullable ODIDLocation *)decodeLocation:(NSData *)data error:(NSError **)error;
- (nullable ODIDAuth *)decodeAuth:(NSData *)data error:(NSError **)error;
- (nullable ODIDSelfID *)decodeSelfID:(NSData *)data error:(NSError **)error;
- (nullable ODIDSystem *)decodeSystem:(NSData *)data error:(NSError **)error;
- (nullable ODIDOperatorID *)decodeOperatorID:(NSData *)data error:(NSError **)error;

@end

// MARK: - Utility Functions

/**
 * Objective-C utilities for OpenDroneID
 */
@interface ODIDUtilities : NSObject

+ (int)createHorizontalAccuracyEnum:(float)accuracy;
+ (int)createVerticalAccuracyEnum:(float)accuracy;
+ (int)createSpeedAccuracyEnum:(float)accuracy;
+ (int)createTimestampAccuracyEnum:(float)accuracy;

+ (float)decodeHorizontalAccuracy:(int)accuracy;
+ (float)decodeVerticalAccuracy:(int)accuracy;
+ (float)decodeSpeedAccuracy:(int)accuracy;
+ (float)decodeTimestampAccuracy:(int)accuracy;

@end

NS_ASSUME_NONNULL_END
