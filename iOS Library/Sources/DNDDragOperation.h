//
//  DNDDragOperation.h
//  ios-drag-and-drop
//
//  Created by Markus Gasser on 3/1/13.
//  Copyright (c) 2013 konoma GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN


/**
 Object used to control a drag and drop operation.
 */
@interface DNDDragOperation : NSObject

#pragma mark - Query Drag Operation Information

/// The drag source where this operation originated from
@property (nonatomic, readonly) UIView *dragSourceView;

/// The currently dragged view
@property (nonatomic, readonly) UIView *draggingView;

/// The current drop target (`nil` if not over a dorp target)
@property (nonatomic, readonly, nullable) UIView *dropTargetView;

/// Place to store any additional information
@property (nonatomic, readonly) NSMutableDictionary *userInfo;


/**
 The current location of the drag operation relative to the given view.
 */
- (CGPoint)locationInView:(UIView *)view;


#pragma mark - Removing the Dragging View

/**
 Returns YES if the dragging view was or is being removed.
 
 Either calling one of the `-removeDraggingView` / `-removeDraggingViewAnimatedWithDuration:animations:`
 or `-beginRemovingDraggingView` will cause this method to return `YES`.
 */
- (BOOL)isDraggingViewRemoved;

/**
 Remove the dragging view from the screen.
 
 This will cancel the current dragging operation. The delegate is not called when cancelling the drag operation in this way.
 
 Using this method you can animate the removal of the dragging view. After the animations complete, the dragging view is
 removed from the view hierarchy. If you need more control over removal use `-beginRemovingDraggingView`
 and `-completeRemovingDraggingView` instead.
 
 @param duration   The animation duration
 @param animations The animations to perform when removing the dragging view
 */
- (void)removeDraggingViewAnimatedWithDuration:(NSTimeInterval)duration animations:(void(^)(UIView *draggingView))animations;

/**
 Remove the dragging view from the screen.
 
 This will cancel the current dragging operation. The delegate is not called when cancelling the drag operation in this way.
 
 This method removes the dragging view instantly from the view hierarchy. If you'd like to animate the removal use
 `-removeDraggingViewAnimatedWithDuration:animation:` or `-beginRemovingDraggingView` / `-completeRemovingDraggingView` instead.
 */
- (void)removeDraggingView;


/**
 Remove the dragging view with the most control.
 
 Calling `-beginRemovingDraggingView` will prepare the operation for removal. After this you can perform any animations
 or transitions on the dragging view. Call `-completeRemovingDraggingView` when done to remove the dragging view from the screen.
 */
- (void)beginRemovingDraggingView;

/**
 Complete the removal of the dragging view started using `-beginRemovingDraggingView`.
 
 Removes the dragging view from the view hierarchy.
 
 You only need to call this method when removing the dragging view by hand using `-beginRemovingDraggingView`.
 */
- (void)completeRemovingDraggingView;


#pragma mark - Conversion Helpers

/**
 Convert points and rects to and from the drag pane view (the dragging views superview).
 */
- (CGPoint)convertPoint:(CGPoint)point toView:(nullable UIView *)view;
- (CGPoint)convertPoint:(CGPoint)point fromView:(nullable UIView *)view;
- (CGRect)convertRect:(CGRect)rect toView:(nullable UIView *)view;
- (CGRect)convertRect:(CGRect)rect fromView:(nullable UIView *)view;

@end


NS_ASSUME_NONNULL_END
