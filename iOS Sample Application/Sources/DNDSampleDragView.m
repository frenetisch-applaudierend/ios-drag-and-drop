//
//  DNDSampleDragView.m
//  iOS Sample Application
//
//  Created by Markus Gasser on 3/3/13.
//  Copyright (c) 2013 Team RG. All rights reserved.
//

#import "DNDSampleDragView.h"
#import "UIColor+DNDRandomColor.h"
#import <QuartzCore/QuartzCore.h>


@implementation DNDSampleDragView

- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.backgroundColor = [UIColor randomColor];
        self.layer.borderColor = [[UIColor whiteColor] CGColor];
        self.layer.borderWidth = 2.0f;
        self.layer.cornerRadius = 5.0f;
    }
    return self;
}

@end
