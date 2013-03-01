//
//  DNDDragHandler.h
//  iOS Library
//
//  Created by Markus Gasser on 3/1/13.
//  Copyright (c) 2013 Team RG. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol DNDDragSourceDelegate;
@class DNDDragContext;


@interface DNDDragHandler : NSObject

- (instancetype)initWithDragSourceView:(UIView *)dragSource dragSourceDelegate:(id<DNDDragSourceDelegate>)dragDelegate;

@property (nonatomic, readonly, weak) UIView *dragSourceView;
@property (nonatomic, readonly, weak) id<DNDDragSourceDelegate> dragSourceDelegate;
@property (nonatomic, readonly) UIPanGestureRecognizer *dragRecognizer;

@end
