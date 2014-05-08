//
//  TWFirstViewController.m
//  DateAppClickableDemo
//
//  Created by Thomas Wrenn on 3/25/14.
//  Copyright (c) 2014 Thomas Wrenn. All rights reserved.
//

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1
#define kfeedItemsJSONURL [NSURL URLWithString: @"https://dl.dropboxusercontent.com/u/641088/DateApp/feedRESTcall.json"] //2

#import <YLMoment.h>
#import "TWUtility.h"
#import "TWFeedItemModel.h"
#import "TWFeedCell.h"
#import "TWFeedTabViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "TWFeedTopCell.h"
#import "TWCommentViewController.h"
#import "TWTapGestureRecognizer.h"
#import "UIImageView+WebCache.h"
#import "TWCellFrameData.h"

NSString *kFeedCellID = @"feedCellID";                          // UICollectionViewCell storyboard id
//BOOL canScrollHeader = false;
BOOL isFirstCell = true;
NSString *title = @"asdasdsda";
//TWFeedTopCell *topCell;
BOOL isFirstTimeAddingHeaderCell = YES;
NSMutableArray* commentsToSendToNextView;
BOOL isContentYNeg = NO;
float totalCellYPast = 0;
NSInteger numOfCommentsToShow = 5;

NSMutableDictionary* commentsFrameDict;

@interface TWFeedTabViewController()
@property (strong, nonatomic) TWFeedTopCell *topCell;
@end

@implementation TWFeedTabViewController
@synthesize topCell;


-(void) viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

