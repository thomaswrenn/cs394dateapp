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

NSString *kFeedCellID = @"feedCellID";                          // UICollectionViewCell storyboard id
//BOOL canScrollHeader = false;
BOOL isFirstCell = true;
NSString *title = @"asdasdsda";
//TWFeedTopCell *topCell;
BOOL isFirstTimeAddingHeaderCell = true;

@interface TWFeedTabViewController ()
@property (strong, nonatomic) TWFeedTopCell *topCell;
@end

@implementation TWFeedTabViewController
@synthesize topCell;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.feedDates = [[NSMutableArray alloc] init];
    
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
        
        itemModel.comments = [NSMutableArray arrayWithObjects:dictionary1, dictionary2, dictionary3, nil];
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

//# pragma mark - UICollectionViewDelegate/Datasource
//
//- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
//{
//    return self.feedDates.count;
//
//}
//
//- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
//    return 1;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    TWFeedItemModel *itemModel = [self.feedDates objectAtIndex: indexPath.row];
//    TWFeedCell *cell = [cv dequeueReusableCellWithReuseIdentifier:kFeedCellID forIndexPath:indexPath];
//    // load the image for this cell
//    NSData * imageData = [NSData dataWithContentsOfURL: [NSURL URLWithString: itemModel.imageURLs[0]]];
//    cell.topImage.image = [UIImage imageWithData:imageData];
////    cell.topImage.layer.cornerRadius = 7.0;
////    cell.topImage.clipsToBounds = YES;
//    
//    imageData = [NSData dataWithContentsOfURL: [NSURL URLWithString: itemModel.userProfileImageURL]];
//    cell.userProfileImage.image = [UIImage imageWithData:imageData];
//    cell.userProfileImage.layer.cornerRadius = 24.0;
//    cell.userProfileImage.clipsToBounds = YES;
//    
//
//    cell.timePosted.text = [[YLMoment momentWithDate: itemModel.timePosted] fromNow];
//    cell.commentsBlock.text = [TWUtility commentsBlockFromNSArray: itemModel.comments];
//    cell.locationsBlock.text = [TWUtility locationsFromNSArray: itemModel.locations];
//    cell.likeCount.text = [NSString stringWithFormat:@"%lu likes", (unsigned long)itemModel.likes.count];
//    return cell;
//}
//
//#pragma mark – UICollectionViewDelegateFlowLayout
//
//// 1
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return CGSizeMake(316, 487);
//}
//
//// 3
//- (UIEdgeInsets)collectionView:
//(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(20, 0, 60, 0);
//}


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
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if( indexPath.row == 0 ){
//        return 0;
//    }
    if (indexPath.row % 2  == 0) {//top
        return TOP_CELL_HEIGHT;
    }
    return BOTTOM_CELL_HEIGHT;
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
    TWFeedItemModel *itemModel = [self.feedDates objectAtIndex: (indexPath.row/2)];
    
    if( isFirstCell ){
        isFirstCell = false;
        
        topCell = (TWFeedTopCell *)[tableView dequeueReusableCellWithIdentifier:@"TopCell"];
        
        NSData * imageData = [NSData dataWithContentsOfURL: [NSURL URLWithString: itemModel.userProfileImageURL]];
        topCell.userProfileImage.image = [UIImage imageWithData:imageData];
        topCell.userProfileImage.layer.cornerRadius = 24.0;
        topCell.userProfileImage.clipsToBounds = YES;
        
        [topCell.username setText:itemModel.username];
        topCell.timePosted.text = [[YLMoment momentWithDate: itemModel.timePosted] fromNow];
        

        
    }
    
    
    
    if(indexPath.row % 2 == 0 ){//top one
        
        TWFeedTopCell *cell = (TWFeedTopCell *)[tableView dequeueReusableCellWithIdentifier:@"TopCell"];
        
        NSData * imageData = [NSData dataWithContentsOfURL: [NSURL URLWithString: itemModel.userProfileImageURL]];
        cell.userProfileImage.image = [UIImage imageWithData:imageData];
        cell.userProfileImage.layer.cornerRadius = 24.0;
        cell.userProfileImage.clipsToBounds = YES;
        [cell.username setText:itemModel.username];
        
        cell.timePosted.text = [[YLMoment momentWithDate: itemModel.timePosted] fromNow];
        

        return cell;
    }
    else{//bottom
        TWFeedCell *cell = (TWFeedCell *)[tableView dequeueReusableCellWithIdentifier:@"BottomCell"];
        NSData * imageData = [NSData dataWithContentsOfURL: [NSURL URLWithString: itemModel.imageURLs[0]]];
        cell.topImage.image = [UIImage imageWithData:imageData];
        cell.topImage.contentMode = UIViewContentModeScaleAspectFit;
        
        cell.likeCount.text = [NSString stringWithFormat:@"%lu likes", (unsigned long)itemModel.likes.count];
        cell.commentsBlock.text = [TWUtility commentsBlockFromNSArray: itemModel.comments];
        cell.locationsBlock.text = [TWUtility locationsFromNSArray: itemModel.locations];
        return cell;
    }

}



