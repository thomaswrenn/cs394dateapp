//
//  TWFirstViewController.h
//  DateAppClickableDemo
//
//  Created by Thomas Wrenn on 3/25/14.
//  Copyright (c) 2014 Thomas Wrenn. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <YLMoment.h>
#import "TWFeedItemModel.h"
#import "TWFeedCell.h"
#import <QuartzCore/QuartzCore.h>
#import "TWFeedTopCell.h"
#import "TWCommentViewController.h"
#import "TWTapGestureRecognizer.h"
#import "UIImageView+WebCache.h"
#import "TWCellFrameData.h"

#define TOP_CELL_HEIGHT 68
#define BOTTOM_CELL_HEIGHT 335
#define OLD_CELL_TEXTVIEW_HEIGHT 83

@interface TWFeedTabViewController : UITableViewController

//@property(nonatomic, weak) IBOutlet UICollectionView *feedCollectionView;

@property (strong, nonatomic) NSMutableArray *feedDates;



//- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
//
//- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView;
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
//
//- (UIEdgeInsets)collectionView:
//(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;

@end
