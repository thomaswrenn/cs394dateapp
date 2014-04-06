//
//  TWProfileTabViewController.m
//  DateAppClickableDemo
//
//  Created by Thomas Wrenn on 3/31/14.
//  Copyright (c) 2014 Thomas Wrenn. All rights reserved.
//

#import "TWProfileTabViewController.h"

@interface TWProfileTabViewController ()
@property (weak, nonatomic) IBOutlet UITableView *listingTableView;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) NSMutableArray *listingArray;

@end

@implementation TWProfileTabViewController
@synthesize listingArray,mapView,listingTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    listingArray = [[NSMutableArray alloc] init];
    
}
- (IBAction)segmentedControl:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    if( [segmentedControl selectedSegmentIndex] == 0 ){//tableview
        [listingTableView setHidden:NO];
        [mapView setHidden:YES];
    }
    else if( [segmentedControl selectedSegmentIndex] == 1 ){//map
        [listingTableView setHidden:YES];
        [mapView setHidden:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [listingArray count];// [array count]
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"ListingItemCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];

    return cell;
}


@end
