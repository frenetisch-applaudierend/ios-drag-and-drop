//
//  DNDDragAndDropController.m
//  iOS Library
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


#pragma mark - Getting Info

- (UIView *)dragPaneView {
    return _window.rootViewController.view;
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
    
}

- (void)unregisterDropTarget:(UIView *)source {
    
}

@end
