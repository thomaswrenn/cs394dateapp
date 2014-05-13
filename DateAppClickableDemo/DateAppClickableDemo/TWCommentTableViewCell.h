//
//  TWCommentTableViewCell.h
//  DateAppClickableDemo
//
//  Created by Jessica Wu on 5/5/14.
//  Copyright (c) 2014 Thomas Wrenn. All rights reserved.
//

#import <AMAttributedHighlightLabel/AMAttributedHighlightLabel.h>

@interface TWCommentTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet AMAttributedHighlightLabel *commentLabel;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;

@end
