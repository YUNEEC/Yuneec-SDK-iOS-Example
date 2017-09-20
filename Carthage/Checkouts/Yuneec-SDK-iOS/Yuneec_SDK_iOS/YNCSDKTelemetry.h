/*
 * YNCSDKTelemetry.h
 * YUNEEC_SDK_IOS
 *
 * Copyright @ 2016 Yuneec.
 * All rights reserved.
 *
*/

#import <Foundation/Foundation.h>

/**
 This class manages the real-time status of the battery component.
 */
@interface YNCBattery : NSObject

    /**
     Battery voltage (in volts)
     */
    @property (nonatomic, assign) float voltageV;

    /**
     Battery remaining (as a percentage)
     */
    @property (nonatomic, assign) float remainingPercent;

@end

/**
 * This protocol provides delegate methods to subscribe to battery status updates.
 */
@protocol YNCSDKTelemetryBatteryDelegate <NSObject>

/**
 * Receives battery status updates.
 *
 * @param battery the battery object
 */
- (void)onBatteryUpdate:(YNCBattery *)battery;
@end

/**
 This class provides a method to subscribe to battery status updates.
 */
@interface YNCSDKTelemetryBattery : NSObject

 /**
 * Subscribes to battery status updates.
 *
 * @param delegate The Battery delegate object
 */
- (void)subscribe:(id<YNCSDKTelemetryBatteryDelegate>) delegate;
@end

/**
 This class contains fields associated with the drone's position.
 */
@interface YNCPosition : NSObject

    /**
     Latitude (in Degrees)
     */
    @property (nonatomic, assign) double latitudeDeg;

    /**
     Longitude (in Degrees)
     */
    @property (nonatomic, assign) double longitudeDeg;

    /**
     Absolute altitude (in Meters)
     */
    @property (nonatomic, assign) float absoluteAltitudeM;

    /**
     Relative altitude (in Meters)
     */
    @property (nonatomic, assign) float relativeAltitudeM;

@end

/**
 This delegate provides position updates of the drone.
 */
@protocol YNCSDKTelemetryPositionDelegate <NSObject>

/**
 Receives position updates.
 
 @param position The position object with current position
 */
- (void)onPositionUpdate:(YNCPosition *)position;
@end

 /**
 This class provides a method to subscribe to position updates.
 */
@interface YNCSDKTelemetryPosition : NSObject
 /**
 * Subscribes to position updates
 *
 * @param delegate The Position delegate object
 */  
- (void)subscribe:(id<YNCSDKTelemetryPositionDelegate>) delegate;
@end

/**
 This delegate provides home position updates of the drone.
 */
@protocol YNCSDKTelemetryHomePositionDelegate <NSObject>
/**
 Receives home position updates.
 
 @param homePosition the position object with home position
 */
- (void)onHomePositionUpdate:(YNCPosition *)homePosition;
@end

/**
 This class provides a method to subscribe to home position updates.
 */
@interface YNCSDKTelemetryHomePosition : NSObject
/**
 * Subscribes to home position updates.
 *
 * @param delegate The Home Position delegate object
 */ 
- (void)subscribe:(id<YNCSDKTelemetryHomePositionDelegate>) delegate;
@end

/**
 This class contains the drone's speed in ground coordinates, which is the horizontal speed in the NED (North, East, Down) directions relative to the ground.
 */
@interface YNCGroundSpeedNED : NSObject

    /**
     North speed (in m/s)
     */
    @property (nonatomic, assign) float velocityNorthMS;

    /**
     East speed (in m/s)
     */
    @property (nonatomic, assign) float velocityEastMS;

    /**
     Down speed (in m/s)
     */
    @property (nonatomic, assign) float velocityDownMS;

@end

/**
 This delegate provides ground speed updates of the drone.
 */
@protocol YNCSDKTelemetryGroundSpeedNEDDelegate <NSObject>

/**
 Receives ground speed updates.
 
 @param groundSpeedNED The NED ground speed object
 */
