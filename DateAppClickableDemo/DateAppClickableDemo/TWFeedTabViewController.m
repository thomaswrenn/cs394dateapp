//
//  TWFirstViewController.m
//  DateAppClickableDemo
//
//  Created by Thomas Wrenn on 3/25/14.
//  Copyright (c) 2014 Thomas Wrenn. All rights reserved.
//

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1
#define kfeedItemsJSONURL [NSURL URLWithString: @"https://dl.dropboxusercontent.com/u/641088/DateApp/feedRESTcall.json"] //2

#import "TWFeedTabViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "TWFeedTopCell.h"
#import "TWCommentViewController.h"
#import "TWTapGestureRecognizer.h"
#import "UIImageView+WebCache.h"
#import "TWCellFrameData.h"

NSString *kFeedCellID = @"feedCellID";  // UICollectionViewCell storyboard id
BOOL isFirstCell = YES;
NSMutableArray* commentsToSendToNextView;
float totalCellYPast = 0;
NSInteger numOfCommentsToShow = 5;

NSMutableDictionary* commentsFrameDict;

@interface TWFeedTabViewController()
@property (strong, nonatomic) TWFeedTopCell *headerCell;
@end

@implementation TWFeedTabViewController
@synthesize headerCell;

# pragma mark - AMAttributedHighlightLabelDelegate
-(void)selectedMention:(NSString *)string {
    NSLog(@"mention: %@", string);
}
-(void)selectedHashtag:(NSString *)string {
    NSLog(@"hashtag: %@", string);
}
-(void)selectedLink:(NSString *)string {
    NSLog(@"link: %@", string);
}

-(void) viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.tableView reloadData];
}

- (void)viewDidLayoutSubviews{
    if( headerCell ){
        [self.view bringSubviewToFront:headerCell];
        NSArray* va = [[self.view superview] subviews];
        BOOL topViewExisted = NO;
        for( UIView* v in va ){
            if( [v isKindOfClass: [TWFeedTopCell class]] ){
                topViewExisted = YES;
            }
        }
// ???: Made the headers not work with my Parse code
//        if( !topViewExisted ){
//            [[self.view superview] insertSubview:headerCell aboveSubview:self.tableView];
//        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.feedDates = [[NSMutableArray alloc] init];
    
    commentsFrameDict = [[NSMutableDictionary alloc] init];
    
    headerCell = (TWFeedTopCell *)[self.tableView dequeueReusableCellWithIdentifier:@"TopCell"];
    
    [TWUtility getDatesWithCallback:^(NSArray *dates, NSError *error) {
        if (!error) {
            NSLog(@"Fetched dates without error");
            for (PFObject *date in dates) {
                TWFeedItemModel *feedItem = [[TWFeedItemModel alloc] initWithPFObject:date];
                [self.feedDates addObject: feedItem];
            }
        } else {
            NSLog(@"Date Fetch Unsuccessful");
        }
        [self.tableView reloadData];
    }];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark - Table view data source

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row){
        [self.view bringSubviewToFront:headerCell];
        NSArray* va = [[self.view superview] subviews];
        BOOL topViewExisted = NO;
        for( UIView* v in va ){
            if( [v isKindOfClass: [TWFeedTopCell class]] ){
                topViewExisted = YES;
            }
        }
        if( !topViewExisted ){
            [[self.view superview] insertSubview:headerCell aboveSubview:self.tableView];
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
    
    TWFeedItemModel *itemModel = [self.feedDates objectAtIndex: (indexPath.row/2)];
    
    [cell.commentsBlock setText:[TWUtility commentsBlockFromNSArray: itemModel.comments withAmount:numOfCommentsToShow]];
    
    float newHeight = [cell.commentsBlock sizeThatFits:CGSizeMake(cell.commentsBlock.frame.size.width, MAXFLOAT)].height;
        
    CGFloat bottomHeight = BOTTOM_CELL_HEIGHT - OLD_CELL_TEXTVIEW_HEIGHT + newHeight;
    [self addDataToCellDict: indexPath.row withHeight:bottomHeight];
    return bottomHeight;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.feedDates.count * 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWFeedItemModel *itemModel = [self.feedDates objectAtIndex: (indexPath.row/2)];
    
    if( isFirstCell ){
        isFirstCell = NO;
        
        headerCell = (TWFeedTopCell *)[tableView dequeueReusableCellWithIdentifier:@"TopCell"];

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

        PFObject* dateImage = itemModel.images[0];
        [dateImage fetchIfNeeded];
        [cell.topImage setImage:[TWUtility getUIImageWithPFObject:dateImage]];
        cell.topImage.contentMode = UIViewContentModeScaleAspectFit;
        
        cell.likeCount.text = [NSString stringWithFormat:@"%lu likes", (unsigned long)itemModel.likes.count];
        
        cell.commentsBlock.text = [TWUtility commentsBlockFromNSArray: itemModel.comments withAmount:numOfCommentsToShow];
        
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
    if( self.feedDates.count < 1 ){
        return;
    }
    
    NSIndexPath *firstVisibleIndexPath = [[self.tableView indexPathsForVisibleRows] objectAtIndex:0];
    UITableViewCell* other = [self.tableView cellForRowAtIndexPath:firstVisibleIndexPath];
    long index = 0;
    if( [other isKindOfClass: [TWFeedCell class]] ){
        index = ((TWFeedCell* )other).index;
    }
    else if( [other isKindOfClass: [TWFeedTopCell class] ]){
        index = ((TWFeedTopCell* )other).index;
    }
    
    TWFeedItemModel *itemModel = [self.feedDates objectAtIndex: index];
    
    
    [headerCell.userProfileImage setImage:itemModel.userProfileImage];
    
    headerCell.userProfileImage.layer.cornerRadius = 24.0;
    headerCell.userProfileImage.clipsToBounds = YES;
    [headerCell.username setText:itemModel.username];
    
    headerCell.timePosted.text = [[YLMoment momentWithDate: itemModel.timePosted] fromNow];
    headerCell.index = index;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if( self.feedDates.count < 1 ){
        return;
    }
    if( scrollView.contentOffset.y < 0 ){
        [[self.view superview] sendSubviewToBack: headerCell];
    }
    else{
        [[self.view superview] bringSubviewToFront: headerCell];
    }
    
    
    NSIndexPath *firstVisibleIndexPath = [[self.tableView indexPathsForVisibleRows] objectAtIndex:0];
    UITableViewCell* other = [self.tableView cellForRowAtIndexPath:firstVisibleIndexPath];
    
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
    
    /*
    NSLog(@"-----");
    NSLog(@"y: %f",scrollView.contentOffset.y);
    NSLog(@"total: %f",totalNow);
    NSLog(@"diff: %f",(totalNow - (int)scrollView.contentOffset.y));
    NSLog(@"-----");
    */
     
    if ( // touching other cell, moving other cell
            ((totalNow - (int)scrollView.contentOffset.y) <=  TOP_CELL_HEIGHT)
         && ((totalNow - (int)scrollView.contentOffset.y) >= 0)
         && (firstVisibleIndexPath.row % 2 == 1)
       ) {
        int pos = totalNow - (int)scrollView.contentOffset.y - TOP_CELL_HEIGHT;
        headerCell.frame = CGRectMake(0,pos,headerCell.frame.size.width,headerCell.frame.size.height);
        [self updateTopCell:scrollView];
    }
    else{
        headerCell.frame = CGRectMake(0,0,headerCell.frame.size.width,headerCell.frame.size.height);
        [self updateTopCell:scrollView];
        
    }
}

@end
