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


@interface DNDDragHandler ()

@property (nonatomic, strong) UIPanGestureRecognizer *dragRecognizer;
@property (nonatomic, strong) DNDDragContext *currentContext;

@end


@implementation DNDDragHandler

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
    NSAssert(self.currentContext == nil, @"Should not yet have a context");
    
    self.currentContext = [[DNDDragContext alloc] initWithDragHandler:self];
    UIView *dragView = [self.dragDelegate dragAndDropController:self.controller viewForDraggingWithContext:self.currentContext];
    if (dragView == nil) {
        [self cancelDragging];
        return;
    }
    
    self.currentContext.draggingView = dragView;
    [self.controller.dragPaneView addSubview:dragView];
    dragView.center = [recognizer locationInView:self.controller.dragPaneView];
}

- (void)updateDraggingForGestureRecognizer:(UIGestureRecognizer *)recognizer {
    NSAssert(self.currentContext != nil, @"Need a context");
    
    self.currentContext.draggingView.center = [recognizer locationInView:_controller.dragPaneView];
}

- (void)finishDraggingForGestureRecognizer:(UIGestureRecognizer *)recognizer {
    NSAssert(self.currentContext != nil, @"Need a context");
    
    if ([self.currentContext isDraggingCancelled]) {
        return;
    }
    
    if ([self.dragDelegate respondsToSelector:@selector(dragAndDropController:cancelDraggingWithContext:)]) {
        [self.dragDelegate dragAndDropController:self.controller cancelDraggingWithContext:self.currentContext];
    }
    
    if (![self.currentContext isDraggingCancelled]) {
        [self.currentContext cancelDragging];
    }
}


#pragma mark - Cancelling Dragging

- (void)cancelDragging {
    [self resetDragRecognizer];
    self.currentContext = nil;
}

- (void)resetDragRecognizer {
    if (self.dragRecognizer.enabled) {
        self.dragRecognizer.enabled = NO;
        self.dragRecognizer.enabled = YES;
    }
}

@end