-(BOOL) shouldScrollHeader:(UIScrollView *)scrollView{
    int minSizeDiff = 3;
    
    NSLog(@"scrollView: %f", scrollView.contentOffset.y);
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
        topCell = (TWFeedTopCell *)[self.tableView dequeueReusableCellWithIdentifier:@"TopCell"];
        
        topCell.userProfileImage.image = feedCell.userProfileImage.image;
        topCell.userProfileImage.layer.cornerRadius = 24.0;
        topCell.userProfileImage.clipsToBounds = YES;
        
        [topCell.username setText:feedCell.username.text];
        topCell.timePosted.text = feedCell.timePosted.text;
        
        
        [[self.view superview] insertSubview:topCell aboveSubview:self.tableView];
//        topCell.frame = CGRectMake(0,0,topCell.frame.size.width,topCell.frame.size.height);
    }
}

-(void) updateTopCell: (UIScrollView *)scrollView forNextCell:(BOOL) nextCell{
    int index = (int)scrollView.contentOffset.y / (TOP_CELL_HEIGHT + BOTTOM_CELL_HEIGHT);
    if( nextCell ){
        index++;
    }
    
    TWFeedItemModel *itemModel = [self.feedDates objectAtIndex: index];
    
    
//    TWFeedTopCell *cell = (TWFeedTopCell *)[self.tableView dequeueReusableCellWithIdentifier:@"TopCell"];
    
    NSData * imageData = [NSData dataWithContentsOfURL: [NSURL URLWithString: itemModel.userProfileImageURL]];
    topCell.userProfileImage.image = [UIImage imageWithData:imageData];
    topCell.userProfileImage.layer.cornerRadius = 24.0;
    topCell.userProfileImage.clipsToBounds = YES;
    [topCell.username setText:itemModel.username];
    
    topCell.timePosted.text = [[YLMoment momentWithDate: itemModel.timePosted] fromNow];
//    topCell = cell;
}

-(void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"scrollView: %f", scrollView.contentOffset.y);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSIndexPath *firstCell = [[self.tableView indexPathsForVisibleRows] objectAtIndex:0];
//    UITableViewCell *headerCell = [self.tableView cellForRowAtIndexPath:firstCell];
    
    if( scrollView.contentOffset.y < 0 ){
//        [[self.view superview] insertSubview:topCell aboveSubview:self.tableView];
        [[self.view superview] sendSubviewToBack: topCell];
    }
    else{
        [[self.view superview] bringSubviewToFront: topCell];
    }
    [self.tableView beginUpdates];
    
    
//    NSLog(@"scrollView: %f", scrollView.contentOffset.y);
    NSLog(@"index at: %d", (int)scrollView.contentOffset.y / (TOP_CELL_HEIGHT + BOTTOM_CELL_HEIGHT));
    if( ((int)scrollView.contentOffset.y % (TOP_CELL_HEIGHT + BOTTOM_CELL_HEIGHT)) < (BOTTOM_CELL_HEIGHT + TOP_CELL_HEIGHT) && ((int)scrollView.contentOffset.y % (TOP_CELL_HEIGHT + BOTTOM_CELL_HEIGHT)) >=  BOTTOM_CELL_HEIGHT){
        
        NSLog(@"im touching it other");
        
        int pos = (BOTTOM_CELL_HEIGHT) - (int)scrollView.contentOffset.y % (TOP_CELL_HEIGHT + BOTTOM_CELL_HEIGHT);
        NSLog(@"my pos: %d", pos);
        topCell.frame = CGRectMake(0,pos,topCell.frame.size.width,topCell.frame.size.height);
        
        [self updateTopCell:scrollView forNextCell:NO];
    }
    else if( ((int)scrollView.contentOffset.y % (TOP_CELL_HEIGHT + BOTTOM_CELL_HEIGHT)) == 0 /*&& ((int)scrollView.contentOffset.y % (TOP_CELL_HEIGHT + BOTTOM_CELL_HEIGHT) >= 0 ) */){
        NSLog(@"im on it!!!!!!!!!!!");
        [self setTopCell];
//        [self updateTopCell:scrollView forNextCell:NO];

    }
    else{
        topCell.frame = CGRectMake(0,0,topCell.frame.size.width,topCell.frame.size.height);
        [self updateTopCell:scrollView forNextCell:NO];

    }
    [self.tableView endUpdates];
    return;
    
    


}
    


//- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return TOP_CELL_HEIGHT;
//}
//
//- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
////    topCell.backgroundColor = tableView.backgroundColor;
//    topCell.backgroundColor = [UIColor greenColor];
//    return topCell;
//}


@end
