//
//  TWFeedItem.h
//  DateAppClickableDemo
//
//  Created by Thomas Wrenn on 3/31/14.
//  Copyright (c) 2014 Thomas Wrenn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWFeedItemModel : NSObject

@property (strong, nonatomic) NSMutableArray *imageURLs; //???: What was the future roadmap for this that I put a TODO on it reading "For Now"?
@property (strong, nonatomic) NSMutableString *username;
@property (strong, nonatomic) NSMutableString *userProfileImageURL;
@property (strong, nonatomic) NSDate *timePosted;
//TODO: UIView Subclass with xib for what a comment or location looks like and have an array of comment views
@property (strong, nonatomic) NSMutableArray *comments;
@property (strong, nonatomic) NSMutableArray *locations;
@property (strong, nonatomic) NSMutableArray *likes;

@end