- (void)onGroundSpeedNEDUpdate:(YNCGroundSpeedNED *)groundSpeedNED;
@end

/**
 This class provides a method to subscribe to ground speed updates.
 */
@interface YNCSDKTelemetryGroundSpeedNED : NSObject

/**
 * Subscribes to ground speed updates.
 *
 * @param delegate The NED GroundSpeed delegate object
 */ 
- (void)subscribe:(id<YNCSDKTelemetryGroundSpeedNEDDelegate>) delegate;
@end

/**
 This class manages the drone's GPS infomation.
 */
@interface YNCGPSInfo : NSObject

    /**
     Number of connected satellites
     */
    @property (nonatomic, assign) int numSatellites;

    /**
     GPS fix type: 1 - No GPS Fix, 2 - 2D Fix, 3 - 3D Fix.
     */
    @property (nonatomic, assign) int fixType;

@end

/**
 This delegate provides GPS info updates of the drone.
 */
@protocol YNCSDKTelemetryGPSInfoDelegate <NSObject>
/**
 Receives GPS info updates.
 
 @param gpsInfo the GPS info object
 */
- (void)onGPSInfoUpdate:(YNCGPSInfo *)gpsInfo;
@end

/**
 This class provides a method to subscribe to GPS info updates.
 */
@interface YNCSDKTelemetryGPSInfo : NSObject
/**
 * Subscribes to GPS info updates.
 *
 * @param delegate the GPS Information delegate object
 */
- (void)subscribe:(id<YNCSDKTelemetryGPSInfoDelegate>) delegate;
@end

/**
 This class tracks the drone attitude in euler angles.
 */
@interface YNCAttitudeEulerAngle : NSObject

    /**
     Roll value (in Degrees)
     */
    @property (nonatomic, assign) float rollDeg;

    /**
     Pitch value (in Degrees)
     */
    @property (nonatomic, assign) float pitchDeg;

    /**
     Yaw value (in Degrees)
     */
    @property (nonatomic, assign) float yawDeg;

@end

/**
 This delegate provides attitude updates (in euler angles) of the drone.
 */
@protocol YNCSDKTelemetryAttitudeEulerAngleDelegate <NSObject>
/**
 Receives euler angle updates for the drone's attitude.
 
 @param attitudeEulerAngle the euler angles for attitude
 */
- (void)onAttitudeEulerAngleUpdate:(YNCAttitudeEulerAngle*)attitudeEulerAngle;
@end

/**
 This class provides a method to subscribe to attitude updates in euler angles.
 */
@interface YNCSDKTelemetryAttitudeEulerAngle : NSObject
/**
 * Subscribes to attitude updates of the drone.
 *
 * @param delegate The Euler Angle Attitude delegate object
 */ 
- (void)subscribe:(id<YNCSDKTelemetryAttitudeEulerAngleDelegate>) delegate;
@end

    /**
     This class tracks the drone attitude in quaternion.
     */
    @interface YNCAttitudeQuaternion : NSObject

    /**
     w component of quaternion
     */
    @property (nonatomic, assign) float w;

    /**
     x component of quaternion
     */
    @property (nonatomic, assign) float x;

    /**
     y component of quaternion
     */
    @property (nonatomic, assign) float y;

    /**
     z component of quaternion
     */
    @property (nonatomic, assign) float z;

@end

/**
 This delegate provides attitude updates (in quaternion) of the drone.
 */
@protocol YNCSDKTelemetryAttitudeQuaternionDelegate <NSObject>
 /**
  Receives quaternion updates for the drone's attitude.
 
  @param attitudeQuaternion the quaternion for attitude
 */
- (void)onAttitudeQuaternionUpdate:(YNCAttitudeQuaternion*)attitudeQuaternion;
@end

/**
 This class provides a method to subscribe to attitude updates in quaternion.
 */
@interface YNCSDKTelemetryAttitudeQuaternion : NSObject
/**
 * Subscribes to attitude updates in quaternion.
 *
 * @param delegate The Quaternion Attitude delegate object
 */ 
