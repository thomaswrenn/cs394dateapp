//
//  TWCommentTableViewCell.h
//  DateAppClickableDemo
//
//  Created by Jessica Wu on 5/5/14.
//  Copyright (c) 2014 Thomas Wrenn. All rights reserved.
//

@interface TWCommentTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UITextView *commentLabel;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;

@end
