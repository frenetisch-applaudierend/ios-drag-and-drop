//
//  DNDDragHandler.m
//  iOS Library
//
//  Created by Markus Gasser on 3/1/13.
//  Copyright (c) 2013 Team RG. All rights reserved.
//

#import "DNDDragHandler.h"
#import "DNDDragAndDropController_Private.h"
#import "DNDDragContext_Private.h"


@implementation DNDDragHandler {
    UIPanGestureRecognizer *_dragRecognizer;
    DNDDragContext *_currentContext;
}

#pragma mark - Initialization

- (instancetype)initWithController:(DNDDragAndDropController *)controller sourceView:(UIView *)source delegate:(id<DNDDragSourceDelegate>)delegate {
    NSParameterAssert(controller != nil);
    NSParameterAssert(source != nil);
    NSParameterAssert(delegate != nil);
    
    if ((self = [super init])) {
        _controller = controller;
        _sourceView = source;
        _dragDelegate = delegate;
        _dragRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleDragGesture:)];
        _dragRecognizer.maximumNumberOfTouches = 1;
        [_sourceView addGestureRecognizer:_dragRecognizer];
    }
    return self;
}

- (void)dealloc {
    [_sourceView removeGestureRecognizer:_dragRecognizer];
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
    
    _currentContext = [[DNDDragContext alloc] init];
    UIView *dragView = [_dragDelegate dragAndDropController:_controller draggedViewForDragSource:_sourceView context:_currentContext];
    if (dragView == nil) {
        [self resetDragRecognizer];
        return;
    }
    
    _currentContext.dragView = dragView;
    [_controller.dragPaneView addSubview:dragView];
    dragView.center = [recognizer locationInView:_controller.dragPaneView];
}

- (void)updateDraggingForGestureRecognizer:(UIGestureRecognizer *)recognizer {
    NSAssert(_currentContext != nil, @"Need a context");
    
    _currentContext.dragView.center = [recognizer locationInView:_controller.dragPaneView];
}

- (void)finishDraggingForGestureRecognizer:(UIGestureRecognizer *)recognizer {
    NSAssert(_currentContext != nil, @"Need a context");
    
    [_currentContext.dragView removeFromSuperview];
    _currentContext = nil;
}

- (void)resetDragRecognizer {
    if (_dragRecognizer.enabled) {
        _dragRecognizer.enabled = NO;
        _dragRecognizer.enabled = YES;
    }
}

@end
