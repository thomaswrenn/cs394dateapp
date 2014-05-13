//
//  TWFeedCell.h
//  DateAppClickableDemo
//
//  Created by Thomas Wrenn on 3/31/14.
//  Copyright (c) 2014 Thomas Wrenn. All rights reserved.
//


@interface TWFeedCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *topImage; // TODO: For Now
// TODO: UIView Subclass with xib for what a comment or location looks like and have an array of comment views
@property (strong, nonatomic) IBOutlet UITextView *commentsBlock;
@property (strong, nonatomic) IBOutlet UILabel *likeCount;
@property (strong, nonatomic) IBOutlet UILabel *locationsBlock;

@property (nonatomic) NSInteger index;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;

@end
