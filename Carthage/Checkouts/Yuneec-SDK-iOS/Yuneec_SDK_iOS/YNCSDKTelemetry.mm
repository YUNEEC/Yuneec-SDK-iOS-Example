/** @brief YNCSDKTelemetry  implementation file, Subscribe Drone Telemetry status*/

#import "YNCSDKTelemetry.h"
#import "YNCSDKInternal.h"


#include <dronelink/dronelink.h>

using namespace dronelink;
using namespace std::placeholders;

static id <YNCSDKTelemetryBatteryDelegate> _batteryDelegate;
static id <YNCSDKTelemetryPositionDelegate> _positionDelegate;
static id <YNCSDKTelemetryGroundSpeedNEDDelegate> _groundSpeedNEDDelegate;
static id <YNCSDKTelemetryGPSInfoDelegate> _gpsInfoDelegate;
static id <YNCSDKTelemetryAttitudeEulerAngleDelegate> _attitudeEulerAngleDelegate;
static id <YNCSDKTelemetryAttitudeQuaternionDelegate> _attitudeQuaternionDelegate;
static id <YNCSDKTelemetryHomePositionDelegate> _homePositionDelegate;
static id <YNCSDKTelemetryInAirDelegate> _inAirDelegate;
static id <YNCSDKTelemetryCameraAttitudeEulerAngleDelegate> _cameraAttitudeEulerAngleDelegate;
static id <YNCSDKTelemetryCameraAttitudeQuaternionDelegate> _cameraAttitudeQuaternionDelegate;
static id <YNCSDKTelemetryRCStatusDelegate> _rcStatusDelegate;
static id <YNCSDKTelemetryFlightModeDelegate> _flightModeDelegate;
static id <YNCSDKTelemetryHealthDelegate> _healthDelegate;
static id <YNCSDKTelemetryArmedDelegate> _armedDelegate;
static id <YNCSDKTelemetryHealthAllOkDelegate> _healthAllOkDelegate;


#pragma mark Receive battery data
void receive_battery(Telemetry::Battery battery) {
    YNCBattery *tmpBattery = [YNCBattery new];
    tmpBattery.voltageV = battery.voltage_v;
    tmpBattery.remainingPercent = battery.remaining_percent;
    
    if (_batteryDelegate && [_batteryDelegate respondsToSelector:@selector(onBatteryUpdate:)]) {
        [_batteryDelegate onBatteryUpdate:tmpBattery];
    }
}

#pragma mark Receive Position information
void receive_position(Telemetry::Position position) {
    YNCPosition *tmpPosition = [YNCPosition new];
    tmpPosition.latitudeDeg = position.latitude_deg;
    tmpPosition.longitudeDeg = position.longitude_deg;
    tmpPosition.absoluteAltitudeM = position.absolute_altitude_m;
    tmpPosition.relativeAltitudeM = position.relative_altitude_m;
    
    if (_positionDelegate &&
        [_positionDelegate respondsToSelector:@selector(onPositionUpdate:)]) {
        [_positionDelegate onPositionUpdate:tmpPosition];
    }
}

#pragma mark Receive UAV speed
void receive_ground_speed_ned(Telemetry::GroundSpeedNED ground_speed_ned) {
    YNCGroundSpeedNED *tmpSpeed = [YNCGroundSpeedNED new];
    tmpSpeed.velocityNorthMS = ground_speed_ned.velocity_north_m_s;
    tmpSpeed.velocityEastMS = ground_speed_ned.velocity_east_m_s;
    tmpSpeed.velocityDownMS = ground_speed_ned.velocity_down_m_s;
    
    if (_groundSpeedNEDDelegate &&
        [_groundSpeedNEDDelegate respondsToSelector:@selector(onGroundSpeedNEDUpdate:)]) {
        [_groundSpeedNEDDelegate onGroundSpeedNEDUpdate:tmpSpeed];
    }
}

#pragma mark Receive GPS information
void receive_GPSInfo(Telemetry::GPSInfo gpsInfo) {
    YNCGPSInfo *tmpGPSInfo = [YNCGPSInfo new];
    tmpGPSInfo.numSatellites = gpsInfo.num_satellites;
    tmpGPSInfo.fixType = gpsInfo.fix_type;
    
    if (_gpsInfoDelegate &&
        [_gpsInfoDelegate respondsToSelector:@selector(onGPSInfoUpdate:)]) {
        [_gpsInfoDelegate onGPSInfoUpdate:tmpGPSInfo];
    }
}

