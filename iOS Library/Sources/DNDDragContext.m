//
//  DNDDragContext.m
//  iOS Library
//
//  Created by Markus Gasser on 3/1/13.
//  Copyright (c) 2013 Team RG. All rights reserved.
//

#import "DNDDragContext_Private.h"


@implementation DNDDragContext

#pragma mark - Initialization

- (instancetype)init {
    if ((self = [super init])) {
        _userInfo = [NSMutableDictionary dictionary];
    }
    return self;
}

@end
