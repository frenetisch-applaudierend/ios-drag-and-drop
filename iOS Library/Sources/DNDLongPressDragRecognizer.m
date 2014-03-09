//
//  DNDLongPressDragRecognizer.m
//  iOS Library
//
//  Created by Markus Gasser on 09.03.14.
//  Copyright (c) 2014 konoma GmbH. All rights reserved.
//

#import "DNDLongPressDragRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>


@interface DNDLongPressDragRecognizer ()

@property (nonatomic, weak) NSTimer *longPressTimer;

@end

@implementation DNDLongPressDragRecognizer

#pragma mark - Initialization

- (instancetype)initWithTarget:(id)target action:(SEL)action {
    if ((self = [super initWithTarget:target action:action])) {
        _minimumPressDuration = 0.5;
    }
    return self;
}

#pragma mark - Handling Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSAssert(self.state == UIGestureRecognizerStatePossible, @"Should be in another state");
    
    if ([touches count] > 1) {
        [self reset];
        return;
    }
    
    self.longPressTimer = [NSTimer scheduledTimerWithTimeInterval:self.minimumPressDuration
                                                           target:self selector:@selector(didLongPress:)
                                                         userInfo:nil repeats:NO];
}

- (void)didLongPress:(NSTimer *)timer {
    self.state = UIGestureRecognizerStateBegan;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.state == UIGestureRecognizerStateBegan || self.state == UIGestureRecognizerStateChanged) {
        self.state = UIGestureRecognizerStateChanged;
    } else {
        [self.longPressTimer invalidate];
        self.state = UIGestureRecognizerStateFailed;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.state == UIGestureRecognizerStateBegan || self.state == UIGestureRecognizerStateChanged) {
        self.state = UIGestureRecognizerStateEnded;
    } else {
        [self.longPressTimer invalidate];
        self.state = UIGestureRecognizerStateFailed;
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.longPressTimer invalidate];
    self.state = UIGestureRecognizerStateCancelled;
}


@end
