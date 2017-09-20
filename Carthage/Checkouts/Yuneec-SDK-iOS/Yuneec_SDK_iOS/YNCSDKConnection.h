/*
 * YNCSDKConnection.h
 * YUNEEC_SDK_IOS
 *
 * Copyright @ 2016 Yuneec.
 * All rights reserved.
 *
*/ 

#import <Foundation/Foundation.h>

/**
 This delegate provides notification of the connection status.
 */
@protocol YNCSDKConnectionDelegate <NSObject>
@optional
/**
 Connection to drone has been detected (or re-connected).
 */
- (void)onDiscover;

/**
 Connection to drone has timed out. No heartbeat has been received for over 3 seconds.
 */
- (void)onTimeout;
@end

/**
 This class provides methods to manage the wireless link to the drone.
 */
@interface YNCSDKConnection : NSObject
/**
 Returns a singleton instance for the connection.
 */
+ (id)instance;

/**
 Initiates the connection over UDP to the drone.
 
 @return YES if successful, and NO if an error occurred. In case of error, check the log output for more info.
 */
- (BOOL)connect;

/**
 Sets a delegate to get notified about the connection status.
 */
- (void)setDelegate:(id<YNCSDKConnectionDelegate>)delegate;

@end
