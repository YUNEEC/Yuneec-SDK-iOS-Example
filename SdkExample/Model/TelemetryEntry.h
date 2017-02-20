//
//  TelemetryEntry.h
//  SdkExample
//
//  Created by Julian Oes on 25/08/16.
//  Copyright © 2016 Julian Oes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TelemetryEntry : NSObject

- (instancetype)init;
- (instancetype)initWithProperty:(NSString *)property
                           value:(NSString *)value NS_DESIGNATED_INITIALIZER;

@property (nonatomic, strong) NSString *property;
@property (nonatomic, assign) NSString *value;

@end
