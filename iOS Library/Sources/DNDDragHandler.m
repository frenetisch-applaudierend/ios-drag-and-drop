//
//  DNDDragHandler.m
//  ios-drag-and-drop
//
//  Created by Markus Gasser on 3/1/13.
//  Copyright (c) 2013 Team RG. All rights reserved.
//

#import "DNDDragHandler.h"
#import "DNDDragAndDropController_Private.h"
#import "DNDDragOperation_Private.h"


@interface DNDDragHandler ()

@property (nonatomic, strong) UIPanGestureRecognizer *dragRecognizer;
@property (nonatomic, strong) DNDDragOperation *currentDragOperation;

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
    NSAssert(self.currentDragOperation == nil, @"Should not yet have a context");
    
    self.currentDragOperation = [[DNDDragOperation alloc] initWithDragHandler:self];
    UIView *dragView = [self.dragDelegate dragViewForDragOperation:self.currentDragOperation];
    if (dragView == nil) {
        [self cancelDragging];
        return;
    }
    
    self.currentDragOperation.draggingView = dragView;
    [self.controller.dragPaneView addSubview:dragView];
    dragView.center = [recognizer locationInView:self.controller.dragPaneView];
}

- (void)updateDraggingForGestureRecognizer:(UIGestureRecognizer *)recognizer {
    NSAssert(self.currentDragOperation != nil, @"Need a context");
    
    self.currentDragOperation.draggingView.center = [recognizer locationInView:_controller.dragPaneView];
}

- (void)finishDraggingForGestureRecognizer:(UIGestureRecognizer *)recognizer {
    NSAssert(self.currentDragOperation != nil, @"Need a context");
    
    if ([self.currentDragOperation isDraggingViewRemoved]) {
        return;
    }
    
    UIView *dropTarget = [self dropTargetAtLocation:[recognizer locationInView:self.controller.dragPaneView]];
    if (dropTarget != nil) {
        id<DNDDropTargetDelegate> dropDelegate = [self.controller delegateForDropTarget:dropTarget];
        [dropDelegate dragOperation:self.currentDragOperation didDropInDropTarget:dropTarget];
        [self removeDragViewIfNecessary];
    } else {
        if ([self.dragDelegate respondsToSelector:@selector(dragOperationWillCancel:)]) {
            [self.dragDelegate dragOperationWillCancel:self.currentDragOperation];
        }
        [self removeDragViewIfNecessary];
    }
}


#pragma mark - Managing the Drag View

- (void)removeDragViewIfNecessary {
    if (![self.currentDragOperation isDraggingViewRemoved]) {
        [self.currentDragOperation removeDraggingView];
    }
}


#pragma mark - Finding a Drop Target

- (UIView *)dropTargetAtLocation:(CGPoint)location {
    BOOL userInteractionEnabled = self.currentDragOperation.draggingView.userInteractionEnabled;
    UIView *dropTarget;
    
    self.currentDragOperation.draggingView.userInteractionEnabled = NO; // make sure it's not returned by -hitTest:withEvent:
    dropTarget = [self.controller dropTargetAtLocation:location];
    self.currentDragOperation.draggingView.userInteractionEnabled = userInteractionEnabled;
    
    return dropTarget;
}


#pragma mark - Cancelling Dragging

- (void)cancelDragging {
    [self resetDragRecognizer];
    self.currentDragOperation = nil;
}

- (void)resetDragRecognizer {
    if (self.dragRecognizer.enabled) {
        self.dragRecognizer.enabled = NO;
        self.dragRecognizer.enabled = YES;
    }
}

@end
