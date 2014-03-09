//
//  DNDDragAndDropController_Private.h
//  ios-drag-and-drop
//
//  Created by Markus Gasser on 3/1/13.
//  Copyright (c) 2013 konoma GmbH. All rights reserved.
//


#import "DNDDragAndDropController.h"


@interface DNDDragAndDropController ()

@property (nonatomic, readonly) UIView *dragPaneView;

- (UIView *)dropTargetAtLocation:(CGPoint)location;
- (id<DNDDropTargetDelegate>)delegateForDropTarget:(UIView *)target;

@end
