//
//  DNDDragHandler.m
//  iOS Library
//
//  Created by Markus Gasser on 3/1/13.
//  Copyright (c) 2013 Team RG. All rights reserved.
//

#import "DNDDragHandler.h"
#import "DNDDragContext.h"


@implementation DNDDragHandler {
    DNDDragContext *_currentContext;
}

#pragma mark - Initialization

- (instancetype)initWithDragSourceView:(UIView *)dragSource dragSourceDelegate:(id<DNDDragSourceDelegate>)dragDelegate {
    NSParameterAssert(dragSource != nil);
    NSParameterAssert(dragDelegate != nil);
    
    if ((self = [super init])) {
        _dragSourceView = dragSource;
        _dragSourceDelegate = dragDelegate;
        _dragRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleDragGesture:)];
        [_dragSourceView addGestureRecognizer:_dragRecognizer];
    }
    return self;
}

- (void)dealloc {
    [_dragSourceView removeGestureRecognizer:_dragRecognizer];
}


#pragma mark - Handling a Drag Gesture

- (void)handleDragGesture:(UIGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [self beginDraggingForGestureRecognizer:recognizer];
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        [self updateDraggingForGestureRecognizer:recognizer];
    } else {
        [self finishDraggingForGestureRecognizer:recognizer];
    }
}

- (void)beginDraggingForGestureRecognizer:(UIGestureRecognizer *)recognizer {
    NSAssert(_currentContext == nil, @"Should not yet have a context");
}

- (void)updateDraggingForGestureRecognizer:(UIGestureRecognizer *)recognizer {
    NSAssert(_currentContext != nil, @"Need a context");
}

- (void)finishDraggingForGestureRecognizer:(UIGestureRecognizer *)recognizer {
    NSAssert(_currentContext != nil, @"Need a context");
    _currentContext = nil;
}

@end
