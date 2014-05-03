//
//  TWFirstViewController.h
//  DateAppClickableDemo
//
//  Created by Thomas Wrenn on 3/25/14.
//  Copyright (c) 2014 Thomas Wrenn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWFeedTabViewController : UITableViewController

@property(nonatomic, weak) IBOutlet UICollectionView *feedCollectionView;

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
