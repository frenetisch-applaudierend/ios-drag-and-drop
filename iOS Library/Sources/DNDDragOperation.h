//
//  DNDDragOperation.h
//  ios-drag-and-drop
//
//  Created by Markus Gasser on 3/1/13.
//  Copyright (c) 2013 konoma GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DNDDragOperation : NSObject

#pragma mark - Query Drag Operation Information

@property (nonatomic, readonly) UIView *dragSourceView;        // The drag source where this operation originated from
@property (nonatomic, readonly) UIView *draggingView;          // The currently dragged view
@property (nonatomic, readonly) UIView *dropTargetView;        // The current drop target (nil if not over a dorp target)
@property (nonatomic, readonly) NSMutableDictionary *userInfo; // Place to store any additional information

/**
 * The current location of the drag operation relative to the given view.
 */
- (CGPoint)locationInView:(UIView *)view;


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
- (void)removeDraggingViewAnimatedWithDuration:(NSTimeInterval)duration animations:(void(^)(UIView *draggingView))animations;
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

/**
 * Convert points and rects to and from the drag pane view (the dragging views superview).
 */
- (CGPoint)convertPoint:(CGPoint)point toView:(UIView *)view;
- (CGPoint)convertPoint:(CGPoint)point fromView:(UIView *)view;
- (CGRect)convertRect:(CGRect)rect toView:(UIView *)view;
- (CGRect)convertRect:(CGRect)rect fromView:(UIView *)view;

@end