- (void)subscribe:(id<YNCSDKTelemetryAttitudeQuaternionDelegate>) delegate;
@end

/**
 This delegate provides the in-air status updates of the drone.
 */
@protocol YNCSDKTelemetryInAirDelegate <NSObject>

/**
 Receives in-air status updates.
 
 @param inAir true if drone is in flight, false if drone is on the ground (landed).
 */
- (void)onInAirUpdate:(BOOL)inAir;
@end

/**
 This class provides a method to subscribe to in-air status updates.
 */
@interface YNCSDKTelemetryInAir : NSObject
/**
 * Subscribes to in-air status updates.
 *
 * @param delegate the In Air Status delegate object
 */  
- (void)subscribe:(id<YNCSDKTelemetryInAirDelegate>) delegate;
@end

/**
 This delegate provides attitude updates (in euler angles) of the camera.
 */
@protocol YNCSDKTelemetryCameraAttitudeEulerAngleDelegate <NSObject>
 /**
  Receives euler angle updates for the camera's attitude.
 
  @param cameraAttitudeEulerAngle the euler angles for camera attitude
 */
- (void)onCameraAttitudeEulerAngleUpdate:(YNCAttitudeEulerAngle *)cameraAttitudeEulerAngle;
@end

/**
 This class provides a method to subscribe to camera attitude updates (in euler angles).
 */
@interface YNCSDKTelemetryCameraAttitudeEulerAngle : NSObject
/**
 * Subscribes to camera attitude updates.
 *
 * @param delegate The Camera Euler Angle delegate object
 */  
- (void)subscribe:(id<YNCSDKTelemetryCameraAttitudeEulerAngleDelegate>) delegate;
@end

/**
 This delegate provides attitude updates (in quarternion) of the camera.
 */
@protocol YNCSDKTelemetryCameraAttitudeQuaternionDelegate <NSObject>
 /**
  Receives quaternion updates for the camera's attitude.
 
  @param cameraAttitudeQuaternion the quaternion for camera attitude
 */
- (void)onCameraAttitudeQuaternionUpdate:(YNCAttitudeQuaternion *)cameraAttitudeQuaternion;
@end

/**
 This class provides a method to subscribe to camera attitude updates (in quarternion).
 */
@interface YNCSDKTelemetryCameraAttitudeQuaternion: NSObject
 /**
 * Subscribes to camera attitude updates (in quarternion).
 *
 * @param delegate The Camera Quarternion Attitude delegate object
 */  
- (void)subscribe:(id<YNCSDKTelemetryCameraAttitudeQuaternionDelegate>) delegate;
@end

/**
 This class contains the drone's remote control (RC) link status.
 */
@interface YNCRCStatus : NSObject

    /**
     Whether the RC signal is available.
     */
    @property (nonatomic, assign) BOOL availableOnce;

    /**
     Whether the RC signal is lost.
     */
    @property (nonatomic, assign) BOOL lost;

    /**
     Signal strength of remote control to UAV (in %).
     */
    @property (nonatomic, assign) float signalStrengthPercent;

@end

/**
 This delegate provides remote control status updates.
 */
@protocol YNCSDKTelemetryRCStatusDelegate <NSObject>
 /**
  Receives updates for remote control status.
 
  @param rcStatus The remote control status
 */
- (void)onRCStatusUpdate:(YNCRCStatus *)rcStatus;
@end

/**
 This class provides a method to subscribe to RC status updates.
 */
@interface YNCSDKTelemetryRCStatus: NSObject
 /**
 * Subscribes to RC link status updates.
 *
 * @param delegate The RC Status delegate object
 */  
- (void)subscribe:(id<YNCSDKTelemetryRCStatusDelegate>) delegate;
@end

/**
 Data type for the different flight modes.
 */
