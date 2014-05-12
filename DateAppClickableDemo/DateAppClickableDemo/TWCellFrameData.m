//
//  TWCellFrameData.m
//  DateAppClickableDemo
//
//  Created by Jessica Wu on 5/7/14.
//  Copyright (c) 2014 Thomas Wrenn. All rights reserved.
//

#import "TWCellFrameData.h"

@implementation TWCellFrameData
@synthesize height,total;

-(instancetype) initWithHeight:(CGFloat) h withPrevious:(CGFloat) t{
    self = [super init];
    
    if (self) {
        // initialize instance variables here
        height = h;
        total = t;
    }
    
    return self;
}

@end
