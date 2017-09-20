//
//  YNCSDKConnection.m
//  Yuneec_SDK_iOSExample
//
//  Created by Julian Oes on 23/12/16.
//  Copyright © 2016 yuneec. All rights reserved.
//

#import "YNCSDKConnection.h"
#import "YNCSDKInternal.h"

#include <vector>

using namespace dronelink;

static id<YNCSDKConnectionDelegate> _delegate;

@implementation YNCSDKConnection

// Singleton
+ (id)instance {
    static YNCSDKConnection *temp = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        temp = [[self alloc] init];
    });
    
    return temp;
}

- (instancetype)init {
    self = [super init];
    return self;
}

- (void)dealloc {
    // Should never be called.
}

void on_discover(uint64_t uuid) {
    NSLog(@"Found device with UUID: %llu", uuid);
    if (_delegate && [_delegate respondsToSelector:@selector(onDiscover)]) {
        [_delegate onDiscover];
    }
}

void on_timeout(uint64_t uuid) {
    NSLog(@"Lost device with UUID: %llu", uuid);
    if (_delegate && [_delegate respondsToSelector:@selector(onTimeout)]) {
        [_delegate onTimeout];
    }
}

- (BOOL)connect {
    [self requestNetwork];
    
    DroneLink *dl = [[YNCSDKInternal instance] dl];
    DroneLink::ConnectionResult ret = dl->add_udp_connection();
    
    if (ret != DroneLink::ConnectionResult::SUCCESS) {
        NSLog(@"Connect error: %u", (unsigned)ret);
        return false;
    }
    
    dl->register_on_discover(&on_discover);
    dl->register_on_timeout(&on_timeout);
    
    return true;
}

- (void)setDelegate:(id<YNCSDKConnectionDelegate>)delegate {
    _delegate = delegate;
}

//MARK:Since China's National Bank iPhone requires users to allow App to access cellular data and WiFi connection to the network, add a network request to prompt the network for permission, to resolve the qustion of "no route to host"
- (void)requestNetwork {
    NSURL *url = [NSURL URLWithString:@"https://192.168.42.1/"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"%@",dict);
        } else {
            NSLog(@"request network error:%@",error);
        }
    }];
    
    [dataTask resume];
}

@end
