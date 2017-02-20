//
//  TelemetryEntries.m
//  Yuneec_SDK_iOSExample
//
//  Created by Julian Oes on 22/12/16.
//  Copyright © 2016 yuneec. All rights reserved.
//

#import "TelemetryEntries.h"
#import <Yuneec_SDK_iOS/Yuneec_SDK_iOS.h>

@interface TelemetryEntries () <YNCSDKConnectionDelegate,
                                YNCSDKTelemetryBatteryDelegate,
                                YNCSDKTelemetryPositionDelegate,
                                YNCSDKTelemetryGroundSpeedNEDDelegate,
                                YNCSDKTelemetryAttitudeEulerAngleDelegate,
                                YNCSDKTelemetryInAirDelegate,
                                YNCSDKTelemetryGPSInfoDelegate,
                                YNCSDKTelemetryArmedDelegate,
                                YNCSDKTelemetryHealthDelegate>
@end

@implementation TelemetryEntries

NS_ENUM(NSInteger, EntryType) {
    ALTITUDE = 0,
    LATITUDE_LONGITUDE,
    GROUNDSPEED,
    BATTERY,
    ATTITUDE,
    GPS,
    IN_AIR,
    ARMED,
    HEALTH,
    ENTRY_TYPE_MAX
};

- (instancetype)init {
    
    [[YNCSDKConnection instance] setDelegate: self];
    
    if (!self.entries) {
        self.entries = [[NSMutableArray alloc] initWithCapacity:ENTRY_TYPE_MAX];
        
        {
            TelemetryEntry *entry = [[TelemetryEntry alloc] init];
            entry.property = @"Relative, absolute altitude";
            [_entries insertObject:entry atIndex:ALTITUDE];
        }
        
        {
            TelemetryEntry *entry = [[TelemetryEntry alloc] init];
            entry.property = @"Latitude, longitude";
            [_entries insertObject:entry atIndex:LATITUDE_LONGITUDE];
        }
        
        {
            TelemetryEntry *entry = [[TelemetryEntry alloc] init];
            entry.property = @"Groundspeed (North, East, Down)";
            [_entries insertObject:entry atIndex:GROUNDSPEED];
        }
        
        {
            TelemetryEntry *entry = [[TelemetryEntry alloc] init];
            entry.property = @"Battery";
            [_entries insertObject:entry atIndex:BATTERY];
        }
        
        {
            TelemetryEntry *entry = [[TelemetryEntry alloc] init];
            entry.property = @"Attitude (roll, pitch, yaw)";
            [_entries insertObject:entry atIndex:ATTITUDE];
        }
        
        {
            TelemetryEntry *entry = [[TelemetryEntry alloc] init];
            entry.property = @"GPS fix, number of satellites";
            [_entries insertObject:entry atIndex:GPS];
        }
        
        {
            TelemetryEntry *entry = [[TelemetryEntry alloc] init];
            entry.property = @"In-air/on-ground";
            [_entries insertObject:entry atIndex:IN_AIR];
        }
        
        {
            TelemetryEntry *entry = [[TelemetryEntry alloc] init];
            entry.property = @"Armed/disarmed";
            [_entries insertObject:entry atIndex:ARMED];
        }
        
        {
            TelemetryEntry *entry = [[TelemetryEntry alloc] init];
            entry.property = @"Health";
            [_entries insertObject:entry atIndex:HEALTH];
        }
    }
    return self;
}

- (void)onDiscover {
    [[[YNCSDKTelemetryBattery alloc] init] subscribe: self];
    [[[YNCSDKTelemetryPosition alloc] init] subscribe: self];
    [[[YNCSDKTelemetryGroundSpeedNED alloc] init] subscribe: self];
    [[[YNCSDKTelemetryAttitudeEulerAngle alloc] init] subscribe: self];
    [[[YNCSDKTelemetryInAir alloc] init] subscribe: self];
    [[[YNCSDKTelemetryGPSInfo alloc] init] subscribe: self];
    [[[YNCSDKTelemetryArmed alloc] init] subscribe: self];
    [[[YNCSDKTelemetryHealth alloc] init] subscribe: self];
}

- (void)onPositionUpdate:(YNCPosition *)position {
    _entries[ALTITUDE].value = [NSString stringWithFormat:@"%.2f m, %.2f m",
                                          position.relativeAltitudeM,
                                          position.absoluteAltitudeM];
    
    _entries[LATITUDE_LONGITUDE].value = [NSString stringWithFormat:@"%.6f deg, %.6f deg",
                                                    position.latitudeDeg,
                                                    position.longitudeDeg];
}

- (void)onGroundSpeedNEDUpdate:(YNCGroundSpeedNED *)groundSpeedNED {
    
    _entries[GROUNDSPEED].value = [NSString stringWithFormat:@"%.1f m/s, %.1f m/s, %.1f m/s",
                                             groundSpeedNED.velocityNorthMS,
                                             groundSpeedNED.velocityEastMS,
                                             groundSpeedNED.velocityDownMS];
}

- (void)onBatteryUpdate:(YNCBattery *)battery {
    
    _entries[BATTERY].value = [NSString stringWithFormat:@"%.1f V (%d %%)",
                                         battery.voltageV,
                                         (int)(100.0f*battery.remainingPercent)];
}

- (void)onAttitudeEulerAngleUpdate:(YNCAttitudeEulerAngle *)attitudeEulerAngle {
    
    _entries[ATTITUDE].value = [NSString stringWithFormat:@"%d deg, %d deg, %d deg",
                                         (int)(attitudeEulerAngle.rollDeg),
                                         (int)(attitudeEulerAngle.pitchDeg),
                                         (int)(attitudeEulerAngle.yawDeg)];
}

- (void)onGPSInfoUpdate:(YNCGPSInfo *)gpsInfo {
    
    // TODO: add explanation for fix type instead of fix type number
    _entries[GPS].value = [NSString stringWithFormat:@"%d, %d",
                                     gpsInfo.fixType,
                                     gpsInfo.numSatellites];
}

- (void)onInAirUpdate:(BOOL)inAir {
    
    if (inAir) {
        _entries[IN_AIR].value = @"In-air";
    } else {
        _entries[IN_AIR].value = @"On-ground";
    }
    
}

- (void)onArmedUpdate:(BOOL)armed {
    
    if (armed) {
        _entries[ARMED].value = @"Armed";
    } else {
        _entries[ARMED].value = @"Disarmed";
    }
}

- (void)onHealthUpdate:(YNCHealth *)health {
    
    BOOL calibration_ok = false;
    if (health.accelerometerCalibrationOk &&
        health.gyrometerCalibrationOk &&
        health.magnetometerCalibrationOk &&
        health.levelCalibrationOk) {
        calibration_ok = true;
    }
    
    BOOL position_ok = false;
    if (health.localPositionOk &&
        health.globalPositionOk &&
        health.homePositionOk) {
        position_ok = true;
    }
    
    _entries[HEALTH].value = [NSString stringWithFormat:@"calibration %@, position %@",
                                        calibration_ok ? @"ok" : @"not ok",
                                        position_ok ? @"ok" : @"not ok"];
}
@end
