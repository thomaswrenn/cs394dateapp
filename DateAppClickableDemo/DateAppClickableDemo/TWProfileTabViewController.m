//
//  TWProfileTabViewController.m
//  DateAppClickableDemo
//
//  Created by Jessica Wu on 5/12/14.
//  Copyright (c) 2014 Thomas Wrenn. All rights reserved.
//

#import "TWProfileTabViewController.h"

#import <YLMoment.h>
#import "TWUtility.h"
#import "TWFeedItemModel.h"
#import "TWFeedCell.h"
#import "TWFeedTopCell.h"
#import "TWTapGestureRecognizer.h"
#import "UIImageView+WebCache.h"
#import "TWCellFrameData.h"
#import "TWCommentViewController.h"


NSMutableArray* commentsToSendToNextView;

NSMutableDictionary* commentsFrameDict;
CGRect segmentedControlFrame;
CGRect profileNameFrame;
CGRect profileImageFrame;
CGRect profileLocationFrame;
CGRect tableviewFrame;
CGRect mapViewFrame;



@interface TWProfileTabViewController ()
@property (weak, nonatomic) IBOutlet UITableView *listingTableView;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) NSMutableArray *listingArray;
@property (strong, nonatomic) IBOutlet UIImageView *profileImage;
@property (strong, nonatomic) IBOutlet UILabel *profileName;
@property (strong, nonatomic) IBOutlet UILabel *profileLocation;
//@property (strong, nonatomic) IBOutlet UIScrollView *myView;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (strong, nonatomic) TWFeedTopCell *headerCell;
@property (nonatomic) BOOL isFirstCell;


@end

@implementation TWProfileTabViewController
@synthesize listingArray,mapView,listingTableView,profileImage,profileLocation,profileName,tableview,headerCell,isFirstCell,segmentedControl;





- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void) viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [tableview reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    isFirstCell = YES;
    listingArray = [[NSMutableArray alloc] init];
    
    
    commentsFrameDict = [[NSMutableDictionary alloc] init];
    
    headerCell = (TWFeedTopCell *)[tableview dequeueReusableCellWithIdentifier:@"TopCell"];
    
    
    segmentedControlFrame = segmentedControl.frame;
    profileNameFrame = profileName.frame;
    profileImageFrame = profileImage.frame;
    profileLocationFrame = profileLocation.frame;
    tableviewFrame = tableview.frame;
    mapViewFrame = mapView.frame;
    
    self.listingArray = [[NSMutableArray alloc] init];
    [TWUtility getDatesWithCallback:^(NSArray *dates, NSError *error) {
        if (!error) {
            NSLog(@"Fetched dates without error");
            for (PFObject *date in dates) {
                TWFeedItemModel *feedItem = [[TWFeedItemModel alloc] initWithPFObject:date];
                [self.listingArray addObject: feedItem];
            }
        } else {
            NSLog(@"Date Fetch Unsuccessful");
        }
        [tableview reloadData];
    }];
    
    
//    NSString* profileImageURL = @"http://engineering.nyu.edu/files/imagecache/profile_full/pictures/picture-346.jpg";
    PFUser* loggedInUser = [PFUser currentUser];
    [profileName setText:[loggedInUser valueForKey:kTWPUserUsernameKey]];
//    [profileName setText:@"Evan Gallagher"];
    [profileImage setImage:[TWUtility getUIImageWithPFObject:[[loggedInUser valueForKey:kTWPUserUserProfileImageKey] fetchIfNeeded]]];
//    [profileImage setImageWithURL:[NSURL URLWithString:profileImageURL]];
    profileImage.layer.cornerRadius = 48.0;
    profileImage.clipsToBounds = YES;
    
//    NSMutableArray* locationArray = [NSMutableArray arrayWithObjects:@"Brooklyn", @"NY", nil];
    profileLocation.text = @"Brooklyn, NY"; // !!!: Hardcoded!
    
    
    
    /*
    //fake data
    
    NSString *imgTemp1 = @"http://2.bp.blogspot.com/-kIcv0j4joXk/UNjA-UtjuWI/AAAAAAAAAww/QLAtP5pe7IA/s1600/best-date-nights-san-diego.jpg";

    NSString *imgTemp3 = @"http://www.themartellexperience.com/wp-content/uploads/2010/08/Restaurant-for-Romantic-Date-in-Moncton-New-Brunswick-Canada.jpg";
    
    
    
    for (NSInteger i = 0; i < 6; i++) {
        TWFeedItemModel *itemModel = [[TWFeedItemModel alloc] init];
        
        // TODO Assign each thing to the proper thing
        NSString *name = @"Evan Gallagher";
        name = [NSString stringWithFormat:@"Evan Gallagher %li",(i+1)];
        [itemModel.username setString: name];
        [itemModel.userProfileImageURL setString:profileImageURL];
        itemModel.timePosted = [NSDate dateWithTimeIntervalSince1970:[[NSDate date] timeIntervalSince1970]];
        itemModel.imageURLs = [NSMutableArray arrayWithObjects:imgTemp3,imgTemp1, nil];
        NSArray *keys = [NSArray arrayWithObjects:@"user", @"text",@"\n", nil];
        NSArray *objects = [NSArray arrayWithObjects:@"Jessica", @"awesome date!",@"\n", nil];
        NSDictionary *dictionary1 = [NSDictionary dictionaryWithObjects:objects
                                                                forKeys:keys];
        
        NSArray *objects2 = [NSArray arrayWithObjects:@"Tom", @"Woah nice sunset :)",@"\n", nil];
        NSDictionary *dictionary2 = [NSDictionary dictionaryWithObjects:objects2
                                                                forKeys:keys];
        
        NSArray *objects3 = [NSArray arrayWithObjects:@"Sam", @"I would love to go there too!",@"\n", nil];
        NSDictionary *dictionary3 = [NSDictionary dictionaryWithObjects:objects3
                                                                forKeys:keys];
        
        NSArray *objects4 = [NSArray arrayWithObjects:@"Sam", @"I would love to go there too!",@"\n", nil];
        NSDictionary *dictionary4 = [NSDictionary dictionaryWithObjects:objects4
                                                                forKeys:keys];
        
        NSArray *objects5 = [NSArray arrayWithObjects:@"Sam", @"I would love to go there too!",@"\n", nil];
        NSDictionary *dictionary5 = [NSDictionary dictionaryWithObjects:objects5
                                                                forKeys:keys];
        
        NSArray *objects6 = [NSArray arrayWithObjects:@"Sam", @"I would love to go there too! Awesome Awesome Awesome Awesome",@"\n", nil];
        NSDictionary *dictionary6 = [NSDictionary dictionaryWithObjects:objects6
                                                                forKeys:keys];
        
        NSDictionary *dictionary7 = [NSDictionary dictionaryWithObjects:objects6
                                                                forKeys:keys];
        
        NSDictionary *dictionary8 = [NSDictionary dictionaryWithObjects:objects6
                                                                forKeys:keys];
        
        NSDictionary *dictionary9 = [NSDictionary dictionaryWithObjects:objects6
                                                                forKeys:keys];
        
        NSDictionary *dictionary10 = [NSDictionary dictionaryWithObjects:objects
                                                                 forKeys:keys];
        
        if( i == 2 || i == 3 ){
            itemModel.comments = [NSMutableArray arrayWithObjects:dictionary1, dictionary2, nil];
        }
        else{
            itemModel.comments = [NSMutableArray arrayWithObjects:dictionary1, dictionary2, dictionary3, dictionary4, dictionary5, dictionary6, dictionary7,dictionary8,dictionary9,dictionary10, nil];
        }
        itemModel.locations = [NSMutableArray arrayWithObjects:@"Brooklyn", @"NY", nil];
        itemModel.likes = [NSMutableArray arrayWithObjects:@"a",@"b",@"c",@"d", nil];
        
        [listingArray addObject: itemModel];
    }
    [tableview reloadData];
*/
    
    
    
}
- (IBAction)segmentedControl:(id)sender {
    UISegmentedControl *segmentedControl1 = (UISegmentedControl *)sender;
    if( [segmentedControl1 selectedSegmentIndex] == 0 ){//tableview
        [listingTableView setHidden:NO];
        [mapView setHidden:YES];
        [[tableview superview] bringSubviewToFront: headerCell];
    }
    else if( [segmentedControl1 selectedSegmentIndex] == 1 ){//map
        [listingTableView setHidden:YES];
        [mapView setHidden:NO];
        [[tableview superview] sendSubviewToBack: headerCell];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)prefersStatusBarHidden {
    return YES;
}

-(void) commentSectionPressed: (TWTapGestureRecognizer *) sender{
    commentsToSendToNextView = sender.commentsArray;
    [self performSegueWithIdentifier:@"commentSegue" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"commentSegue"]){
        TWCommentViewController *vc = [segue destinationViewController];
        vc.comments = commentsToSendToNextView;
        vc.hidesBottomBarWhenPushed = YES;
    }
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

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row){
//        [[tableview superview] bringSubviewToFront:headerCell];
        
        NSArray* va = [[tableview superview] subviews];
        BOOL topViewExisted = NO;
        for( UIView* v in va ){
            if( [v isKindOfClass: [TWFeedTopCell class]] ){
                topViewExisted = YES;
            }
        }
        if( !topViewExisted ){
            
            for (UIView *subview in [[tableview superview]subviews]) {
                if( [subview isKindOfClass: [TWFeedTopCell class]] ){
                    [subview removeFromSuperview];
                }
            }
            
            
            CGFloat svHeight = NAV_BAR_HEIGHT;
            
//            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, svHeight - TOP_CELL_HEIGHT, headerCell.frame.size.width, headerCell.frame.size.height)];
//            label.backgroundColor = [UIColor whiteColor];
//            
//            [self.view insertSubview:label atIndex:3];
            
//            [self.view insertSubview:headerCell belowSubview:segmentedControl];

            
            
            [[tableview superview] insertSubview:headerCell aboveSubview:tableview];
            
            
            headerCell.frame = CGRectMake(0,svHeight,headerCell.frame.size.width,headerCell.frame.size.height);
            
//            headerCell.backgroundColor = [UIColor blackColor];
            
        }
    }
}

