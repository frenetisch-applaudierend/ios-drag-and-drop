//
//  DNDDragAndDropController.h
//  iOS Library
//
//  Created by Markus Gasser on 3/1/13.
//  Copyright (c) 2013 Team RG. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol DNDDragSourceDelegate;
@protocol DNDDropTargetDelegate;


@interface DNDDragAndDropController : NSObject

- (instancetype)initWithWindow:(UIWindow *)window;
- (instancetype)init; // uses [[UIApplication sharedApplication] keyWindow]

- (void)registerDragSource:(UIView *)source withDelegate:(id<DNDDragSourceDelegate>)delegate;
- (void)unregisterDragSource:(UIView *)source;

- (void)registerDropTarget:(UIView *)target withDelegate:(id<DNDDropTargetDelegate>)delegate;
- (void)unregisterDropTarget:(UIView *)source;

@end


@protocol DNDDragSourceDelegate <NSObject>

@required
- (UIView *)dragAndDropController:(DNDDragAndDropController *)controller viewForDraggingInDragSource:(UIView *)dragSource location:(CGPoint)location;

@end

@protocol DNDDropTargetDelegate <NSObject>
@end
