//
//  DNDDragOperation_Private.h
//  ios-drag-and-drop
//
//  Created by Markus Gasser on 3/1/13.
//  Copyright (c) 2013 Team RG. All rights reserved.
//

#import "DNDDragOperation.h"
#import "DNDDragHandler.h"


@interface DNDDragOperation ()

- (instancetype)initWithDragHandler:(DNDDragHandler *)handler;

@property (nonatomic, strong) UIView *draggingView;
@property (nonatomic, weak) DNDDragHandler *dragHandler;

@end