#pragma mark Receive Attitude EulerAngle information
void receive_attitudeEulerAngle(Telemetry::EulerAngle eulerAngle) {
    YNCAttitudeEulerAngle *tmpEulerAngle = [YNCAttitudeEulerAngle new];
    tmpEulerAngle.pitchDeg = eulerAngle.pitch_deg;
    tmpEulerAngle.rollDeg = eulerAngle.roll_deg;
    tmpEulerAngle.yawDeg = eulerAngle.yaw_deg;
    
    if (_attitudeEulerAngleDelegate &&
        [_attitudeEulerAngleDelegate respondsToSelector:@selector(onAttitudeEulerAngleUpdate:)]) {
        [_attitudeEulerAngleDelegate onAttitudeEulerAngleUpdate:tmpEulerAngle];
    }
}

#pragma mark Receive Attitude Quaternion information
void receive_attitudeQuaternion(Telemetry::Quaternion quaternion) {
    YNCAttitudeQuaternion *tmpQuaternion = [YNCAttitudeQuaternion new];
    tmpQuaternion.w = quaternion.w;
    tmpQuaternion.x = quaternion.x;
    tmpQuaternion.y = quaternion.y;
    tmpQuaternion.z = quaternion.z;
    
    if (_attitudeQuaternionDelegate &&
        [_attitudeQuaternionDelegate respondsToSelector:@selector(onAttitudeQuaternionUpdate:)]) {
        [_attitudeQuaternionDelegate onAttitudeQuaternionUpdate:tmpQuaternion];
    }
}

#pragma mark Receive Home Position information
void receive_homePosition(Telemetry::Position homePosition) {
    YNCPosition *tmpHomePosition = [YNCPosition new];
    tmpHomePosition.latitudeDeg = homePosition.latitude_deg;
    tmpHomePosition.longitudeDeg = homePosition.longitude_deg;
    tmpHomePosition.absoluteAltitudeM = homePosition.absolute_altitude_m;
    tmpHomePosition.relativeAltitudeM = homePosition.relative_altitude_m;
    
    if (_homePositionDelegate &&
        [_homePositionDelegate respondsToSelector:@selector(onHomePositionUpdate:)]) {
        [_homePositionDelegate onHomePositionUpdate:tmpHomePosition];
    }
}

#pragma mark Receive In Air information
void receive_inAir(bool inAir) {
    if (_inAirDelegate && [_inAirDelegate respondsToSelector:@selector(onInAirUpdate:)]) {
        [_inAirDelegate onInAirUpdate:inAir];
    }
}

#pragma mark Receive Camera Attitude EulerAngle information
void receive_CameraAttitudeEulerAngle(Telemetry::EulerAngle eulerAngle) {
    YNCAttitudeEulerAngle *tmpAttitude = [YNCAttitudeEulerAngle new];
    tmpAttitude.pitchDeg = eulerAngle.pitch_deg;
    tmpAttitude.rollDeg = eulerAngle.roll_deg;
    tmpAttitude.yawDeg = eulerAngle.yaw_deg;
    
    if (_cameraAttitudeEulerAngleDelegate &&
        [_cameraAttitudeEulerAngleDelegate respondsToSelector:@selector(onCameraAttitudeEulerAngleUpdate:)]) {
        [_cameraAttitudeEulerAngleDelegate onCameraAttitudeEulerAngleUpdate:tmpAttitude];
    }
}

#pragma mark Receive Camera Attitude Quaternion information
void receive_CameraAttitudeQuaternion(Telemetry::Quaternion quaternion) {
    YNCAttitudeQuaternion *tmpAttitude = [YNCAttitudeQuaternion new];
    tmpAttitude.w = quaternion.w;
    tmpAttitude.x = quaternion.x;
    tmpAttitude.y = quaternion.y;
    tmpAttitude.z = quaternion.z;
    
    if (_cameraAttitudeQuaternionDelegate &&
        [_cameraAttitudeQuaternionDelegate respondsToSelector:@selector(onCameraAttitudeQuaternionUpdate:)]) {
        [_cameraAttitudeQuaternionDelegate onCameraAttitudeQuaternionUpdate:tmpAttitude];
    }
}

#pragma mark Receive RC Status information
void receive_RCStatus(Telemetry::RCStatus RCStatus) {
    YNCRCStatus *tmpRCStatus = [YNCRCStatus new];
    tmpRCStatus.availableOnce = RCStatus.available_once;
    tmpRCStatus.lost = RCStatus.lost;
    tmpRCStatus.signalStrengthPercent = RCStatus.signal_strength_percent;
    
    if (_rcStatusDelegate &&
        [_rcStatusDelegate respondsToSelector:@selector(onRCStatusUpdate:)]) {
        [_rcStatusDelegate onRCStatusUpdate:tmpRCStatus];
    }
}