-(void) viewDidAppear:(BOOL)animated{
    [self.tableView reloadData];
    
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.feedDates = [[NSMutableArray alloc] init];
    
    commentsFrameDict = [[NSMutableDictionary alloc] init];
    
    topCell = (TWFeedTopCell *)[self.tableView dequeueReusableCellWithIdentifier:@"TopCell"];
    
//    dispatch_async(kBgQueue, ^{
//        NSData* data = [NSData dataWithContentsOfURL:
//                        kfeedItemsJSONURL];
//        [self performSelectorOnMainThread:@selector(fetchedData:)
//                               withObject:data waitUntilDone:YES];
//    });

    
    NSString *imgTemp1 = @"http://2.bp.blogspot.com/-kIcv0j4joXk/UNjA-UtjuWI/AAAAAAAAAww/QLAtP5pe7IA/s1600/best-date-nights-san-diego.jpg";
    
    NSString *imgTemp2 = @"http://engineering.nyu.edu/files/imagecache/profile_full/pictures/picture-204.jpg";
    
    NSString *imgTemp3 = @"http://www.themartellexperience.com/wp-content/uploads/2010/08/Restaurant-for-Romantic-Date-in-Moncton-New-Brunswick-Canada.jpg";
    
    for (NSInteger i = 0; i < 10; i++) {
        TWFeedItemModel *itemModel = [[TWFeedItemModel alloc] init];
        
        // TODO Assign each thing to the proper thing
        NSString *name = [NSMutableString stringWithFormat:@"Jessica Wu %ld", (i+1)];
        [itemModel.username setString: name];
        [itemModel.userProfileImageURL setString:imgTemp2];
        itemModel.timePosted = [NSDate dateWithTimeIntervalSince1970:[[NSDate date] timeIntervalSince1970]];
        itemModel.imageURLs = [NSMutableArray arrayWithObjects:imgTemp1,imgTemp3, nil];
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
        
        NSArray *objects7 = [NSArray arrayWithObjects:@"Sam", @"I would love to go there too! Awesome Awesome Awesome Awesome",@"\n", nil];
        NSDictionary *dictionary7 = [NSDictionary dictionaryWithObjects:objects7
                                                                forKeys:keys];
        
        if( i == 2 || i == 3 ){
            itemModel.comments = [NSMutableArray arrayWithObjects:dictionary1, dictionary2, nil];
        }
        else{
            itemModel.comments = [NSMutableArray arrayWithObjects:dictionary1, dictionary2, dictionary3, dictionary4, dictionary5, dictionary6, dictionary7, nil];
        }
        itemModel.locations = [NSMutableArray arrayWithObjects:@"Brooklyn", @"NY", nil];
        itemModel.likes = [NSMutableArray arrayWithObjects:@"a",@"b",@"c",@"d", nil];

        
        [self.feedDates addObject: itemModel];
        
    }
    [self.tableView reloadData];
    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)fetchedData:(NSData *)responseData {
    // parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData
                          options:kNilOptions
                          error:&error];
    
    NSArray *jsonFeedItems = [json objectForKey:@"dates"];
    
    for (NSInteger i = 0; i < jsonFeedItems.count; i++) {
        NSDictionary *json = jsonFeedItems[i];
        TWFeedItemModel *itemModel = [[TWFeedItemModel alloc] init];
        
        // TODO Assign each thing to the proper thing
        itemModel.username = [json objectForKey:@"username"];
        itemModel.userProfileImageURL = [json objectForKey:@"userProfileImageURL"];
        itemModel.timePosted = [NSDate dateWithTimeIntervalSince1970:[[json objectForKey:@"timePosted"] doubleValue]];
        itemModel.imageURLs = [json objectForKey:@"images"];
        itemModel.comments = [json objectForKey:@"comments"];
        itemModel.locations = [json objectForKey:@"locations"];
        itemModel.likes = [json objectForKey:@"likes"];

        [self.feedDates addObject: itemModel];
        [self.tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void) commentBtnPressed: (TWTapGestureRecognizer *) sender{
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
        if( isFirstTimeAddingHeaderCell ){
            isFirstTimeAddingHeaderCell = false;
//            [self.view addSubview:topCell];
//            [self.view bringSubviewToFront:topCell];
            [[self.view superview] insertSubview:topCell aboveSubview:self.tableView];
            
        }
        [self.view bringSubviewToFront:topCell];
        NSArray* va = [[self.view superview] subviews];
        BOOL topViewExisted = NO;
        for( UIView* v in va ){
            if( [v isKindOfClass: [TWFeedTopCell class]] ){
                topViewExisted = YES;
            }
        }
        if( !topViewExisted ){
            [[self.view superview] insertSubview:topCell aboveSubview:self.tableView];
        }
    }
}

