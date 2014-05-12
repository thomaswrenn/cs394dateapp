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
    commentString = [commentString stringByAppendingString: [nsdict objectForKey:@"user"]];
    commentString = [commentString stringByAppendingString: @": "];
    commentString = [commentString stringByAppendingString: [nsdict objectForKey:@"text"]];
    commentString = [commentString stringByAppendingString: [nsdict objectForKey:@"\n"]];
    
    
    return commentString;
}

+ (NSString *)locationFromJSONItem:(NSString *)jsonItem {
    NSString *locationString = @"";
    locationString = jsonItem;
    return locationString;
}

+ (NSString *)commentsBlockFromNSArray:(NSMutableArray *)nsarray {
    NSMutableString *commentsBlockString = [[NSMutableString alloc] init];
    for (NSInteger i = 0; i < nsarray.count; i++) {
        NSDictionary *comment = nsarray[i];
        [commentsBlockString appendString: [[self class] commentFromCommentNSDict:comment]];
    }
    return commentsBlockString;
}

+ (NSString *)locationsFromNSArray:(NSMutableArray *)nsarray {
    NSMutableString* locationsBlockString = [[NSMutableString alloc] init];
    for (NSInteger i = 0; i < nsarray.count; i++) {
        NSString *location = nsarray[i];
        [locationsBlockString appendString: [[self class] locationFromJSONItem:location]];
        [locationsBlockString appendString: @" "];
    }
    return locationsBlockString;

}

@end
