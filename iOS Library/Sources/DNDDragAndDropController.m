//
//  DNDDragAndDropController.m
//  ios-drag-and-drop
//
//  Created by Markus Gasser on 3/1/13.
//  Copyright (c) 2013 Team RG. All rights reserved.
//

#import "DNDDragAndDropController_Private.h"
#import "DNDDragHandler.h"


@interface DNDDragAndDropController ()

@property (nonatomic, readonly) UIWindow *window;
@property (nonatomic, readonly) NSMapTable *dragSources;
@property (nonatomic, readonly) NSMapTable *dropTargets;

@end

@implementation DNDDragAndDropController

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
    return self.window.rootViewController.view;
}

- (UIView *)dropTargetAtLocation:(CGPoint)location {
    UIView *candidate = [self.dragPaneView hitTest:location withEvent:nil];
    while (candidate != nil && candidate != self.dragPaneView) {
        if ([self.dropTargets objectForKey:candidate] != nil) {
            return candidate;
        }
        candidate = candidate.superview;
    }
    return nil;
}

- (id<DNDDropTargetDelegate>)delegateForDropTarget:(UIView *)target {
    return (target != nil ? [self.dropTargets objectForKey:target] : nil);
}


#pragma mark - Registering Sources and Targets

- (void)registerDragSource:(UIView *)source withDelegate:(id<DNDDragSourceDelegate>)delegate {
    Require(source != nil);
    Require(delegate != nil);
    
    DNDDragHandler *handler = [[DNDDragHandler alloc] initWithController:self sourceView:source delegate:delegate];
    [self.dragSources setObject:handler forKey:source];
}

- (void)unregisterDragSource:(UIView *)source {
    if (source != nil) {
        [self.dragSources removeObjectForKey:source];
    }
}

- (void)registerDropTarget:(UIView *)target withDelegate:(id<DNDDropTargetDelegate>)delegate {
    Require(target != nil);
    Require(delegate != nil);
    
    [self.dropTargets setObject:delegate forKey:target];
}

- (void)unregisterDropTarget:(UIView *)target {
    if (target != nil) {
        [self.dropTargets removeObjectForKey:target];
    }
}

@end
