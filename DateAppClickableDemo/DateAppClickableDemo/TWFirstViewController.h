//
//  TWFirstViewController.h
//  DateAppClickableDemo
//
//  Created by Thomas Wrenn on 3/25/14.
//  Copyright (c) 2014 Thomas Wrenn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWFirstViewController : UIViewController

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath;

@end
