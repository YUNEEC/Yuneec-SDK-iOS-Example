//
//  YNCSDKMissionItem.h
//  Yuneec_SDK_iOS
//
//  Created by Julian Oes on 17/02/17.
//  Copyright © 2017 Yuneec. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Data type for specifying camera action types.
 */
typedef NS_ENUM (NSInteger, YNCCameraAction) {
    /** Takes a photo */
    TAKE_PHOTO,
    /** Starts burst mode */
    START_PHOTO_INTERVAL,
    /** Stops burst mode */
    STOP_PHOTO_INTERVAL,
    /** Starts video */
    START_VIDEO,
    /** Stop svideo */
    STOP_VIDEO,
    /** No action */
    NONE
};

/**
 This class represents a mission item, i.e. waypoint settings.
 */
@interface YNCSDKMissionItem : NSObject
    
    /** Latitude in Degrees */
    @property double latitudeDeg;
    /** Longitude in Degrees */
    @property double longitudeDeg;
    /** Relative Altitude in Meters */
    @property float relativeAltitudeM;
    /** Speed in Meters per second (m/s) */
    @property float speedMS;
    /** True if no stopping at the waypoint*/
    @property bool isFlyThrough;
    /** Pitch (tilt) of gimbal in Degrees */
    @property float gimbalPitchDeg;
    /** Yaw (rotation/pan) angle of gimbal in Degrees */
    @property float gimbalYawDeg;
    /** Camera action to perform (see Camera Action Types for options) */
    @property YNCCameraAction cameraAction;

@end
