//
//  TWFeedItemModel.m
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
         _userProfileImage = [[NSMutableString alloc] init];
        _username = [[NSMutableString alloc] init];
    }
    
    return self;
}

- (TWFeedItemModel*)initFromPFObject:(PFObject *)datePFObject {
    self = [super init];
    if (self) {
        PFUser* userPFObject = [datePFObject valueForKey:kTWPDateUserKey];
        _username         = [userPFObject valueForKey:kTWPUserUsernameKey];
        _timePosted       = [datePFObject valueForKey:kTWPDateTimePostedKey];
        _userProfileImage = [userPFObject valueForKey:kTWPUserUserProfileImageKey];
        _images           = [datePFObject valueForKey:kTWPDateImagesKey];
        _locations        = [datePFObject valueForKey:kTWPDateLocationsKey];
        _likes            = [datePFObject valueForKey:kTWPDateLikesKey];
        _comments         = [datePFObject valueForKey:kTWPDateCommentsKey];
    }
    return self;
}

@end
