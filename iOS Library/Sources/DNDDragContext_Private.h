//
//  DNDDragContext_Private.h
//  iOS Library
//
//  Created by Markus Gasser on 3/1/13.
//  Copyright (c) 2013 Team RG. All rights reserved.
//

#import "DNDDragContext.h"
#import "DNDDragHandler.h"


@interface DNDDragContext ()

- (instancetype)initWithDragHandler:(DNDDragHandler *)handler;

@property (nonatomic, strong) UIView *draggingView;
@property (nonatomic, weak) DNDDragHandler *dragHandler;

@end
