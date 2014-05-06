//
//  TWCommentTableViewCell.m
//  DateAppClickableDemo
//
//  Created by Jessica Wu on 5/5/14.
//  Copyright (c) 2014 Thomas Wrenn. All rights reserved.
//

#import "TWCommentTableViewCell.h"

@implementation TWCommentTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
