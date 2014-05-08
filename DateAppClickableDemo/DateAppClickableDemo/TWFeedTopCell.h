//
//  TWFeedTopCell.h
//  DateAppClickableDemo
//
//  Created by Jessica Wu on 5/2/14.
//  Copyright (c) 2014 Thomas Wrenn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWFeedTopCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *timePosted;
@property (strong, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) IBOutlet UIImageView *userProfileImage;

@property (nonatomic) NSInteger index;

@end
