//
//  TWFeedDataSource.m
//  DateAppClickableDemo
//
//  Created by Thomas Wrenn on 4/28/14.
//  Copyright (c) 2014 Thomas Wrenn. All rights reserved.
//

#import "TWFeedDataSource.h"

@implementation TWFeedDataSource

// Number of Items

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 0;
}

// Views

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return NULL;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    return NULL;
}

@end