-(void) addDataToCellDict:(NSInteger) index withHeight:(CGFloat)height{
    TWCellFrameData* data = [commentsFrameDict objectForKey:[NSString stringWithFormat:@"%li", index]];
    
    CGFloat total = height;
    if (index > 0 ){
        TWCellFrameData* aData = [commentsFrameDict objectForKey:[NSString stringWithFormat:@"%li", index-1]];
        if( aData ){
            total += aData.total;
        }
    }
    
    if( data ){//existed
        data.height = height;
        data.total = total;
    }
    else{//doesnt exist
        data = [[TWCellFrameData alloc] initWithHeight: height withPrevious:total];
        [commentsFrameDict setObject:data forKey:[NSString stringWithFormat:@"%li", index]];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2  == 0) {//top
        [self addDataToCellDict: indexPath.row withHeight:TOP_CELL_HEIGHT];
        return TOP_CELL_HEIGHT;
    }
    
    TWFeedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BottomCell"];
    
    TWFeedItemModel *itemModel = [listingArray objectAtIndex: (indexPath.row/2)];
    
    [cell.commentsBlock setText:[TWUtility commentsBlockFromNSArray: itemModel.comments withAmount:NUM_OF_COMMENTS_TO_SHOW]];
    
    float newHeight = [cell.commentsBlock sizeThatFits:CGSizeMake(cell.commentsBlock.frame.size.width, MAXFLOAT)].height;
    
    CGFloat bottomHeight = BOTTOM_CELL_HEIGHT - OLD_CELL_TEXTVIEW_HEIGHT + newHeight;
    [self addDataToCellDict: indexPath.row withHeight:bottomHeight];
    return bottomHeight;
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [listingArray count] * 2;// [array count]
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWFeedItemModel *itemModel = [listingArray objectAtIndex: (indexPath.row/2)];
    
    if( isFirstCell ){
        isFirstCell = NO;
        
        headerCell = (TWFeedTopCell *)[tableView dequeueReusableCellWithIdentifier:@"TopCell"];
        
//        [headerCell.userProfileImage setImageWithURL:[NSURL URLWithString:itemModel.userProfileImageURL]];
        [headerCell.userProfileImage setImage:itemModel.userProfileImage];
        
        headerCell.userProfileImage.layer.cornerRadius = 24.0;
        headerCell.userProfileImage.clipsToBounds = YES;
        
        [headerCell.username setText:itemModel.username];
        headerCell.timePosted.text = [[YLMoment momentWithDate: itemModel.timePosted] fromNow];
        
        headerCell.selectionStyle = UITableViewCellSelectionStyleBlue;
        headerCell.index = (indexPath.row/2);
    }
    
    if(indexPath.row % 2 == 0 ){//top one
        TWFeedTopCell *cell = (TWFeedTopCell *)[tableView dequeueReusableCellWithIdentifier:@"TopCell"];
        
//        [cell.userProfileImage setImageWithURL:[NSURL URLWithString:itemModel.userProfileImageURL]];
        [cell.userProfileImage setImage:itemModel.userProfileImage];
        cell.userProfileImage.layer.cornerRadius = 24.0;
        cell.userProfileImage.clipsToBounds = YES;
        
        [cell.username setText:itemModel.username];
        
        cell.timePosted.text = [[YLMoment momentWithDate: itemModel.timePosted] fromNow];
        
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        
        cell.index = (indexPath.row/2);
        
        return cell;
    }
    else{//bottom
        TWFeedCell *cell = (TWFeedCell *)[tableView dequeueReusableCellWithIdentifier:@"BottomCell"];
        
//        [ cell.topImage setImageWithURL:[NSURL URLWithString:itemModel.imageURLs[0]]];
        PFObject* dateImage = itemModel.images[0];
        [dateImage fetchIfNeeded];
        [cell.topImage setImage:[TWUtility getUIImageWithPFObject:dateImage]];
        cell.topImage.contentMode = UIViewContentModeScaleAspectFit;
        
        cell.likeCount.text = [NSString stringWithFormat:@"%lu likes", (unsigned long)itemModel.likes.count];
        
        cell.commentsBlock.text = [TWUtility commentsBlockFromNSArray: itemModel.comments withAmount:NUM_OF_COMMENTS_TO_SHOW];
        
        //        CGFloat fixedWidth = cell.commentsBlock.frame.size.width;
        //        CGSize newSize = [cell.commentsBlock sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
        //        CGRect newFrame = cell.commentsBlock.frame;
        //        newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
        //
        //        cell.heightConstraint.constant = newFrame.size.height;
        
        cell.heightConstraint.constant = [cell.commentsBlock sizeThatFits:CGSizeMake(cell.commentsBlock.frame.size.width, MAXFLOAT)].height;
        
        cell.locationsBlock.text = [TWUtility locationsFromNSArray: itemModel.locations];
        
        [cell.commentsBlock setUserInteractionEnabled:YES];
        TWTapGestureRecognizer *tgr = [[TWTapGestureRecognizer alloc] initWithTarget:self action:@selector(commentSectionPressed:)];
        tgr.commentsArray = itemModel.comments;
        [tgr setNumberOfTapsRequired:1];
        [cell.commentsBlock addGestureRecognizer:tgr];
        
        cell.index = (indexPath.row/2);
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}

-(void) updateTopCell: (UIScrollView *)scrollView{
    if( listingArray.count < 1 ){
        return;
    }
    
    NSIndexPath *firstVisibleIndexPath = [[tableview indexPathsForVisibleRows] objectAtIndex:0];
    UITableViewCell* other = [tableview cellForRowAtIndexPath:firstVisibleIndexPath];
    long index = 0;
    if( [other isKindOfClass: [TWFeedCell class]] ){
        index = ((TWFeedCell* )other).index;
    }
    else if( [other isKindOfClass: [TWFeedTopCell class] ]){
        index = ((TWFeedTopCell* )other).index;
    }
    
    TWFeedItemModel *itemModel = [listingArray objectAtIndex: index];
    
    
//    [headerCell.userProfileImage setImageWithURL:[NSURL URLWithString:itemModel.userProfileImageURL]];
    [headerCell.userProfileImage setImage:itemModel.userProfileImage];
    
    headerCell.userProfileImage.layer.cornerRadius = 24.0;
    headerCell.userProfileImage.clipsToBounds = YES;
    [headerCell.username setText:itemModel.username];
    
    headerCell.timePosted.text = [[YLMoment momentWithDate: itemModel.timePosted] fromNow];
    headerCell.index = index;
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSLog(@"tableview y: %f",tableview.frame.origin.y);

    NSLog(@"scroll y: %f",scrollView.contentOffset.y);

    if( scrollView.contentOffset.y <= 0 ){
        [profileImage setHidden:NO];
        [profileLocation setHidden:NO];
        [profileName setHidden:NO];
        [segmentedControl setHidden:NO];
        
        
        CGRect newFrame = segmentedControl.frame;
        newFrame.origin.y = segmentedControlFrame.origin.y;
        segmentedControl.frame = newFrame;
        
        newFrame = profileLocation.frame;
        newFrame.origin.y = profileLocationFrame.origin.y;
        profileLocation.frame = newFrame;
        
        newFrame = profileImage.frame;
        newFrame.origin.y = profileImageFrame.origin.y;
        profileImage.frame = newFrame;
        
        newFrame = profileName.frame;
        newFrame.origin.y = profileNameFrame.origin.y;
        profileName.frame = newFrame;
        
        
        newFrame = tableview.frame;
        newFrame.origin.y = tableviewFrame.origin.y - scrollView.contentOffset.y;
        newFrame.size.height = tableviewFrame.size.height + scrollView.contentOffset.y;
        tableview.frame = newFrame;
        
        int pos = NAV_BAR_HEIGHT - scrollView.contentOffset.y;
        headerCell.frame = CGRectMake(0,pos,headerCell.frame.size.width,headerCell.frame.size.height);
        return;
    }
    else if( scrollView.contentOffset.y < NAV_BAR_HEIGHT &&  scrollView.contentOffset.y > 0 ){
        [profileImage setHidden:NO];
        [profileLocation setHidden:NO];
        [profileName setHidden:NO];
        [segmentedControl setHidden:NO];
        
        
        CGRect newFrame = segmentedControl.frame;
        newFrame.origin.y = segmentedControlFrame.origin.y - scrollView.contentOffset.y;
        segmentedControl.frame = newFrame;
        
        newFrame = profileLocation.frame;
        newFrame.origin.y = profileLocationFrame.origin.y - scrollView.contentOffset.y;
        profileLocation.frame = newFrame;
        
        newFrame = profileImage.frame;
        newFrame.origin.y = profileImageFrame.origin.y - scrollView.contentOffset.y;
        profileImage.frame = newFrame;
        
        newFrame = profileName.frame;
        newFrame.origin.y = profileNameFrame.origin.y - scrollView.contentOffset.y;
        profileName.frame = newFrame;
        
        
        newFrame = tableview.frame;
        newFrame.origin.y = tableviewFrame.origin.y - scrollView.contentOffset.y;
        newFrame.size.height = tableviewFrame.size.height + scrollView.contentOffset.y;
        tableview.frame = newFrame;
        
        int pos = NAV_BAR_HEIGHT - scrollView.contentOffset.y;
        headerCell.frame = CGRectMake(0,pos,headerCell.frame.size.width,headerCell.frame.size.height);
        return;
    }
    else{
        
        [profileImage setHidden:YES];
        [profileLocation setHidden:YES];
        [profileName setHidden:YES];
        [segmentedControl setHidden:YES];
        
        CGRect newFrame = segmentedControl.frame;
        newFrame.origin.y = - segmentedControlFrame.origin.y;
        segmentedControl.frame = newFrame;
        
        newFrame = profileLocation.frame;
        newFrame.origin.y = - profileLocationFrame.origin.y;
        profileLocation.frame = newFrame;
        
        newFrame = profileImage.frame;
        newFrame.origin.y = - profileImageFrame.origin.y;
        profileImage.frame = newFrame;
        
        newFrame = profileName.frame;
        newFrame.origin.y = - profileNameFrame.origin.y;
        profileName.frame = newFrame;
        
        newFrame = tableview.frame;
        newFrame.origin.y = 0;
        newFrame.size.height = tableviewFrame.size.height + NAV_BAR_HEIGHT;
        tableview.frame = newFrame;
        
        int pos = 0;
        headerCell.frame = CGRectMake(0,pos,headerCell.frame.size.width,headerCell.frame.size.height);
    }
    
    
//    return ;
    
    
    if( listingArray.count < 1 ){
        return;
    }
    if( scrollView.contentOffset.y < 0 ){
        [[tableview superview] sendSubviewToBack: headerCell];
    }
    else{
        [[tableview superview] bringSubviewToFront: headerCell];
    }
    
    
    NSIndexPath *firstVisibleIndexPath = [[tableview indexPathsForVisibleRows] objectAtIndex:0];
    UITableViewCell* other = [tableview cellForRowAtIndexPath:firstVisibleIndexPath];
    
    long index = 0;
    if( [other isKindOfClass: [TWFeedCell class]] ){
        index = ((TWFeedCell* )other).index;
    }
    else if( [other isKindOfClass: [TWFeedTopCell class] ]){
        index = ((TWFeedTopCell* )other).index;
    }
    
    TWCellFrameData* aData = [commentsFrameDict objectForKey:[NSString stringWithFormat:@"%li", firstVisibleIndexPath.row]];
    CGFloat totalNow = 0;
    if( aData ){
        totalNow = aData.total;
    }
    
    NSLog(@"----");
    NSLog(@"scroll y: %f", scrollView.contentOffset.y);
    NSLog(@"total y: %f", totalNow);
    NSLog(@"diff y: %f", totalNow - (int)scrollView.contentOffset.y);
    NSLog(@"----");
    
    if( ((totalNow - (int)scrollView.contentOffset.y) <=  TOP_CELL_HEIGHT)
       && ((totalNow - (int)scrollView.contentOffset.y) >= 0)
       && firstVisibleIndexPath.row % 2 == 1){//touching other cell, moving other cell
        CGFloat svHeight = 0;
        int pos = totalNow - (int)scrollView.contentOffset.y - TOP_CELL_HEIGHT + svHeight;
        headerCell.frame = CGRectMake(0,pos,headerCell.frame.size.width,headerCell.frame.size.height);
        
        [self updateTopCell:scrollView];
    }
    else{
        CGFloat svHeight = 0;
        headerCell.frame = CGRectMake(0,svHeight,headerCell.frame.size.width,headerCell.frame.size.height);
        [self updateTopCell:scrollView];
        
    }
}

@end
