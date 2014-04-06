//
//  TWUtility.m
//  DateAppClickableDemo
//
//  Created by Thomas Wrenn on 4/1/14.
//  Copyright (c) 2014 Thomas Wrenn. All rights reserved.
//

#import "TWUtility.h"

@implementation TWUtility

+ (NSString *)commentFromCommentNSDict:(NSDictionary *)nsdict {
    NSString *commentString = @"";
    [commentString stringByAppendingString: [nsdict objectForKey:@"user"]];
    [commentString stringByAppendingString: [nsdict objectForKey:@"text"]];
    [commentString stringByAppendingString: [nsdict objectForKey:@"\n"]];
    return commentString;
}

+ (NSString *)locationFromJSONItem:(NSString *)jsonItem {
    NSString *locationString = @"";
    locationString = jsonItem;
    return locationString;
}

+ (NSString *)commentsBlockFromNSArray:(NSMutableArray *)nsarray {
    NSString *commentsBlockString = @"";
    for (NSInteger i = 0; i < nsarray.count; i++) {
        NSDictionary *comment = nsarray[i];
        [[self class] commentFromCommentNSDict:comment];
    }
    return commentsBlockString;
}

+ (NSString *)locationsFromNSArray:(NSMutableArray *)nsarray {
    NSString* locationsBlockString = @"";
    for (NSInteger i = 0; i < nsarray.count; i++) {
        NSString *location = nsarray[i];
        [[self class] locationFromJSONItem:location];
    }
    return locationsBlockString;

}

@end
