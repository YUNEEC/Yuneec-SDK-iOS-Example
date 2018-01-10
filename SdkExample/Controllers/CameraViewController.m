//
//  CameraViewController.m
//  Yuneec_SDK_iOS_Example
//
//  Created by Steven Hall on 9/13/17.
//  Copyright © 2017 yuneec. All rights reserved.
//

#import "CameraViewController.h"
#import <Yuneec_SDK_iOS/Yuneec_SDK_iOS.h>

@interface CameraViewController ()

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)takePhoto:(id)sender {
    [YNCSDKCamera takePhotoWithCompletion:^(NSError *error) {
        if (error) {
            NSLog(@"error description - domain: %@\n code: %ld\n message: %@\n",
                  error.domain, (long)error.code, error.userInfo[@"message"]);
            [CameraViewController showAlert:[NSString stringWithFormat:@"%@ error: %@\n",
                                             error.domain,
                                             error.userInfo[@"message"]] :self];
        } else {
            NSLog(@"Photo taken successfully");
        }
    }];
}
- (IBAction)startInterval:(id)sender {
    [YNCSDKCamera startPhotoInterval:1.0 Completion:^(NSError *error) {
        if (error) {
            NSLog(@"error description - domain: %@\n code: %ld\n message: %@\n",
                  error.domain, (long)error.code, error.userInfo[@"message"]);
            [CameraViewController showAlert:[NSString stringWithFormat:@"%@ error: %@\n",
                                             error.domain,
                                             error.userInfo[@"message"]] :self];
        } else {
            NSLog(@"Interval started");
        }
    }];
}
- (IBAction)stopInterval:(id)sender {
    [YNCSDKCamera stopPhotoIntervalWithCompletion:^(NSError *error) {
        if (error) {
            NSLog(@"error description - domain: %@\n code: %ld\n message: %@\n",
                  error.domain, (long)error.code, error.userInfo[@"message"]);
            [CameraViewController showAlert:[NSString stringWithFormat:@"%@ error: %@\n",
                                             error.domain,
                                             error.userInfo[@"message"]] :self];
        } else {
            NSLog(@"Interval Stopped");
        }
    }];
}
- (IBAction)startVideo:(id)sender {
    [YNCSDKCamera startVideoWithCompletion:^(NSError *error) {
        if (error) {
            NSLog(@"error description - domain: %@\n code: %ld\n message: %@\n",
                  error.domain, (long)error.code, error.userInfo[@"message"]);
            [CameraViewController showAlert:[NSString stringWithFormat:@"%@ error: %@\n",
                                             error.domain,
                                             error.userInfo[@"message"]] :self];
        } else {
            NSLog(@"Video Started");
        }
    }];
}
- (IBAction)getColorMode:(id)sender {
    [YNCSDKCameraSettings getColorModeWithCompletion:^(YNCCameraColorMode colorMode, NSError *error) {
        if (error) {
            NSLog(@"error description - domain: %@\n code: %ld\n message: %@\n",
                  error.domain, (long)error.code, error.userInfo[@"message"]);
            [CameraViewController showAlert:[NSString stringWithFormat:@"%@ error: %@\n",
                                             error.domain,
                                             error.userInfo[@"message"]] :self];
        } else {
            NSLog(@"Color Mode is : %ld", (long) colorMode);
        }
    }];
}

- (IBAction)stopVideo:(id)sender {
    [YNCSDKCamera stopVideoWithCompletion:^(NSError *error) {
        if (error) {
            NSLog(@"error description - domain: %@\n code: %ld\n message: %@\n",
                  error.domain, (long)error.code, error.userInfo[@"message"]);
            [CameraViewController showAlert:[NSString stringWithFormat:@"%@ error: %@\n",
                                             error.domain,
                                             error.userInfo[@"message"]] :self];
        } else {
            NSLog(@"Video Stopped");
        }
    }];
}

+ (void)showAlert:(NSString *)message :(UIViewController *)viewController {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil ]];
    [viewController presentViewController:alert animated:YES completion:nil];
}

@end
