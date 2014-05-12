//
//  TWConstants.m
//  DateAppClickableDemo
//
//  Created by Thomas Wrenn on 5/11/14.
//  Copyright (c) 2014 Thomas Wrenn. All rights reserved.
//

#pragma mark - PFObject Date Class
// Class Key
NSString *const kTWPDateClassKey = @"date";

// Field Keys
NSString *const kTWPDateUserKey = @"user";
NSString *const kTWPDateCommentsKey = @"comments";
NSString *const kTWPDateImagesKey = @"images";
NSString *const kTWPDateLikesKey = @"likes";
NSString *const kTWPDateLocationsKey = @"locations";


#pragma mark - PFObject UserLocation Class
// Class Key
NSString *const kTWPUserLocationClassKey = @"UserLocation";

// Field Keys
NSString *const kTWPUserLocationNameKey = @"name";
NSString *const kTWPUserLocationGeoKey = @"geo";
NSString *const kTWPUserLocationFoursquareDataKey = @"foursquareData";


#pragma mark - PFObject UserPhoto Class
// Class Key
NSString *const kTWPUserPhotoClassKey = @"UserPhoto";

// Field Keys
NSString *const kTWPUserPhotoImageFileKey = @"imageFile";
NSString *const kTWPUserPhotoUserKey = @"user";


#pragma mark - PFUser User Class
// Field Keys
NSString *const kTWPUserFollowingKey = @"following";
NSString *const kTWPUserUsernameKey = @"username";
NSString *const kTWPUserUserProfileImageKey = @"userProfileImage";