#pragma mark Flight Mode information
void receive_flightMode(Telemetry::FlightMode flightMode) {
    YNCTelemetryFlightMode tmpFlightMode;
    
    switch (flightMode) {
        case Telemetry::FlightMode::READY:
            tmpFlightMode = YNCREADY;
            break;
            
        case Telemetry::FlightMode::TAKEOFF:
            tmpFlightMode = YNCTAKEOFF;
            break;
            
        case Telemetry::FlightMode::HOLD:
            tmpFlightMode = YNCHOLD;
            break;
            
        case Telemetry::FlightMode::MISSION:
            tmpFlightMode = YNCMISSION;
            break;
            
        case Telemetry::FlightMode::RETURN_TO_LAUNCH:
            tmpFlightMode = YNCRETURN_TO_LAUNCH;
            break;
            
        case Telemetry::FlightMode::LAND:
            tmpFlightMode = YNCLAND;
            break;
            
        case Telemetry::FlightMode::OFFBOARD:
            tmpFlightMode = YNCOFFBOARD;
            break;
           
        case Telemetry::FlightMode::UNKNOWN:
        default:
            tmpFlightMode = YNCUNKNOWN;
            break;
    }
    
    if (_flightModeDelegate &&
        [_flightModeDelegate respondsToSelector:@selector(onFlightModeUpdate:)]) {
        [_flightModeDelegate onFlightModeUpdate:tmpFlightMode];
    }
}

#pragma mark Receive Health information
void receive_health(Telemetry::Health health) {
    YNCHealth *tmpHealth = [YNCHealth new];
    tmpHealth.homePositionOk = health.home_position_ok;
    tmpHealth.localPositionOk = health.local_position_ok;
    tmpHealth.globalPositionOk = health.global_position_ok;
    tmpHealth.levelCalibrationOk = health.level_calibration_ok;
    tmpHealth.gyrometerCalibrationOk = health.gyrometer_calibration_ok;
    tmpHealth.magnetometerCalibrationOk = health.magnetometer_calibration_ok;
    tmpHealth.accelerometerCalibrationOk = health.accelerometer_calibration_ok;
    
    if (_healthDelegate &&
        [_healthDelegate respondsToSelector:@selector(onHealthUpdate:)]) {
        [_healthDelegate onHealthUpdate:tmpHealth];
    }
}

#pragma mark Receive armed information
void receive_armed(bool armed) {
    if (_armedDelegate && [_armedDelegate respondsToSelector:@selector(onArmedUpdate:)]) {
        [_armedDelegate onArmedUpdate:armed];
    }
}

#pragma mark Receive health all information
void receive_healthAllOk(bool healthAllOk) {
    if (_healthAllOkDelegate && [_healthAllOkDelegate respondsToSelector:@selector(onHealthAllOkUpdate:)]) {
        [_healthAllOkDelegate onHealthAllOkUpdate:healthAllOk];
    }
}

@implementation YNCBattery
@end

@implementation YNCSDKTelemetryBattery

- (void)subscribe:(id<YNCSDKTelemetryBatteryDelegate>) delegate {
    _batteryDelegate = delegate;
    DroneLink *dl = [[YNCSDKInternal instance] dl];
    dl->device().telemetry().battery_async(&receive_battery);
}

@end

@implementation YNCPosition
@end

@implementation YNCSDKTelemetryPosition

- (void)subscribe:(id<YNCSDKTelemetryPositionDelegate>) delegate {
    _positionDelegate = delegate;
    DroneLink *dl = [[YNCSDKInternal instance] dl];
    dl->device().telemetry().position_async(&receive_position);
}

@end

@implementation YNCGroundSpeedNED
@end

@implementation YNCSDKTelemetryGroundSpeedNED

- (void)subscribe:(id<YNCSDKTelemetryGroundSpeedNEDDelegate>) delegate {
    _groundSpeedNEDDelegate = delegate;
    DroneLink *dl = [[YNCSDKInternal instance] dl];
    dl->device().telemetry().ground_speed_ned_async(&receive_ground_speed_ned);
}

@end

@implementation YNCGPSInfo
@end

@implementation YNCSDKTelemetryGPSInfo

