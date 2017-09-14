//
//  OffboardViewController.m
//  Yuneec_SDK_iOSExample
//
//  Created by Steven Hall on 9/13/17.
//  Copyright © 2017 yuneec. All rights reserved.
//

#import "OffboardViewController.h"
#import <Yuneec_SDK_iOS/Yuneec_SDK_iOS.h>

#define kLeftThumbOriginCenter @"leftThumbOriginCenter"
#define kRightThumbOriginCenter @"rightThumbOriginCenter"
#define kBodyLeftThumbOriginCenter @"bodyLeftThumbOriginCenter"
#define kBodyRightThumbOriginCenter @"bodyRightThumbOriginCenter"
#define kStickRadius 35.0
#define kMaxVelMS 5.0 // max velocity in m/s to use

typedef NS_ENUM(NSInteger, OffboardMode) {
    OFFBOARD_MODE_NED = 0,
    OFFBOARD_MODE_BODY = 1
};

@interface OffboardViewController ()

@property (nonatomic, assign) CGPoint leftThumbOriginCenter;
@property (nonatomic, assign) CGPoint rightThumbOriginCenter;
@property (nonatomic, assign) CGPoint bodyLeftThumbOriginCenter;
@property (nonatomic, assign) CGPoint bodyRightThumbOriginCenter;

@property (weak, nonatomic) IBOutlet UILabel *label_north;
@property (weak, nonatomic) IBOutlet UILabel *label_east;
@property (weak, nonatomic) IBOutlet UILabel *label_up;
@property (weak, nonatomic) IBOutlet UILabel *label_yaw;

@property (weak, nonatomic) UISegmentedControl* offboardMode;

- (IBAction)leftVirtualStickAction:(UIPanGestureRecognizer *)sender;
- (IBAction)rightVirtualStickAction:(UIPanGestureRecognizer *)sender;

+ (void)showAlert:(NSString *)message :(UIViewController *)viewController;

@end


@implementation OffboardViewController
{
    bool _running;
    float _north_m_s;
    float _east_m_s;
    float _down_m_s;
    float _yaw_deg;
    float _forward_m_s;
    float _right_m_s;
    float _yawspeed_deg_s;
    float _last_translation_x;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.offboardMode.selectedSegmentIndex = OFFBOARD_MODE_NED;
    
    _running = false;
    
    _north_m_s = 0.0f;
    _east_m_s = 0.0f;
    _down_m_s = 0.0f;
    _yaw_deg = 0.0f;
    
    _forward_m_s = 0.0f;
    _right_m_s = 0.0f;
    _yawspeed_deg_s = 0.0f;
    _last_translation_x = 0.0f;
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kLeftThumbOriginCenter];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kRightThumbOriginCenter];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kBodyLeftThumbOriginCenter];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kBodyRightThumbOriginCenter];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)start:(id)sender {
    // We need to continuously send setpoints, otherwise we're not allowed into offboard mode.
    if (!_running) {
        _running = true;
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            while (_running) {
                if (_offboardMode.selectedSegmentIndex == OFFBOARD_MODE_NED) {
                    [YNCSDKOffboard setVelocityNEDYawWithVelocityNorth:_north_m_s
                                                      withVelocityEast:_east_m_s
                                                      withVelocityDown:_down_m_s
                                                               withYaw:_yaw_deg];
                    
                } else if (_offboardMode.selectedSegmentIndex == OFFBOARD_MODE_BODY) {
                    [YNCSDKOffboard setVelocityBodyYawspeedWithVelocityForward:_forward_m_s
                                                             withVelocityRight:_right_m_s
                                                              withVelocityDown:_down_m_s
                                                                 witchYawspeed:_yawspeed_deg_s];
                    
                }
                
                // Send setpoints at around 10 Hz for now.
                usleep(100000);
            }
        });
    }
    [YNCSDKOffboard startWithCompletion:^(NSError *error) {
        if (error) {
            NSLog(@"error description - domain: %@\n code: %ld\n message: %@\n",
                  error.domain, (long)error.code, error.userInfo[@"message"]);
            [OffboardViewController showAlert:[NSString stringWithFormat:@"%@ error: %@\n",
                            error.domain, error.userInfo[@"message"]] :self];
        }
    }];
}

- (IBAction)stop:(id)sender {
    [YNCSDKOffboard stopWithCompletion:^(NSError *error) {
        if (error) {
            NSLog(@"error description - domain: %@\n code: %ld\n message: %@\n",
                  error.domain, (long)error.code, error.userInfo[@"message"]);
            [OffboardViewController showAlert:[NSString stringWithFormat:@"%@ error: %@\n",
                            error.domain, error.userInfo[@"message"]] :self];
        }
    }];
    _running = false;
    
}

