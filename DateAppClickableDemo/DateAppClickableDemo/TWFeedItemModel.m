//
//  TWFeedItemModel.m
//  DateAppClickableDemo
//
//  Created by Thomas Wrenn on 3/31/14.
//  Copyright (c) 2014 Thomas Wrenn. All rights reserved.
//

#import "TWFeedItemModel.h"

@implementation TWFeedItemModel

- (id)initWithPFObject:(PFObject *)datePFObject {
    if (self = [super init]) {
        PFUser* userPFObject = [datePFObject valueForKey:kTWPDateUserKey];
        [userPFObject fetchIfNeeded];
        _username         = [userPFObject valueForKey:kTWPUserUsernameKey];
        _timePosted       = [datePFObject valueForKey:kTWPDateTimePostedKey];
        PFObject* profileImage = [userPFObject valueForKeyPath:kTWPUserUserProfileImageKey];
        [profileImage fetchIfNeeded];
        _userProfileImage = [TWUtility getUIImageWithPFObject:profileImage];
        _images           = [datePFObject valueForKey:kTWPDateImagesKey];
        _locations        = [datePFObject valueForKey:kTWPDateLocationsKey];
        _likes            = [datePFObject valueForKey:kTWPDateLikesKey];
        _comments         = [datePFObject valueForKey:kTWPDateCommentsKey];
    }
    return self;
}

- (id)init {
    return [self initWithPFObject:[PFObject objectWithClassName:kTWPDateClassKey]];
}

@end
