//
//  ActionsViewController.m
//  SdkExample
//
//  Created by Steven Hall on 9/13/17.
//  Copyright © 2017 yuneec. All rights reserved.
//


#import "ActionsViewController.h"
#import <Yuneec_SDK_iOS/Yuneec_SDK_iOS.h>


@interface ActionsViewController ()

+ (void)showAlert:(NSString *)message :(UIViewController *)viewController;

@end

@implementation ActionsViewController

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

- (IBAction)armPressed:(id)sender {
    [YNCAction armWithCompletion:^(NSError *error) {
        if (error) {
            NSLog(@"error description - domain: %@\n code: %ld\n message: %@\n",
                  error.domain, (long)error.code, error.userInfo[@"message"]);
            [ActionsViewController showAlert:[NSString stringWithFormat:@"%@ error: %@\n",
                                              error.domain,
                                              error.userInfo[@"message"]] :self];
        }
    }];
}

- (IBAction)takeoffPressed:(id)sender {
    [YNCAction takeoffWithCompletion:^(NSError *error) {
        if (error) {
            NSLog(@"error description - domain: %@\n code: %ld\n message: %@\n",
                  error.domain, (long)error.code, error.userInfo[@"message"]);
            [ActionsViewController showAlert:[NSString stringWithFormat:@"%@ error: %@\n",
                                              error.domain,
                                              error.userInfo[@"message"]] :self];
        }
    }];
}

- (IBAction)landPressed:(id)sender {
    [YNCAction landWithCompletion:^(NSError *error) {
        if (error) {
            NSLog(@"error description - domain: %@\n code: %ld\n message: %@\n",
                  error.domain, (long)error.code, error.userInfo[@"message"]);
            [ActionsViewController showAlert:[NSString stringWithFormat:@"%@ error: %@\n",
                                              error.domain,
                                              error.userInfo[@"message"]] :self];
        }
    }];
}


- (IBAction)disarmPressed:(id)sender {
    [YNCAction disarmWithCompletion:^(NSError *error) {
        if (error) {
            NSLog(@"error description - domain: %@\n code: %ld\n message: %@\n",
                  error.domain, (long)error.code, error.userInfo[@"message"]);
            [ActionsViewController showAlert:[NSString stringWithFormat:@"%@ error: %@\n",
                                              error.domain,
                                              error.userInfo[@"message"]] :self];
        }
    }];
}


- (IBAction)killPressed:(id)sender {
    [YNCAction killWithCompletion:^(NSError *error) {
        if (error) {
            NSLog(@"error description - domain: %@\n code: %ld\n message: %@\n",
                  error.domain, (long)error.code, error.userInfo[@"message"]);
            [ActionsViewController showAlert:[NSString stringWithFormat:@"%@ error: %@\n",
                                              error.domain,
                                              error.userInfo[@"message"]] :self];
        }
    }];
}

- (IBAction)returnToLandPressed:(id)sender {
    [YNCAction doReturnToLaunchWithCompletion:^(NSError *error) {
        if (error) {
            NSLog(@"error description - domain: %@\n code: %ld\n message: %@\n",
                  error.domain, (long)error.code, error.userInfo[@"message"]);
            [ActionsViewController showAlert:[NSString stringWithFormat:@"%@ error: %@\n",
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
