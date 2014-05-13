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
    PFUser* commentingUser = [nsdict valueForKey:kTWPDateUserKey];
    [commentingUser fetchIfNeeded];
    commentString = [commentString stringByAppendingString: [commentingUser valueForKey:kTWPUserUsernameKey]];
    commentString = [commentString stringByAppendingString: @": "];
    commentString = [commentString stringByAppendingString: [nsdict valueForKey:@"text"]];
//    commentString = [commentString stringByAppendingString: [nsdict objectForKey:@"\n"]];
    
    
    return commentString;
}

+ (NSString *)locationFromJSONItem:(NSString *)jsonItem {
    NSString *locationString = @"";
    locationString = jsonItem;
    return locationString;
}

+ (NSString *)commentsBlockFromNSArray:(NSMutableArray *)nsarray withAmount:(NSInteger) size{
    NSMutableString *commentsBlockString = [[NSMutableString alloc] init];
    NSInteger start = 0;
    if( nsarray.count > 5 ){
        start = nsarray.count - size;
    }
    for (NSInteger i = start; i < nsarray.count; i++) {
        NSDictionary *comment = nsarray[i];
        [commentsBlockString appendString: [[self class] commentFromCommentNSDict:comment]];
        if( (i+1) != nsarray.count ){
            [commentsBlockString appendString: @"\n"];
        }
    }
    if( nsarray.count > 5 ){
        [commentsBlockString appendString: @"\n"];
        [commentsBlockString appendString: @"Show more..."];
//        [commentsBlockString appendString: @"\n"];
    }
    return commentsBlockString;
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
        PFObject* locationPFObject = [nsarray[i] fetchIfNeeded];
        NSString *location = [locationPFObject valueForKeyPath:kTWPUserLocationNameKey];
        [locationsBlockString appendString: [[self class] locationFromJSONItem:location]];
        [locationsBlockString appendString: @" "];
    }
    return locationsBlockString;

}

+ (void)getDatesFromUsers:(NSMutableArray *)fromUsers withCallback:(void (^)(NSArray *dates, NSError *error))completionBlock {
    PFQuery *dateQuery = [PFQuery queryWithClassName:kTWPDateClassKey];
    [dateQuery whereKey:kTWPDateUserKey containedIn:fromUsers];
    [dateQuery orderByDescending:kTWPDateTimePostedKey];
    [dateQuery setCachePolicy:kPFCachePolicyNetworkOnly];
    [dateQuery findObjectsInBackgroundWithBlock:^(NSArray *dates, NSError *error)
     {
         if (completionBlock) {
             completionBlock(dates, error);
         }
     }];
}

+ (UIImage *)getUIImageWithPFObject:(PFObject *)image {
    return [UIImage imageWithData:[[image objectForKey:@"imageFile"] getData]];
}
        /*
        // proceed to creating new like
        PFObject *likeActivity = [PFObject objectWithClassName:kPAPActivityClassKey];
        [likeActivity setObject:kPAPActivityTypeLike forKey:kPAPActivityTypeKey];
        [likeActivity setObject:[PFUser currentUser] forKey:kPAPActivityFromUserKey];
        [likeActivity setObject:[photo objectForKey:kPAPPhotoUserKey] forKey:kPAPActivityToUserKey];
        [likeActivity setObject:photo forKey:kPAPActivityPhotoKey];
        
        PFACL *likeACL = [PFACL ACLWithUser:[PFUser currentUser]];
        [likeACL setPublicReadAccess:YES];
        [likeACL setWriteAccess:YES forUser:[photo objectForKey:kPAPPhotoUserKey]];
        likeActivity.ACL = likeACL;
        
        [likeActivity saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (completionBlock) {
                completionBlock(succeeded,error);
            }
            
            // refresh cache
            PFQuery *query = [PAPUtility queryForActivitiesOnPhoto:photo cachePolicy:kPFCachePolicyNetworkOnly];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                    
                    NSMutableArray *likers = [NSMutableArray array];
                    NSMutableArray *commenters = [NSMutableArray array];
                    
                    BOOL isLikedByCurrentUser = NO;
                    
                    for (PFObject *activity in objects) {
                        if ([[activity objectForKey:kPAPActivityTypeKey] isEqualToString:kPAPActivityTypeLike] && [activity objectForKey:kPAPActivityFromUserKey]) {
                            [likers addObject:[activity objectForKey:kPAPActivityFromUserKey]];
                        } else if ([[activity objectForKey:kPAPActivityTypeKey] isEqualToString:kPAPActivityTypeComment] && [activity objectForKey:kPAPActivityFromUserKey]) {
                            [commenters addObject:[activity objectForKey:kPAPActivityFromUserKey]];
                        }
                        
                        if ([[[activity objectForKey:kPAPActivityFromUserKey] objectId] isEqualToString:[[PFUser currentUser] objectId]]) {
                            if ([[activity objectForKey:kPAPActivityTypeKey] isEqualToString:kPAPActivityTypeLike]) {
                                isLikedByCurrentUser = YES;
                            }
                        }
                    }
                    
                    [[PAPCache sharedCache] setAttributesForPhoto:photo likers:likers commenters:commenters likedByCurrentUser:isLikedByCurrentUser];
                }
                
                [[NSNotificationCenter defaultCenter] postNotificationName:PAPUtilityUserLikedUnlikedPhotoCallbackFinishedNotification object:photo userInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:succeeded] forKey:PAPPhotoDetailsViewControllerUserLikedUnlikedPhotoNotificationUserInfoLikedKey]];
            }];
            
        }];
    }];
}*/


@end
