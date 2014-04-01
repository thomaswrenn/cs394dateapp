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

NSString *kFeedCellID = @"feedCellID";                          // UICollectionViewCell storyboard id

@interface TWFeedTabViewController ()

@end

@implementation TWFeedTabViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.feedDates = [[NSMutableArray alloc] init];
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL:
                        kfeedItemsJSONURL];
        [self performSelectorOnMainThread:@selector(fetchedData:)
                               withObject:data waitUntilDone:YES];
    });
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
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
{
    return self.feedDates.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TWFeedItemModel *itemModel = [self.feedDates objectAtIndex: indexPath.row];
    TWFeedCell *cell = [cv dequeueReusableCellWithReuseIdentifier:kFeedCellID forIndexPath:indexPath];
    
    // load the image for this cell
    NSData * imageData = [NSData dataWithContentsOfURL: [NSURL URLWithString: itemModel.imageURLs[0]]];
    cell.topImage.image = [UIImage imageWithData:imageData];
    
    imageData = [NSData dataWithContentsOfURL: [NSURL URLWithString: itemModel.userProfileImageURL]];
    cell.userProfileImage.image = [UIImage imageWithData:imageData];
    
    cell.username.text = itemModel.username;
    
    cell.timePosted.text = [[YLMoment momentWithDate: itemModel.timePosted] fromNow];
    cell.commentsBlock.text = [TWUtility commentsBlockFromNSArray: itemModel.comments];
    cell.locationsBlock.text = [TWUtility locationsFromNSArray: itemModel.locations];
    cell.likeCount.text = [NSString stringWithFormat:@"%lu likes", (unsigned long)itemModel.likes.count];
    
    return cell;
}

@end
