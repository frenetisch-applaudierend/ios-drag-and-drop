//
//  UITouch+DNDTouchLocationUpdates.m
//  iOS Library
//
//  Created by How Else on 4/8/16.
//  Copyright © 2016 konoma GmbH. All rights reserved.
//

#import "UITouch+DNDTouchLocationUpdates.h"

@implementation UITouch (DNDTouchLocationUpdates)

- (BOOL)locationChanged {
    UIView *view = self.view;
    CGPoint location = [self locationInView:view];
    CGPoint previousLocation = [self previousLocationInView:view];
    return !CGPointEqualToPoint(location, previousLocation);
}

@end
