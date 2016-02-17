//
//  DNDDragAndDropController_Private.h
//  ios-drag-and-drop
//
//  Created by Markus Gasser on 3/1/13.
//  Copyright (c) 2013 konoma GmbH. All rights reserved.
//


#import "DNDDragAndDropController.h"


NS_ASSUME_NONNULL_BEGIN


@interface DNDDragAndDropController ()

@property (nonatomic, readonly) UIView *dragPaneView;

- (nullable UIView *)dropTargetAtLocation:(CGPoint)location;
- (nullable id<DNDDropTargetDelegate>)delegateForDropTarget:(nullable UIView *)target;

@end


NS_ASSUME_NONNULL_END
