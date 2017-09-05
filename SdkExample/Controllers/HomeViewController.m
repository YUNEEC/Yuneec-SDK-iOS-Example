//
//  HomeViewController.m
//  Yuneec_SDK_iOS_Example
//
//  Created by Steven Hall on 8/30/17.
//  Copyright © 2017 yuneec. All rights reserved.
//

#import "HomeViewController.h"
#import "TelemetryEntries.h"
#import <Yuneec_SDK_iOS/Yuneec_SDK_iOS.h>



@implementation HomeViewController
{
    TelemetryEntries *_telemetry_entries;
    NSTimer * _timer;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    _telemetry_entries = [[TelemetryEntries alloc] init];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1f
                                              target:self
                                            selector:@selector(updateView:)
                                            userInfo:nil
                                             repeats:YES];
    _TelemetryView.hidden = YES;
    _sdkVersion.text = [NSString stringWithFormat:@"YUNEEC SDK VERSION: %.2f", Yuneec_SDK_iOSVersionNumber];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (IBAction)toggleTelemetry:(id)sender {
    _TelemetryView.hidden = NO;
}
- (IBAction)closeTelemetry:(id)sender {
    _TelemetryView.hidden = YES;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_telemetry_entries.entries count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *TelemetryCell = @"TelemetryCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TelemetryCell];
       
    if (_telemetry_entries.entries.count > 0) {
        TelemetryEntry *entry = [_telemetry_entries.entries objectAtIndex:indexPath.row];
        if (entry) {
            cell.textLabel.text = entry.value;
            cell.detailTextLabel.text = entry.property;
        }
    }
    
    return cell;
}


-(void)updateView: (NSTimer *) _timer {
    TelemetryEntry *entry = [_telemetry_entries.entries objectAtIndex:9];
    if (entry) {
        _connectionStatus.text = entry.value;
    } else {
        _connectionStatus.text = entry.value;
    }
    [self.tableView reloadData];
}




@end
