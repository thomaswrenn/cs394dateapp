//
//  TWFeedItem.m
//  DateAppClickableDemo
//
//  Created by Thomas Wrenn on 3/31/14.
//  Copyright (c) 2014 Thomas Wrenn. All rights reserved.
//

#import "TWFeedItemModel.h"

@implementation TWFeedItemModel

- (id)init {
    self = [super init];
    
    if (self) {
        // initialize instance variables here
         _userProfileImageURL = [[NSMutableString alloc] init];
        _username = [[NSMutableString alloc] init];
    }
    
    return self;
}

+ (TWFeedItemModel*)feedItemModelFromPFObject:(PFObject *)datePFObject {
    self = [super init];
    if (self) {
        _username = [datePFObject val]
    }
}

@end
