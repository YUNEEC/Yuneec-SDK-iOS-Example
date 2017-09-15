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
            [StreamViewController showAlert:[NSString stringWithFormat:@"%@ error: %@\n",
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
            [StreamViewController showAlert:[NSString stringWithFormat:@"%@ error: %@\n",
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
            [StreamViewController showAlert:[NSString stringWithFormat:@"%@ error: %@\n",
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
            [StreamViewController showAlert:[NSString stringWithFormat:@"%@ error: %@\n",
                                             error.domain,
                                             error.userInfo[@"message"]] :self];
        } else {
            NSLog(@"Video Started");
        }
    }];
}
- (IBAction)stopVideo:(id)sender {
    [YNCSDKCamera stopVideoWithCompletion:^(NSError *error) {
        if (error) {
            NSLog(@"error description - domain: %@\n code: %ld\n message: %@\n",
                  error.domain, (long)error.code, error.userInfo[@"message"]);
            [StreamViewController showAlert:[NSString stringWithFormat:@"%@ error: %@\n",
                                             error.domain,
                                             error.userInfo[@"message"]] :self];
        } else {
            NSLog(@"Video Stopped");
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
