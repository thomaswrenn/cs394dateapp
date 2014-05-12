//
//  TWUtility.h
//  DateAppClickableDemo
//
//  Created by Thomas Wrenn on 4/1/14.
//  Copyright (c) 2014 Thomas Wrenn. All rights reserved.
//

#import "TWFeedItemModel.h"

@interface TWUtility : NSObject

+ (NSString *)commentFromCommentNSDict:(NSDictionary *)nsdict;

+ (NSString *)commentsBlockFromNSArray:(NSMutableArray *)nsarray;

+ (NSString *)locationsFromNSArray:(NSMutableArray *)nsarray;

+ (void)getDatesWithCallback:(void (^)(NSArray *dates, NSError *error))completionBlock;

@end
