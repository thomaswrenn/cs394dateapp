//
//  TWCellFrameData.h
//  DateAppClickableDemo
//
//  Created by Jessica Wu on 5/7/14.
//  Copyright (c) 2014 Thomas Wrenn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWCellFrameData : NSObject

@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat total;

-(instancetype) initWithHeight:(CGFloat) h withPrevious:(CGFloat) t;

@end
