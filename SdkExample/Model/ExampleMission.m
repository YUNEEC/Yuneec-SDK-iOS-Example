//
//  ExampleMission.m
//  Yuneec_SDK_iOSExample
//
//  Created by Julian Oes on 17/02/17.
//  Copyright © 2017 yuneec. All rights reserved.
//

#import "ExampleMission.h"
#import <Yuneec_SDK_iOS/Yuneec_SDK_iOS.h>

@implementation ExampleMission

- (instancetype)init {
    self = [super init];
    self.missionItems = [[NSMutableArray alloc] init];
    
    {
        YNCSDKMissionItem *item = [[YNCSDKMissionItem alloc] init];
        item.latitudeDeg = 47.398039859999997;
        item.longitudeDeg = 8.5455725400000002;
        item.relativeAltitudeM = 10.0f;
        item.gimbalPitchDeg = -60.0f;
        item.gimbalYawDeg = -90.0f;
        item.cameraAction = START_PHOTO_INTERVAL;
        [self.missionItems addObject:item];
    }
    {
        YNCSDKMissionItem *item = [[YNCSDKMissionItem alloc] init];
        item.latitudeDeg = 47.398036222362471;
        item.longitudeDeg = 8.5450146439425509;
        item.relativeAltitudeM = 10.0f;
        item.gimbalPitchDeg = -30.0f;
        item.gimbalYawDeg = 0.0f;
        item.cameraAction = STOP_PHOTO_INTERVAL;
        [self.missionItems addObject:item];
    }
    {
        YNCSDKMissionItem *item = [[YNCSDKMissionItem alloc] init];
        item.latitudeDeg = 47.397825620791885;
        item.longitudeDeg = 8.5450092830163271;
        item.relativeAltitudeM = 10.0f;
        item.gimbalPitchDeg = -60.0f;
        item.gimbalYawDeg = -60.0f;
        item.cameraAction = START_VIDEO;
        [self.missionItems addObject:item];
    }
    {
        YNCSDKMissionItem *item = [[YNCSDKMissionItem alloc] init];
        item.latitudeDeg = 47.397832880000003;
        item.longitudeDeg = 8.5455939999999995;
        item.relativeAltitudeM = 10.0f;
        item.gimbalPitchDeg = 0.0f;
        item.gimbalYawDeg = 0.0f;
        item.cameraAction = STOP_VIDEO;
        [self.missionItems addObject:item];
    }
    
    return self;
}

@end
