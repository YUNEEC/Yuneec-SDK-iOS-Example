//
//  TelemetryEntry.m
//  SdkExample
//
//  Created by Julian Oes on 25/08/16.
//  Copyright © 2016 Julian Oes. All rights reserved.
//

#import "TelemetryEntry.h"

@implementation TelemetryEntry

- (instancetype)init {
    return [self initWithProperty:@""
                            value:@"-"];
}

- (instancetype)initWithProperty:(NSString *)property
                           value:(NSString *)value {
    self = [super init];
    if (self) {
        _property = property;
        _value = value;
    }
    return self;
}

@end
