//
//  DNDStackSampleView.m
//  iOS Sample Application
//
//  Created by Markus Gasser on 3/5/13.
//  Copyright (c) 2013 konoma GmbH. All rights reserved.
//

#import "DNDStackSampleView.h"


@implementation DNDStackSampleView {
    NSMutableArray *_stackedViews;
}

#pragma mark - Initialization

- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self commonInitialization];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self commonInitialization];
}

- (void)commonInitialization {
    _stackedViews = [NSMutableArray array];
}


#pragma mark - Manage Stacked Views

- (void)addStackedView:(UIView *)view animated:(BOOL)animated {
    [_stackedViews addObject:view];
    [self addSubview:view];
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            [self layoutIfNeeded];
        }];
    }
}

- (void)removeStackedView:(UIView *)view animated:(BOOL)animated {
    [_stackedViews removeObject:view];
    [view removeFromSuperview];
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            [self layoutIfNeeded];
        }];
    }
}

- (UIView *)stackedViewAtPoint:(CGPoint)point {
    [self layoutIfNeeded];
    UIView *candidate = [self hitTest:point withEvent:nil];
    return ((candidate != nil && [_stackedViews containsObject:candidate]) ? candidate : nil);
}


#pragma mark - Layouting

- (void)layoutSubviews {
    [super layoutSubviews];
    
    const CGFloat Spacing = 5.0f;
    const CGFloat x = floorf(self.bounds.size.width / 2.0f);
    CGFloat y = 20.0f;
    
    for (UIView *stackedView in _stackedViews) {
        y += floorf(stackedView.bounds.size.height / 2.0f);
        stackedView.center = CGPointMake(x, y);
        y += (floorf(stackedView.bounds.size.height / 2.0f) + Spacing);
    }
}

@end
