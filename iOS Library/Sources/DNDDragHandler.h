//
//  DNDDragHandler.h
//  ios-drag-and-drop
//
//  Created by Markus Gasser on 3/1/13.
//  Copyright (c) 2013 Team RG. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DNDDragAndDropController;
@protocol DNDDragSourceDelegate;
@class DNDDragOperation;


@interface DNDDragHandler : NSObject

- (instancetype)initWithController:(DNDDragAndDropController *)controller sourceView:(UIView *)source delegate:(id<DNDDragSourceDelegate>)delegate;

@property (nonatomic, readonly, weak) DNDDragAndDropController *controller;
@property (nonatomic, readonly, weak) UIView *sourceView;
@property (nonatomic, readonly, weak) id<DNDDragSourceDelegate> dragDelegate;

- (void)cancelDragging;

@end
