//
//  DNDDragContext.h
//  iOS Library
//
//  Created by Markus Gasser on 3/1/13.
//  Copyright (c) 2013 Team RG. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DNDDragContext : NSObject

@property (nonatomic, readonly) UIView *dragSourceView;
@property (nonatomic, readonly) UIView *draggingView;
@property (nonatomic, readonly) NSMutableDictionary *userInfo;

- (void)cancelDragging;
- (void)cancelDraggingAnimatedWithDuration:(NSTimeInterval)duration animations:(void(^)())animations;
- (BOOL)isDraggingCancelled;


#pragma mark - Conversion Helpers

- (CGPoint)convertPoint:(CGPoint)point toView:(UIView *)view;
- (CGPoint)convertPoint:(CGPoint)point fromView:(UIView *)view;
- (CGRect)convertRect:(CGRect)rect toView:(UIView *)view;
- (CGRect)convertRect:(CGRect)rect fromView:(UIView *)view;

@end
