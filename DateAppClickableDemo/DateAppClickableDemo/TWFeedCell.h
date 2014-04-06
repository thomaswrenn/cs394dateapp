//
//  TWFeedCell.h
//  DateAppClickableDemo
//
//  Created by Thomas Wrenn on 3/31/14.
//  Copyright (c) 2014 Thomas Wrenn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWFeedCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *topImage; // TODO: For Now
@property (strong, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) IBOutlet UIImageView *userProfileImage;
@property (strong, nonatomic) IBOutlet UILabel *timePosted;
// TODO: UIView Subclass with xib for what a comment or location looks like and have an array of comment views
@property (strong, nonatomic) IBOutlet UILabel *commentsBlock;
@property (strong, nonatomic) IBOutlet UILabel *locationsBlock;
@property (strong, nonatomic) IBOutlet UILabel *likeCount;


// TODO How to make UIButton collections for tokenized tags like locations and hashtags and have them wrap and all that

@end