//
//  DNDDragAndDropController.m
//  ios-drag-and-drop
//
//  Created by Markus Gasser on 3/1/13.
//  Copyright (c) 2013 Team RG. All rights reserved.
//

#import "DNDDragAndDropController_Private.h"
#import "DNDDragHandler.h"


@implementation DNDDragAndDropController {
    UIWindow *_window;
    NSMapTable *_dragSources;
    NSMapTable *_dropTargets;
}

#pragma mark - Initialization

- (instancetype)initWithWindow:(UIWindow *)window {
    if ((self = [super init])) {
        _window = window;
        _dragSources = [NSMapTable mapTableWithKeyOptions:NSMapTableWeakMemory valueOptions:NSMapTableStrongMemory];
        _dropTargets = [NSMapTable mapTableWithKeyOptions:NSMapTableWeakMemory valueOptions:NSMapTableWeakMemory];
    }
    return self;
}

- (instancetype)init {
    return [self initWithWindow:[[UIApplication sharedApplication] keyWindow]];
}


#pragma mark - Getting Views

- (UIView *)dragPaneView {
    return _window.rootViewController.view;
}

- (UIView *)dropTargetAtLocation:(CGPoint)location {
    UIView *candidate = [self.dragPaneView hitTest:location withEvent:nil];
    while (candidate != nil && candidate != self.dragPaneView) {
        if ([_dropTargets objectForKey:candidate] != nil) {
            return candidate;
        }
        candidate = candidate.superview;
    }
    return nil;
}

- (id<DNDDropTargetDelegate>)delegateForDropTarget:(UIView *)target {
    return (target != nil ? [_dropTargets objectForKey:target] : nil);
}


#pragma mark - Registering Sources and Targets

- (void)registerDragSource:(UIView *)source withDelegate:(id<DNDDragSourceDelegate>)delegate {
    NSParameterAssert(source != nil);
    NSParameterAssert(delegate != nil);
    
    [_dragSources setObject:[[DNDDragHandler alloc] initWithController:self sourceView:source delegate:delegate] forKey:source];
}

- (void)unregisterDragSource:(UIView *)source {
    NSParameterAssert(source != nil);
    
    [_dragSources removeObjectForKey:source];
}

- (void)registerDropTarget:(UIView *)target withDelegate:(id<DNDDropTargetDelegate>)delegate {
    NSParameterAssert(target != nil);
    NSParameterAssert(delegate != nil);
    
    [_dropTargets setObject:delegate forKey:target];
}

- (void)unregisterDropTarget:(UIView *)target {
    NSParameterAssert(target != nil);
    
    [_dropTargets removeObjectForKey:target];
}

@end
