/*
 * YNCSDKInternal.h
 * YUNEEC_SDK_IOS
 *
 * Copyright @ 2016 Yuneec.
 * All rights reserved.
 *
*/

#import <Foundation/Foundation.h>

#include <dronelink/dronelink.h>


/*
 This class provides methods for Dronelink, a messaging library for PX4 using mavlink.
 */
@interface YNCSDKInternal : NSObject

/**
 Dronelink object
 */
@property (nonatomic) dronelink::DroneLink *dl;

+ (id)instance;

@end
