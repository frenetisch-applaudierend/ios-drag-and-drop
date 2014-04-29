//
//  DNDSampleDragView.m
//  iOS Sample Application
//
//  Created by Markus Gasser on 3/3/13.
//  Copyright (c) 2013 konoma GmbH. All rights reserved.
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
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        self.clipsToBounds = YES;
    }
    return self;
}

@end
