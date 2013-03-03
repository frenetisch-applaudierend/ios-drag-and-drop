//
//  DNDDragAndDropController.h
//  ios-drag-and-drop
//
//  Created by Markus Gasser on 3/1/13.
//  Copyright (c) 2013 Team RG. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol DNDDragSourceDelegate;
@protocol DNDDropTargetDelegate;
@class DNDDragOperation;


@interface DNDDragAndDropController : NSObject

- (instancetype)initWithWindow:(UIWindow *)window;
- (instancetype)init; // uses [[UIApplication sharedApplication] keyWindow]

- (void)registerDragSource:(UIView *)source withDelegate:(id<DNDDragSourceDelegate>)delegate;
- (void)unregisterDragSource:(UIView *)source;

- (void)registerDropTarget:(UIView *)target withDelegate:(id<DNDDropTargetDelegate>)delegate;
- (void)unregisterDropTarget:(UIView *)target;

@end


@protocol DNDDragSourceDelegate <NSObject>

@required
- (UIView *)draggingViewForDragOperation:(DNDDragOperation *)operation;

@optional
- (void)dragOperationWillCancel:(DNDDragOperation *)operation;

@end

@protocol DNDDropTargetDelegate <NSObject>

@required
- (void)dragOperation:(DNDDragOperation *)operation didDropInDropTarget:(UIView *)target;

@optional
- (void)dragOperation:(DNDDragOperation *)operation didEnterDropTarget:(UIView *)target;
- (void)dragOperation:(DNDDragOperation *)operation didLeaveDropTarget:(UIView *)target;
- (BOOL)dragOperation:(DNDDragOperation *)operation shouldPositionDragViewInDropTarget:(UIView *)target;

@end
