//
//  DNDDragContext.h
//  iOS Library
//
//  Created by Markus Gasser on 3/1/13.
//  Copyright (c) 2013 Team RG. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DNDDragContext : NSObject

@property (nonatomic, readonly) UIView *dragView;
@property (nonatomic, readonly) NSMutableDictionary *userInfo;

@end
