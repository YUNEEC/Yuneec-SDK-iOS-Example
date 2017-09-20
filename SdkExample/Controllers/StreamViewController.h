//
//  StreamViewController.h
//  Yuneec_SDK_iOS_Example
//
//  Created by Steven Hall on 9/18/17.
//  Copyright © 2017 yuneec. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RTSPPlayer;

@interface StreamViewController : UIViewController {
    IBOutlet UIImageView *videoStream;
    IBOutlet UILabel *label;
    IBOutlet UIButton *playButton;
    RTSPPlayer *video;
    float lastFrameTime;
}
    @property (nonatomic, retain) IBOutlet UIImageView *videoStream;
    @property (nonatomic, retain) IBOutlet UILabel *label;
    @property (nonatomic, retain) IBOutlet UIButton *playButton;
    @property (nonatomic, retain) RTSPPlayer *video;
    
- (IBAction)playButtonAction:(id)sender;
- (IBAction)showTime:(id)sender;
@end
