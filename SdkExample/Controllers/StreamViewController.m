//
//  StreamViewController.m
//  Yuneec_SDK_iOS_Example
//
//  Created by Steven Hall on 9/18/17.
//  Copyright © 2017 yuneec. All rights reserved.
//

#import "StreamViewController.h"
#import "RTSPPlayer.h"
#import "Utilities.h"





@interface StreamViewController ()
    @property (nonatomic, retain) NSTimer *nextFrameTimer;

@end

@implementation StreamViewController
    @synthesize videoStream, label, playButton, video;
    @synthesize nextFrameTimer = _nextFrameTimer;
    
    

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//    {
//        if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
//            //http://www.wowza.com/_h264/BigBuckBunny_115k.mov
//            //rtsp://media1.law.harvard.edu/Media/policy_a/2012/02/02_unger.mov
//            //rtsp://streaming.parliament.act.gov.au/medium
//            
//            video = [[RTSPPlayer alloc] initWithVideo:@"rtsp://192.168.42.1/live" usesTcp:NO];
//            video.outputWidth = 426;
//            video.outputHeight = 320;
//            
//            NSLog(@"video duration: %f",video.duration);
//            NSLog(@"video size: %d x %d", video.sourceWidth, video.sourceHeight);
//        }
//        
//        return self;
//    }
//    
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    video = [[RTSPPlayer alloc] initWithVideo:@"rtsp://192.168.42.1/live" usesTcp:NO];
    video.outputWidth = 1920;
    video.outputHeight = 1080;
    [videoStream setContentMode:UIViewContentModeScaleAspectFit];
    self.nextFrameTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/30
                                                           target:self
                                                         selector:@selector(displayNextFrame:)
                                                         userInfo:nil
                                                          repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)playButtonAction:(id)sender {
    [playButton setEnabled:NO];
    lastFrameTime = -1;
    
    // seek to 0.0 seconds
    [video seekTime:0.0];
    
    [_nextFrameTimer invalidate];
    self.nextFrameTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/30
                                                           target:self
                                                         selector:@selector(displayNextFrame:)
                                                         userInfo:nil
                                                          repeats:YES];
}
- (IBAction)showTime:(id)sender
    {
        NSLog(@"current time: %f s", video.currentTime);
    }
    
#define LERP(A,B,C) ((A)*(1.0-C)+(B)*C)
-(void)displayNextFrame:(NSTimer *)timer
    {
        NSTimeInterval startTime = [NSDate timeIntervalSinceReferenceDate];
        if (![video stepFrame]) {
            [timer invalidate];
            [video closeAudio];
            return;
        }
        videoStream.image = video.currentImage;
        float frameTime = 1.0/([NSDate timeIntervalSinceReferenceDate]-startTime);
        if (lastFrameTime<0) {
            lastFrameTime = frameTime;
        } else {
            lastFrameTime = LERP(frameTime, lastFrameTime, 0.8);
        }
     
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
