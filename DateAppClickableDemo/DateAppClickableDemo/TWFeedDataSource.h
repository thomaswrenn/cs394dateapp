//
//  TWFeedDataSource.h
//  DateAppClickableDemo
//
//  Created by Thomas Wrenn on 4/28/14.
//  Copyright (c) 2014 Thomas Wrenn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWFeedDataSource : NSObject <UICollectionViewDataSource>

// Number of Items

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;

// Views

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath;

@end
