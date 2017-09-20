/*
 * YNCAction.h
 * YUNEEC_SDK_IOS
 *
 * Copyright @ 2016 Yuneec.
 * All rights reserved.
 *
*/

#import <Foundation/Foundation.h>

/**
 Data type for completion blocks for action commands that contain error results, if any.
 */
typedef void (^YNCActionCompletion)(NSError *error);

/**
 This class provides methods to send different commands to the drone.
 */
@interface YNCAction : NSObject

/**
 * Turns on the motors.
 *
 * @param completion Completion function block
 */
+ (void)armWithCompletion:(YNCActionCompletion)completion;

/**
 * Turns off the motors when the drone is grounded and not in-air.
 *
 * @param completion Completion function block
 */
+ (void)disarmWithCompletion:(YNCActionCompletion)completion;

/**
 * Sends command to take-off using the default take off height.
 *
 * @param completion Completion function block
 */
+ (void)takeoffWithCompletion:(YNCActionCompletion)completion;

/**
 * Sends command to land the drone at the current position.
 *
 * @param completion Completion function block
 */
+ (void)landWithCompletion:(YNCActionCompletion)completion;

/**
 * Sends command to return to the home position.
 *
 * @param completion Completion function block
 */
+ (void)doReturnToLaunchWithCompletion:(YNCActionCompletion)completion;

/**
 * Switches off power to the motors.
 *
 * Warning: if triggered in-air, the drone will drop straight down. This cuts all power the motors and should only be used for emergency situations.
 *
 * @param completion Completion function block
 */
+ (void)killWithCompletion:(YNCActionCompletion)completion;

@end
