//
//  TWFirstViewController.m
//  DateAppClickableDemo
//
//  Created by Thomas Wrenn on 3/25/14.
//  Copyright (c) 2014 Thomas Wrenn. All rights reserved.
//

#import "TWFirstViewController.h"

@interface TWFirstViewController ()

@end

@implementation TWFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end
