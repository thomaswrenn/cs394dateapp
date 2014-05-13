//
//  TWFeedItemModel.h
//  DateAppClickableDemo
//
//  Created by Thomas Wrenn on 3/31/14.
//  Copyright (c) 2014 Thomas Wrenn. All rights reserved.
//

@interface TWFeedItemModel : NSObject

@property (strong, nonatomic) NSMutableString *username;
@property (strong, nonatomic) NSDate          *timePosted;
@property (strong, nonatomic) UIImage         *userProfileImage;
@property (strong, nonatomic) NSMutableArray  *images;
@property (strong, nonatomic) NSMutableArray  *locations;
@property (strong, nonatomic) NSMutableArray  *likes;
@property (strong, nonatomic) NSMutableArray  *comments;

- (id)initWithPFObject:(PFObject *)datePFObject;

@end
