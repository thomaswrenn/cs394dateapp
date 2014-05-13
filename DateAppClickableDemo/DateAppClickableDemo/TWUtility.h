//
//  TWUtility.h
//  DateAppClickableDemo
//
//  Created by Thomas Wrenn on 4/1/14.
//  Copyright (c) 2014 Thomas Wrenn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWUtility : NSObject

+ (NSString *)commentFromCommentNSDict:(NSDictionary *)nsdict;

+ (NSString *)commentsBlockFromNSArray:(NSMutableArray *)nsarray;

+ (NSString *)commentsBlockFromNSArray:(NSMutableArray *)nsarray withAmount:(NSInteger) size;

+ (NSString *)locationsFromNSArray:(NSMutableArray *)nsarray;

@end