- (void)subscribe:(id<YNCSDKTelemetryGPSInfoDelegate>) delegate {
    _gpsInfoDelegate = delegate;
    DroneLink *dl = [[YNCSDKInternal instance] dl];
    dl->device().telemetry().gps_info_async(&receive_GPSInfo);
}

@end

@implementation YNCAttitudeEulerAngle
@end

@implementation YNCSDKTelemetryAttitudeEulerAngle

- (void)subscribe:(id<YNCSDKTelemetryAttitudeEulerAngleDelegate>) delegate {
    _attitudeEulerAngleDelegate = delegate;
    DroneLink *dl = [[YNCSDKInternal instance] dl];
    dl->device().telemetry().attitude_euler_angle_async(&receive_attitudeEulerAngle);
}

@end

@implementation YNCAttitudeQuaternion
@end

@implementation YNCSDKTelemetryAttitudeQuaternion

- (void)subscribe:(id<YNCSDKTelemetryAttitudeQuaternionDelegate>) delegate {
    _attitudeQuaternionDelegate = delegate;
    DroneLink *dl = [[YNCSDKInternal instance] dl];
    dl->device().telemetry().attitude_quaternion_async(&receive_attitudeQuaternion);
}

@end

@implementation YNCSDKTelemetryHomePosition

- (void)subscribe:(id<YNCSDKTelemetryHomePositionDelegate>) delegate {
    _homePositionDelegate = delegate;
    DroneLink *dl = [[YNCSDKInternal instance] dl];
    dl->device().telemetry().home_position_async(&receive_homePosition);
}

@end

@implementation YNCSDKTelemetryInAir

- (void)subscribe:(id<YNCSDKTelemetryInAirDelegate>) delegate {
    _inAirDelegate = delegate;
    DroneLink *dl = [[YNCSDKInternal instance] dl];
    dl->device().telemetry().in_air_async(&receive_inAir);
}

@end

@implementation YNCSDKTelemetryCameraAttitudeEulerAngle

- (void)subscribe:(id<YNCSDKTelemetryCameraAttitudeEulerAngleDelegate>) delegate {
    _cameraAttitudeEulerAngleDelegate = delegate;
    DroneLink *dl = [[YNCSDKInternal instance] dl];
    dl->device().telemetry().camera_attitude_euler_angle_async(&receive_attitudeEulerAngle);
}

@end

@implementation YNCSDKTelemetryCameraAttitudeQuaternion

- (void)subscribe:(id<YNCSDKTelemetryCameraAttitudeQuaternionDelegate>) delegate {
    _cameraAttitudeQuaternionDelegate = delegate;
    DroneLink *dl = [[YNCSDKInternal instance] dl];
    dl->device().telemetry().camera_attitude_quaternion_async(&receive_attitudeQuaternion);
}

@end

@implementation YNCRCStatus
@end

@implementation YNCSDKTelemetryRCStatus

- (void)subscribe:(id<YNCSDKTelemetryRCStatusDelegate>) delegate {
    _rcStatusDelegate = delegate;
    DroneLink *dl = [[YNCSDKInternal instance] dl];
    dl->device().telemetry().rc_status_async(&receive_RCStatus);
}

@end

@implementation YNCSDKTelemetryFlightMode

- (void)subscribe:(id<YNCSDKTelemetryFlightModeDelegate>) delegate {
    _flightModeDelegate = delegate;
    DroneLink *dl = [[YNCSDKInternal instance] dl];
    dl->device().telemetry().flight_mode_async(&receive_flightMode);
}

@end

@implementation YNCHealth
@end

@implementation YNCSDKTelemetryHealth

- (void)subscribe:(id<YNCSDKTelemetryHealthDelegate>) delegate {
    _healthDelegate = delegate;
    DroneLink *dl = [[YNCSDKInternal instance] dl];
    dl->device().telemetry().health_async(&receive_health);
}

@end

@implementation YNCSDKTelemetryArmed

- (void)subscribe:(id<YNCSDKTelemetryArmedDelegate>) delegate {
    _armedDelegate = delegate;
    DroneLink *dl = [[YNCSDKInternal instance] dl];
    dl->device().telemetry().armed_async(&receive_armed);
}

@end

@implementation YNCSDKTelemetryHealthAllOk

- (void)subscribe:(id<YNCSDKTelemetryHealthAllOkDelegate>) delegate {
    _healthAllOkDelegate = delegate;
    DroneLink *dl = [[YNCSDKInternal instance] dl];
    dl->device().telemetry().health_all_ok_async(&receive_healthAllOk);
}

@end
