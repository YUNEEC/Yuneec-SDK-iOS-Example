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

NSString * url = nil;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)getMediaList:(id)sender {
    NSLog(@"get List");
    [YNCSDKCamera getMediaInfosWithCompletion:^(NSArray<YNCCameraMediaInfo *> *YNCCameraMediaInfos, NSError *error) {
        if (error) {
            NSLog(@"error description - domain: %@\n code: %ld\n message: %@\n",
                  error.domain, (long)error.code, error.userInfo[@"message"]);
            [CameraViewController showAlert:[NSString stringWithFormat:@"%@ error: %@\n",
                                             error.domain,
                                             error.userInfo[@"message"]] :self];
        } else {
            if(YNCCameraMediaInfos) {
                NSLog(@"Media Infos download successfull");
                NSLog(@"%ld", [YNCCameraMediaInfos count]);
                for(YNCCameraMediaInfo *mediaInfo in YNCCameraMediaInfos) {
                    NSLog(@"%@", mediaInfo.path );
                }
            }
            url = YNCCameraMediaInfos[0].path;
        }
    }];
}
- (IBAction)downloadMedia:(id)sender {
    NSLog(@"download media");
    NSArray *internalPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [internalPaths objectAtIndex:0]; //Get the docs directory
    NSLog(@"%@", documentsPath );
    NSLog(@"%@", url );
    [YNCSDKCamera getMedia:documentsPath WithUrl:url WithCompletion:^(int progress, NSError *error) {
        if (error) {
            NSLog(@"error description - domain: %@\n code: %ld\n message: %@\n",
                  error.domain, (long)error.code, error.userInfo[@"message"]);
            [CameraViewController showAlert:[NSString stringWithFormat:@"%@ error: %@\n",
                                             error.domain,
                                             error.userInfo[@"message"]] :self];
        } else {
            NSLog(@"Media Info download successfull");
            NSLog(@"%d", progress );
        }
    }];
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

- (IBAction)downoadIndex:(id)sender {
    [YNCSDKCamera getMediaInfosWithCompletion:^(NSMutableArray<YNCCameraMediaInfo *> *yncCameraMediaInfo, NSError *error) {
        if (error) {
            NSLog(@"error description - domain: %@\n code: %ld\n message: %@\n",
                  error.domain, (long)error.code, error.userInfo[@"message"]);
            [CameraViewController showAlert:[NSString stringWithFormat:@"%@ error: %@\n",
                                             error.domain,
                                             error.userInfo[@"message"]] :self];
        } else {
            if ([yncCameraMediaInfo count] > 0) {
                NSLog(@"Media index gotten, first entry: %@", yncCameraMediaInfo[0].path);
                // For now, we just stupidly download the first image in the list.
                [YNCSDKCamera getMedia: @"tmp/image.jpg"
                               WithUrl:yncCameraMediaInfo[0].path
                        WithCompletion: ^(int progress, NSError *serror){
                            NSLog(@"Received it: %d", progress);
                        }
                 ];
            }
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
