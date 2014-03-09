//
//  DNDDragHandler.h
//  ios-drag-and-drop
//
//  Created by Markus Gasser on 3/1/13.
//  Copyright (c) 2013 konoma GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DNDDragAndDropController;
@protocol DNDDragSourceDelegate;
@class DNDDragOperation;


@interface DNDDragHandler : NSObject

- (instancetype)initWithController:(DNDDragAndDropController *)controller
                        sourceView:(UIView *)source
                    dragRecognizer:(UIGestureRecognizer *)dragRecognizer
                          delegate:(id<DNDDragSourceDelegate>)delegate;

@property (nonatomic, readonly, weak) DNDDragAndDropController *controller;
@property (nonatomic, readonly, weak) UIView *dragSourceView;
@property (nonatomic, readonly, weak) id<DNDDragSourceDelegate> dragDelegate;
@property (nonatomic, readonly, strong) UIGestureRecognizer *dragRecognizer;

- (void)cancelDragging;

@end
