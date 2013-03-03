//
//  DNDDragOperation.h
//  ios-drag-and-drop
//
//  Created by Markus Gasser on 3/1/13.
//  Copyright (c) 2013 Team RG. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DNDDragOperation : NSObject

@property (nonatomic, readonly) UIView *dragSourceView;
@property (nonatomic, readonly) UIView *draggingView;
@property (nonatomic, readonly) NSMutableDictionary *userInfo;


#pragma mark - Removing the Dragging View

/**
 * Returns YES if the dragging view was or is being removed.
 *
 * Either calling one of the -removeDraggingView / -removeDraggingViewAnimatedWithDuration:animations:
 * or -beginRemovingDraggingView will cause this method to return YES.
 */
- (BOOL)isDraggingViewRemoved;

/**
 * Remove the dragging view from the screen.
 *
 * This will effectively cancel the current dragging operation.
 * The delegate is not called when cancelling the drag operation in this way.
 *
 * You can optionally perfom the removal animated. For even more control over the removal use
 * -beginRemovingDraggingView and -completeRemovingDraggingView.
 */
- (void)removeDraggingViewAnimatedWithDuration:(NSTimeInterval)duration animations:(void(^)())animations;
- (void)removeDraggingView;


/**
 * Remove the dragging view with the most control.
 *
 * Calling -beginRemovingDraggingView will prepare the operation for removal.
 * After this you can perform any animations or transitions on the dragging view.
 * -completeRemovingDraggingView will then remove the dragging view from the screen.
 */
- (void)beginRemovingDraggingView;
- (void)completeRemovingDraggingView;


#pragma mark - Conversion Helpers

- (CGPoint)convertPoint:(CGPoint)point toView:(UIView *)view;
- (CGPoint)convertPoint:(CGPoint)point fromView:(UIView *)view;
- (CGRect)convertRect:(CGRect)rect toView:(UIView *)view;
- (CGRect)convertRect:(CGRect)rect fromView:(UIView *)view;

@end