- (IBAction)leftVirtualStickAction:(UIPanGestureRecognizer *)sender {
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kLeftThumbOriginCenter]) {
        self.leftThumbOriginCenter = sender.view.center;
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kLeftThumbOriginCenter];
    }
    
    [sender.view.superview bringSubviewToFront:sender.view];
    CGPoint translation = [sender translationInView:self.view];
    if (translation.x < kStickRadius &&
        translation.y < kStickRadius &&
        translation.x > -kStickRadius &&
        translation.y > -kStickRadius) {
        if (_offboardMode.selectedSegmentIndex == OFFBOARD_MODE_NED) {
            _north_m_s = -translation.y / kStickRadius * kMaxVelMS;
            _east_m_s = translation.x / kStickRadius * kMaxVelMS;
        } else if (_offboardMode.selectedSegmentIndex == OFFBOARD_MODE_BODY) {
            _forward_m_s = -translation.y / kStickRadius * kMaxVelMS;
            _right_m_s = translation.x / kStickRadius * kMaxVelMS;
        }
        sender.view.center = CGPointMake(self.leftThumbOriginCenter.x + translation.x,
                                         self.leftThumbOriginCenter.y + translation.y);
    }
    if (sender.state == UIGestureRecognizerStateEnded) {
        sender.view.center = self.leftThumbOriginCenter;
        if (_offboardMode.selectedSegmentIndex == OFFBOARD_MODE_NED) {
            _north_m_s = 0.0;
            _east_m_s = 0.0;
        } else if (_offboardMode.selectedSegmentIndex == OFFBOARD_MODE_BODY) {
            _forward_m_s = 0.0;
            _right_m_s = 0.0;
        }
    }
    if (_offboardMode.selectedSegmentIndex == OFFBOARD_MODE_BODY) {
        self.label_north.text = [NSString stringWithFormat:@"Forward:\n%.2f m/s", _forward_m_s];
        self.label_east.text = [NSString stringWithFormat:@"Right:\n%.2f m/s", _right_m_s];
    } else if (_offboardMode.selectedSegmentIndex == OFFBOARD_MODE_NED) {
        self.label_north.text = [NSString stringWithFormat:@"North:\n%.2f m/s", _north_m_s];
        self.label_east.text = [NSString stringWithFormat:@"East:\n%.2f m/s", _east_m_s];
    }
}

- (IBAction)rightVirtualStickAction:(UIPanGestureRecognizer *)sender {
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kRightThumbOriginCenter]) {
        self.rightThumbOriginCenter = sender.view.center;
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kRightThumbOriginCenter];
    }
    [sender.view.superview bringSubviewToFront:sender.view];
    CGPoint translation = [sender translationInView:self.view];
    if (translation.x < kStickRadius &&
        translation.y < kStickRadius &&
        translation.x > -kStickRadius &&
        translation.y > -kStickRadius) {
        if (_offboardMode.selectedSegmentIndex == OFFBOARD_MODE_NED) {
            _down_m_s = translation.y / kStickRadius * kMaxVelMS;
            // We want to map the translation to around -180 deg to 180 deg.
            _yaw_deg = translation.x / kStickRadius * 180.0f;
            _last_translation_x = translation.x;
        } else if (_offboardMode.selectedSegmentIndex == OFFBOARD_MODE_BODY) {
            _down_m_s = translation.y / kStickRadius * kMaxVelMS;
            
            // We want to map it to around 60 deg/s.
            _yawspeed_deg_s = translation.x / kStickRadius * 60.0f;
        }
        
        sender.view.center = CGPointMake(self.rightThumbOriginCenter.x + translation.x,
                                         self.rightThumbOriginCenter.y + translation.y);
    }
    if (sender.state == UIGestureRecognizerStateEnded) {
        if (_offboardMode.selectedSegmentIndex == OFFBOARD_MODE_NED) {
            _down_m_s = 0.0;
            
            // The yaw angle stays, so we don't reset it.
            sender.view.center = CGPointMake(self.rightThumbOriginCenter.x + _last_translation_x,
                                             self.rightThumbOriginCenter.y);
        } else if (_offboardMode.selectedSegmentIndex == OFFBOARD_MODE_BODY) {
            sender.view.center = self.rightThumbOriginCenter;
            _down_m_s = 0.0;
            _yawspeed_deg_s = 0.0;
        }
    }
    
    self.label_up.text = [NSString stringWithFormat:@"Up:\n%.2f m/s", -_down_m_s];
    
    if (_offboardMode.selectedSegmentIndex == OFFBOARD_MODE_NED) {
        self.label_yaw.text = [NSString stringWithFormat:@"Yaw:\n%.2f deg", _yaw_deg];
    } else if (_offboardMode.selectedSegmentIndex == OFFBOARD_MODE_BODY) {
        self.label_yaw.text = [NSString stringWithFormat:@"Yaw Speed:\n%.2f deg/s", _yawspeed_deg_s];
    }
}

+ (void)showAlert:(NSString *)message :(UIViewController *)viewController {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil ]];
    [viewController presentViewController:alert animated:YES completion:nil];
}

@end
