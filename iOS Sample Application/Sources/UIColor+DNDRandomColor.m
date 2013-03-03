//
//  UIColor+DNDRandomColor.m
//  iOS Sample Application
//
//  Created by Markus Gasser on 3/3/13.
//  Copyright (c) 2013 Team RG. All rights reserved.
//

#import "UIColor+DNDRandomColor.h"


static inline CGFloat randomRGB(void) {
    return ((CGFloat)(arc4random() % 256) / 255.0f);
}

@implementation UIColor (DNDRandomColor)

+ (instancetype)randomColor {
    return [self colorWithRed:randomRGB() green:randomRGB() blue:randomRGB() alpha:1.0f];
}

@end
