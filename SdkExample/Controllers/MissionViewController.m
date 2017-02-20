//
//  MissionViewController.m
//  Yuneec_SDK_iOSExample
//
//  Created by Julian Oes on 16/02/17.
//  Copyright © 2017 yuneec. All rights reserved.
//

#import "MissionViewController.h"
#import "ExampleMission.h"
#import <Yuneec_SDK_iOS/Yuneec_SDK_iOS.h>

@interface MissionViewController ()

+ (void)showAlert:(NSString *)message :(UIViewController *)viewController;

@end

@implementation MissionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)sendMission:(id)sender {
    
    ExampleMission *exampleMission = [[ExampleMission alloc] init];
    
    [YNCSDKMission sendMissionWithMissionItems:exampleMission.missionItems
                                withCompletion:^(NSError *error) {
        if (error) {
            NSLog(@"error description - domain: %@\n code: %ld\n message: %@\n",
                  error.domain, (long)error.code, error.userInfo[@"message"]);
            [MissionViewController showAlert:[NSString stringWithFormat:@"%@ error: %@\n",
                                              error.domain,
                                              error.userInfo[@"message"]] :self];
        }
    }];
}

- (IBAction)startMission:(id)sender {
    [YNCSDKMission startMissionWithCompletion:^(NSError *error) {
        if (error) {
            NSLog(@"error description - domain: %@\n code: %ld\n message: %@\n",
                  error.domain, (long)error.code, error.userInfo[@"message"]);
            [MissionViewController showAlert:[NSString stringWithFormat:@"%@ error: %@\n",
                                              error.domain,
                                              error.userInfo[@"message"]] :self];
        }
    }];
}

- (IBAction)pauseMission:(id)sender {
    [YNCSDKMission pauseMissionWithCompletion:^(NSError *error) {
        if (error) {
            NSLog(@"error description - domain: %@\n code: %ld\n message: %@\n",
                  error.domain, (long)error.code, error.userInfo[@"message"]);
            [MissionViewController showAlert:[NSString stringWithFormat:@"%@ error: %@\n",
                                              error.domain,
                                              error.userInfo[@"message"]] :self];
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