-(void) addDataToCellDict:(NSInteger) index withHeight:(CGFloat)height{
    TWCellFrameData* data = [commentsFrameDict objectForKey:[NSString stringWithFormat:@"%li", index]];
    if( data ){//existed
        data.height = height;
    }
    else{//doesnt exist
        CGFloat total = height;
        if (index > 0 ){
            TWCellFrameData* aData = [commentsFrameDict objectForKey:[NSString stringWithFormat:@"%li", index-1]];
            if( aData ){
                total += aData.total;
            }
        }
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
    
    
//    float oldHeight = cell.commentsBlock.frame.size.height;
//    NSLog(@"old cell height: %f",oldHeight);
    
    
    TWFeedItemModel *itemModel = [self.feedDates objectAtIndex: (indexPath.row/2)];
    
    [cell.commentsBlock setText:[TWUtility commentsBlockFromNSArray: itemModel.comments withAmount:numOfCommentsToShow]];
    
    CGFloat fixedWidth = cell.commentsBlock.frame.size.width;
    CGSize newSize = [cell.commentsBlock sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGRect newFrame = cell.commentsBlock.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    
    
    float newHeight = newFrame.size.height;
    
        
    CGFloat bottomHeight = BOTTOM_CELL_HEIGHT - OLD_CELL_TEXTVIEW_HEIGHT + newHeight;
    [self addDataToCellDict: indexPath.row withHeight:bottomHeight];
    return bottomHeight;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.feedDates.count * 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( self.feedDates.count < 1 ){//empty?
        return [tableView dequeueReusableCellWithIdentifier:@"TopCell"];
    }
    
    
    TWFeedItemModel *itemModel = [self.feedDates objectAtIndex: (indexPath.row/2)];
    
    if( isFirstCell ){
        isFirstCell = false;
        
        topCell = (TWFeedTopCell *)[tableView dequeueReusableCellWithIdentifier:@"TopCell"];

        [topCell.userProfileImage setImageWithURL:[NSURL URLWithString:itemModel.userProfileImageURL]];
        
        topCell.userProfileImage.layer.cornerRadius = 24.0;
        topCell.userProfileImage.clipsToBounds = YES;
        
        [topCell.username setText:itemModel.username];
        topCell.timePosted.text = [[YLMoment momentWithDate: itemModel.timePosted] fromNow];
        
        topCell.selectionStyle = UITableViewCellSelectionStyleBlue;
        topCell.index = (indexPath.row/2);
    }
    
    if(indexPath.row % 2 == 0 ){//top one
        
        TWFeedTopCell *cell = (TWFeedTopCell *)[tableView dequeueReusableCellWithIdentifier:@"TopCell"];

        [cell.userProfileImage setImageWithURL:[NSURL URLWithString:itemModel.userProfileImageURL]];
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

        [ cell.topImage setImageWithURL:[NSURL URLWithString:itemModel.imageURLs[0]]];
        cell.topImage.contentMode = UIViewContentModeScaleAspectFit;
        
        cell.likeCount.text = [NSString stringWithFormat:@"%lu likes", (unsigned long)itemModel.likes.count];
        
        
        cell.commentsBlock.text = [TWUtility commentsBlockFromNSArray: itemModel.comments withAmount:numOfCommentsToShow];
        CGFloat fixedWidth = cell.commentsBlock.frame.size.width;
        CGSize newSize = [cell.commentsBlock sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
        CGRect newFrame = cell.commentsBlock.frame;
        newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
        cell.commentsBlock.frame = newFrame;
        
        cell.heightConstraint.constant = newFrame.size.height;
        
//        NSLog(@"constraint: %f", newFrame.size.height);
        
        cell.locationsBlock.text = [TWUtility locationsFromNSArray: itemModel.locations];
        
        
        [cell.commentsBlock setUserInteractionEnabled:YES];
        TWTapGestureRecognizer *tgr = [[TWTapGestureRecognizer alloc] initWithTarget:self action:@selector(commentBtnPressed:)];
        tgr.commentsArray = itemModel.comments;
        [tgr setNumberOfTapsRequired:1];
        [cell.commentsBlock addGestureRecognizer:tgr];
        
        cell.index = (indexPath.row/2);
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }

}



-(BOOL) shouldScrollHeader:(UIScrollView *)scrollView{
    int minSizeDiff = 3;
    
    if ( scrollView.contentOffset.y == BOTTOM_CELL_HEIGHT ){
        return false;
    }
    else if( ((int)scrollView.contentOffset.y % (TOP_CELL_HEIGHT + BOTTOM_CELL_HEIGHT)) - BOTTOM_CELL_HEIGHT < minSizeDiff ){
        return false;
    }
    return true;
}

-(void) setTopCell{
    NSIndexPath *firstCell = [[self.tableView indexPathsForVisibleRows] objectAtIndex:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:firstCell];
    if([cell isKindOfClass:[TWFeedTopCell class]]){
        [topCell removeFromSuperview];
        
        TWFeedTopCell* feedCell = (TWFeedTopCell*) cell;
        
        
        topCell.userProfileImage.image = feedCell.userProfileImage.image;
        topCell.userProfileImage.layer.cornerRadius = 24.0;
        topCell.userProfileImage.clipsToBounds = YES;
        
        [topCell.username setText:feedCell.username.text];
        topCell.timePosted.text = feedCell.timePosted.text;
        topCell.index = feedCell.index;
        
        
        [[self.view superview] insertSubview:topCell aboveSubview:self.tableView];
//        topCell.frame = CGRectMake(0,0,topCell.frame.size.width,topCell.frame.size.height);
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
    
//    int index = (int)scrollView.contentOffset.y / (TOP_CELL_HEIGHT + BOTTOM_CELL_HEIGHT);

    TWFeedItemModel *itemModel = [self.feedDates objectAtIndex: index];
    
    
    [topCell.userProfileImage setImageWithURL:[NSURL URLWithString:itemModel.userProfileImageURL]];
    
    
    topCell.userProfileImage.layer.cornerRadius = 24.0;
    topCell.userProfileImage.clipsToBounds = YES;
    [topCell.username setText:itemModel.username];
    
    topCell.timePosted.text = [[YLMoment momentWithDate: itemModel.timePosted] fromNow];
    topCell.index = index;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if( self.feedDates.count < 1 ){
        return;
    }
    if( scrollView.contentOffset.y < 0 ){
        isContentYNeg = YES;
        [[self.view superview] sendSubviewToBack: topCell];
    }
    else{
        [[self.view superview] bringSubviewToFront: topCell];
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
    
    NSLog(@"-------------");
    NSLog(@"table index: %li", firstVisibleIndexPath.row);
    NSLog(@"index: %li", index);
    NSLog(@"scrollview y: %f", scrollView.contentOffset.y);
    NSLog(@"cell y: %f", other.frame.origin.y);
    NSLog(@"diff: %f", scrollView.contentOffset.y - other.frame.origin.y);
    NSLog(@"total y: %f", totalNow);
    NSLog(@"diff-total: %f", (totalNow - (int)scrollView.contentOffset.y));
    
    

    if( ((totalNow - (int)scrollView.contentOffset.y) <=  TOP_CELL_HEIGHT)
       && ((totalNow - (int)scrollView.contentOffset.y) >= 1)
       && firstVisibleIndexPath.row % 2 == 1){//touching other cell, moving other cell
        int pos = totalNow - (int)scrollView.contentOffset.y - TOP_CELL_HEIGHT;
        NSLog(@"top cell: %i", TOP_CELL_HEIGHT);
        NSLog(@"POS y: %i", pos);
        topCell.frame = CGRectMake(0,pos,topCell.frame.size.width,topCell.frame.size.height);
        
        [self updateTopCell:scrollView];
    }
    else{
        topCell.frame = CGRectMake(0,0,topCell.frame.size.width,topCell.frame.size.height);
        [self updateTopCell:scrollView];
        
    }
    
    
    NSLog(@"-------------");
    
//    if( ((int)scrollView.contentOffset.y % (TOP_CELL_HEIGHT + BOTTOM_CELL_HEIGHT)) < (BOTTOM_CELL_HEIGHT + TOP_CELL_HEIGHT) && ((int)scrollView.contentOffset.y % (TOP_CELL_HEIGHT + BOTTOM_CELL_HEIGHT)) >=  BOTTOM_CELL_HEIGHT){//touching other cell, moving other cell
//        int pos = (BOTTOM_CELL_HEIGHT) - (int)scrollView.contentOffset.y % (TOP_CELL_HEIGHT + BOTTOM_CELL_HEIGHT);
//        topCell.frame = CGRectMake(0,pos,topCell.frame.size.width,topCell.frame.size.height);
//        
//        [self updateTopCell:scrollView];
//    }
//    else if( ((int)scrollView.contentOffset.y % (TOP_CELL_HEIGHT + BOTTOM_CELL_HEIGHT)) == 0 ){
//        [self setTopCell];//replacing cell
//
//    }
//    else{
//        topCell.frame = CGRectMake(0,0,topCell.frame.size.width,topCell.frame.size.height);
//        [self updateTopCell:scrollView];
//
//    }
    
    
    return;
    
    


}
    



@end
