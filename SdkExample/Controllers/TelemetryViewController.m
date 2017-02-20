/** @brief TelemetryViewController  implementation file */


#import "TelemetryViewController.h"
#import "TelemetryEntries.h"


@implementation TelemetryViewController

{
    TelemetryEntries *_telemetry_entries;
    NSTimer *_timer;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _telemetry_entries = [[TelemetryEntries alloc] init];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1f
                                              target:self
                                            selector:@selector(updateView)
                                            userInfo:nil
                                             repeats:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_telemetry_entries.entries count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TelemetryCell"];
    
    if (_telemetry_entries.entries.count > 0) {
        TelemetryEntry *entry = [_telemetry_entries.entries objectAtIndex:indexPath.row];
        if (entry) {
            cell.textLabel.text = entry.value;
            cell.detailTextLabel.text = entry.property;
        }
    }

    return cell;
}

- (void)updateView {
        [self.tableView reloadData];
}

@end
