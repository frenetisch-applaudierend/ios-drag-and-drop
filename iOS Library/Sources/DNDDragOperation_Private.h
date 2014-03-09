//
//  DNDDragOperation_Private.h
//  ios-drag-and-drop
//
//  Created by Markus Gasser on 3/1/13.
//  Copyright (c) 2013 konoma GmbH. All rights reserved.
//

#import "DNDDragOperation.h"
#import "DNDDragHandler.h"


@interface DNDDragOperation ()

- (instancetype)initWithDragHandler:(DNDDragHandler *)handler dragSourceView:(UIView *)source;

@property (nonatomic, strong) UIView *draggingView;
@property (nonatomic, strong) UIView *dropTargetView;
@property (nonatomic, assign) CGPoint dragLocation;
@property (nonatomic, weak) DNDDragHandler *dragHandler;

@end