typedef NS_ENUM (NSInteger, YNCTelemetryFlightMode) {
    
    /**
     Ready mode
     */
    YNCREADY = 0,
    /**
     Takeoff mode
     */
    YNCTAKEOFF,
    /**
     Hold mode
     */
    YNCHOLD,
    /**
     Mission mode
     */
    YNCMISSION,
    /**
     Return-to-home mode
     */
    YNCRETURN_TO_LAUNCH,
    /**
     Return-to-land mode
     */
    YNCLAND,
    /**
     Offboard mode
     */       
    YNCOFFBOARD,
    /**
     Unknown flight mode
     */       
    YNCUNKNOWN
};

/**
 This delegate provides flight mode updates.
 */
@protocol YNCSDKTelemetryFlightModeDelegate <NSObject>
/**
 Receives flight mode updates.
 
 @param flightMode the current flight mode
 */
- (void)onFlightModeUpdate:(YNCTelemetryFlightMode)flightMode;
@end

/**
 This class provides a method to subscribe to flight mode updates.
 */
@interface YNCSDKTelemetryFlightMode: NSObject
 /**
 * Subscribes to flight mode updates.
 *
 * @param delegate The flight mode delegate object
 */ 
- (void)subscribe:(id<YNCSDKTelemetryFlightModeDelegate>) delegate;
@end

/**
 This class contains the drone's component health and status.
 */
@interface YNCHealth : NSObject

    /**
     State of the gyroscope calibration
     */
    @property (nonatomic, assign) BOOL gyrometerCalibrationOk;

    /**
     State of the accelerometer calibration
     */
    @property (nonatomic, assign) BOOL accelerometerCalibrationOk;

    /**
     State of the magnetometer calibration
     */
    @property (nonatomic, assign) BOOL magnetometerCalibrationOk;

    /**
     State of the level calibration
     */
    @property (nonatomic, assign) BOOL levelCalibrationOk;

    /**
     Status of the local position
     */
    @property (nonatomic, assign) BOOL localPositionOk;

    /**
     Status of the global position
     */
    @property (nonatomic, assign) BOOL globalPositionOk;

    /**
     Status of the home position
     */
    @property (nonatomic, assign) BOOL homePositionOk;

@end

/**
 This delegate provides health status updates of the drone.
 */
@protocol YNCSDKTelemetryHealthDelegate <NSObject>
/**
 Receives health status updates.
 
 @param health The health status
 */
- (void)onHealthUpdate:(YNCHealth *)health;
@end

/**
 This class provides a method to subscribe to drone health updates.
 */
@interface YNCSDKTelemetryHealth: NSObject
 /**
 * Subscribes to drone health updates.
 *
 * @param delegate The Drone Health delegate object
 */  
- (void)subscribe:(id<YNCSDKTelemetryHealthDelegate>) delegate;
@end

/**
 This delegate provides armed status updates.
 */
@protocol YNCSDKTelemetryArmedDelegate <NSObject>
/**
 Receives armed status updates. Indicates whether the props are spinning (armed) or not (disarmed).
 
 @param armed The armed status
 */
- (void)onArmedUpdate:(BOOL)armed;
@end

/**
 This class provides a method to subscribe to armed status updates.
 */
@interface YNCSDKTelemetryArmed: NSObject
 /**
 * Subscribes to armed status updates.
 *
 * @param delegate The Arm Status delegate object
 */  
- (void)subscribe:(id<YNCSDKTelemetryArmedDelegate>) delegate;
@end

/**
 This delegate provides the overall health status.
 */
@protocol YNCSDKTelemetryHealthAllOkDelegate <NSObject>
/**
 Receives overall health status updates.
 
 @param healthAllOk true if all health flags are ok
 */
- (void)onHealthAllOkUpdate:(BOOL)healthAllOk;
@end

/**
 This class provides a method to subscribe to overall health status updates.
 */
@interface YNCSDKTelemetryHealthAllOk: NSObject
/**
 * Subscribes to overall health status updates.
 *
 * @param delegate The Overall Health delegate object
 */
- (void)subscribe:(id<YNCSDKTelemetryHealthAllOkDelegate>) delegate;
@end
