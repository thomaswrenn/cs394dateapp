//
//  TWFirstViewController.h
//  DateAppClickableDemo
//
//  Created by Thomas Wrenn on 3/25/14.
//  Copyright (c) 2014 Thomas Wrenn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWFeedTabViewController : UIViewController

@property (strong, nonatomic) NSMutableArray *feedDates;


- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;

@end
