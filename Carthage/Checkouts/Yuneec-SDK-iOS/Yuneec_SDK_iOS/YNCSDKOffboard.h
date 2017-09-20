/*
 * YNCSDKOffboard.h
 * YUNEEC_SDK_IOS
 *
 * Copyright @ 2016 Yuneec.
 * All rights reserved.
 *
*/

#import <Foundation/Foundation.h>

/**
 Data type for completion blocks for offboard controls that contain error results, if any.
 */
typedef void (^YNCOffboardCompletion)(NSError *error);

/**
 This class provides methods to send velocity commands to the drone.
 */
@interface YNCSDKOffboard : NSObject

/**
 * Starts the offboard (manual) control mode.
 * 
 * This requires that a velocity waypoint has already been set.
 * 
 * @param completion the completion block returning the error status, if any
 */
+ (void)startWithCompletion:(YNCOffboardCompletion)completion;

/**
 * Stops the offboard (manual) control mode.
 *
 * The drone will go back to pause mode and hold its position.
 * 
 * @param completion the completion block returning the error status, if any
 */
+ (void)stopWithCompletion:(YNCOffboardCompletion)completion;

/**
 Sets the drone velocity in ground coordinates. You should set a speed every 30ms to ensure smooth flight operation.
 
 @param velocityNorth the north direction ground speed (m/s)
 @param velocityEast the east direction ground speed (m/s)
 @param velocityDown the down direction ground speed (m/s)
 @param yawDeg the yaw angle (in degrees - 0 is North, 90 East)
 */
+ (void)setVelocityNEDYawWithVelocityNorth:(float)velocityNorth
                          withVelocityEast:(float)velocityEast
                          withVelocityDown:(float)velocityDown
                                   withYaw:(float)yawDeg;
/**
 * Sets the drone velocity in body coordinates. You should set a speed every 30ms to ensure smooth flight operation.
 *
 * @param velocityForward the forward direction body speed (in m/s - negative for Backward)
 * @param velocityRight the right direction body speed (in ms/s - negative for Left)
 * @param velocityDown the down direction body speed (in ms/s - negative for Up)
 * @param yawspeed the yaw speed (in deg/sec - positive for clockwise from top view)
 */
+ (void)setVelocityBodyYawspeedWithVelocityForward:(float)velocityForward
                                 withVelocityRight:(float)velocityRight
                                  withVelocityDown:(float)velocityDown
                                     witchYawspeed:(float)yawspeed;

@end
