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
@property (nonatomic, strong) UITouch *trackedTouch;
@property (nonatomic, assign) CGPoint startPoint;

@end


@implementation DNDLongPressDragRecognizer

#pragma mark - Initialization

- (instancetype)initWithTarget:(id)target action:(SEL)action {
    if ((self = [super initWithTarget:target action:action])) {
        _minimumPressDuration = 0.5;
        _allowableMovement = 10.0f;
    }
    return self;
}


#pragma mark - Handling Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (touches.count > 1 || self.trackedTouch != nil) {
        return;
    }
    
    self.trackedTouch = [touches anyObject];
    self.longPressTimer = [NSTimer scheduledTimerWithTimeInterval:self.minimumPressDuration
                                                           target:self selector:@selector(checkLongPress:)
                                                         userInfo:nil repeats:NO];
    self.startPoint = [self.trackedTouch locationInView:self.view];
}

- (void)checkLongPress:(NSTimer *)timer {
    if (self.trackedTouch != nil && self.trackedTouch.phase == UITouchPhaseStationary) {
        self.state = UIGestureRecognizerStateBegan;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.state == UIGestureRecognizerStateBegan || self.state == UIGestureRecognizerStateChanged) {
        self.state = UIGestureRecognizerStateChanged;
    } else if (self.state == UIGestureRecognizerStatePossible) {
        CGPoint currentPoint = [self.trackedTouch locationInView:self.view];
        CGPoint vector = CGPointMake(currentPoint.x - self.startPoint.x, currentPoint.y - self.startPoint.y);
        CGFloat distance = (CGFloat)hypot(vector.x, vector.y);
        
        if (distance > self.allowableMovement) {
            [self failRecognition];
        }
    } else {
        [self failRecognition];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.state == UIGestureRecognizerStateBegan || self.state == UIGestureRecognizerStateChanged) {
        self.state = UIGestureRecognizerStateEnded;
        self.trackedTouch = nil;
    } else {
        [self failRecognition];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self failRecognition];
}


#pragma mark - Getting Information

- (CGPoint)locationInView:(UIView *)view {
    return [self.trackedTouch locationInView:view];
}


#pragma mark - Helpers

- (void)failRecognition {
    [self.longPressTimer invalidate];
    self.trackedTouch = nil;
    self.state = UIGestureRecognizerStateFailed;
}

@end
