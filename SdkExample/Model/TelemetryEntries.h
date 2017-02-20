//
//  TelemetryEntries.h
//  Yuneec_SDK_iOSExample
//
//  Created by Julian Oes on 22/12/16.
//  Copyright © 2016 yuneec. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TelemetryEntry.h"

@interface TelemetryEntries : NSObject

@property (nonatomic, strong) NSMutableArray <TelemetryEntry *> *entries;

@end
