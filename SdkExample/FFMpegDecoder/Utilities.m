//
//  Utilities.m
//  Yuneec_SDK_iOS_Example
//
//  Created by Steven Hall on 8/30/17.
//  Copyright © 2017 yuneec. All rights reserved.
//

#import "Utilities.h"


@implementation Utilities

+(NSString *)bundlePath:(NSString *)fileName {
	return [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:fileName];
}

+(NSString *)documentsPath:(NSString *)fileName {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:fileName];
}

@end
