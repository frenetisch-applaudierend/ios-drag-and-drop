//
//  DNDDragOperation.m
//  ios-drag-and-drop
//
//  Created by Markus Gasser on 3/1/13.
//  Copyright (c) 2013 Team RG. All rights reserved.
//

#import "DNDDragOperation_Private.h"
#import "DNDDragAndDropController_Private.h"


@implementation DNDDragOperation {
    BOOL _canceled;
}

#pragma mark - Initialization

- (instancetype)initWithDragHandler:(DNDDragHandler *)handler dragSourceView:(UIView *)source {
    if ((self = [super init])) {
        _dragHandler = handler;
        _dragSourceView = source;
        _userInfo = [NSMutableDictionary dictionary];
    }
    return self;
}


#pragma mark - Getting Information

- (CGPoint)locationInView:(UIView *)view {
    return [self convertPoint:self.dragLocation toView:view];
}


#pragma mark - Cancel Dragging

- (BOOL)isDraggingViewRemoved {
    return _canceled;
}

- (void)removeDraggingView {
    [self beginRemovingDraggingView];
    [self completeRemovingDraggingView];
}

- (void)removeDraggingViewAnimatedWithDuration:(NSTimeInterval)duration animations:(void(^)())animations {
    [self beginRemovingDraggingView];
    [UIView animateWithDuration:duration animations:animations completion:^(BOOL finished) {
        [self completeRemovingDraggingView];
    }];
}

- (void)beginRemovingDraggingView {
    _canceled = YES;
    [self.dragHandler cancelDragging];
}

- (void)completeRemovingDraggingView {
    [self.draggingView removeFromSuperview];
}


#pragma mark - Conversion Helpers

- (CGPoint)convertPoint:(CGPoint)point toView:(UIView *)view {
    return [self.dragHandler.controller.dragPaneView convertPoint:point toView:view];
}

- (CGPoint)convertPoint:(CGPoint)point fromView:(UIView *)view {
    return [self.dragHandler.controller.dragPaneView convertPoint:point fromView:view];
}

- (CGRect)convertRect:(CGRect)rect toView:(UIView *)view {
    return [self.dragHandler.controller.dragPaneView convertRect:rect toView:view];
}

- (CGRect)convertRect:(CGRect)rect fromView:(UIView *)view {
    return [self.dragHandler.controller.dragPaneView convertRect:rect fromView:view];
}

@end
