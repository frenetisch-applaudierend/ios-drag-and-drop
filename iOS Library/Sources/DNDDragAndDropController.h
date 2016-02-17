//
//  DNDDragAndDropController.h
//  ios-drag-and-drop
//
//  Created by Markus Gasser on 3/1/13.
//  Copyright (c) 2013 konoma GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol DNDDragSourceDelegate;
@protocol DNDDropTargetDelegate;
@class DNDDragOperation;


NS_ASSUME_NONNULL_BEGIN


/**
 The main drag and drop controller object.
 
 Ususally you will have one of those objects for each drag and drop context.
 Each controller maintains its own drag sources and drop targets. This means
 you can only drag and drop within the same controller. Registering a drag source
 in one controller and a drop target in another controller won't work.
 */
@interface DNDDragAndDropController : NSObject

#pragma mark - Initialization

/**
 Initialize a new instance with a given window.
 
 @param window The window is used to move the dragged views around. Cannot be `nil`.
 */
- (instancetype)initWithWindow:(UIWindow *)window;

/**
 Initialize a new instance with the application's key window.
 
 Has the same effect as calling `-initWithWindow:` with `[[UIApplication sharedApplication] keyWindow]`.
 */
- (instancetype)init;


#pragma mark - Registering and Unregistering Drag Sources and Drop Targets

/**
 Register a view to be used as source for a dragging operation.
 
 This will add the specified or a default gesture recognizer on the source view. Therefore user interaction
 must be enabled on the source view for dragging to work.
 
 @param source     The view where a dragging operation can be started. Cannot be `nil`.
 @param delegate   The delegate object controlling the dragging part of the operation. Cannot be `nil`.
 @param recognizer The gesture recognizer handling the drag operation. If nil, a `UIPanGestureRecognizer` is used.
 */
- (void)registerDragSource:(UIView *)source withDelegate:(id<DNDDragSourceDelegate>)delegate dragRecognizer:(nullable UIGestureRecognizer *)recognizer;

/**
 Register a view to be used as source for a dragging operation with the default drag recognizer.
 
 Has the same effect as calling `-registerDragSource:withDelegate:dragRecognizer:` with a `nil` recognizer.
 
 @param source   The view where a dragging operation can be started. Cannot be `nil`.
 @param delegate The delegate object controlling the dragging part of the operation. Cannot be `nil`.
 */
- (void)registerDragSource:(UIView *)source withDelegate:(id<DNDDragSourceDelegate>)delegate;

/**
 Remove a registered drag source.
 
 If the passed view is not registered, this method does nothing.
 */
- (void)unregisterDragSource:(UIView *)source;

/**
 Register a view to be used as target for a dropping operation.
 
 After registering you can drop a dragged view onto the registered target.
 User interaction must be enabled on the target view for dropping to work.
 
 @param source   The view where a dragged view can be dropped onto. Cannot be `nil`.
 @param delegate The delegate object controlling the dropping part of the operation. Cannot be `nil`.
 */
- (void)registerDropTarget:(UIView *)target withDelegate:(id<DNDDropTargetDelegate>)delegate;

/**
 Remove a registered drop target.
 
 If the passed view is not registered, this method does nothing.
 */
- (void)unregisterDropTarget:(UIView *)target;

@end


#pragma mark - Delegate Protocols

/**
 Protocol for the delegate object controlling the dragging part of the drag and drop operation.
 */
@protocol DNDDragSourceDelegate <NSObject>

@required

/**
 Return the view to be dragged around the screen for the given drag operation.
 
 The returned view is removed from the current superview and added to the view acting as the dragging container.
 If `nil` is returned, the dragging operation is canceled.
 
 If you would like to animate the entry of the view (e.g. a fade-in) you can do so in this method.
 
 @param operation The drag operation needing the drag view.
 @return A view to be dragged on the screen, or `nil` to cancel the operation.
 
 @discussion If you return the drag source itself, be aware that it is removed from its superview while being dragged around.
             After its dropped (on a target or elsewhere) it won't be added back to the original superview. So if you still
             need the source view after dragging, you need to make sure the view is added to another superview after dropping.
 */
- (nullable UIView *)draggingViewForDragOperation:(DNDDragOperation *)operation;

@optional

/**
 Optionally handle cancellation of a drag operation.
 
 This method is called when the user lets go of a drag view while not
 over a vaild drop target. Here you have the chance to e.g. animate the cancellation
 or to execute some other necessary operations.
 
 To animate the cancellation use the remove* methods provided by the drag operation
 (see `DNDDragOperation` for more information). When this method returns and no removal method
 was called yet, then the view will simply be removed from the superview.
 
 @param operation The drag operation being canceled.
 */
- (void)dragOperationWillCancel:(DNDDragOperation *)operation;

@end


/**
 Protocol for the delegate object controlling the dropping part of the drag and drop operation.
 */
@protocol DNDDropTargetDelegate <NSObject>

@required

/**
 Notification when a drag operation drops its view in a valid target.
 
 You use this delegate method to react to the dropping of a dragged view. If you want
 to remove the drag view yourself you need to call one of the remove methods of the operation
 (see `DNDDragOperation` for more information). When this method returns and no removal method
 was called yet, then the view will simply be removed from the superview.
 
 @param operation The current drag operation
 @param target    The drop target view where the drop was made
 */
- (void)dragOperation:(DNDDragOperation *)operation didDropInDropTarget:(UIView *)target;

@optional

/**
 Optional notification when the user enters a drop target during a drag operation.
 
 @param operation The current drag operation
 @param target    The drop target view being entered
 */
- (void)dragOperation:(DNDDragOperation *)operation didEnterDropTarget:(UIView *)target;

/**
 Optional notification when the user leaves a drop target during a drag operation.
 
 @param operation The current drag operation
 @param target    The drop target view being left
 */
- (void)dragOperation:(DNDDragOperation *)operation didLeaveDropTarget:(UIView *)target;

/**
 Optionally allow or disallow moving within certain parts of a drop target.
 
 Using this method you can disallow positioning the dragging view above a certain part of your
 drop target. If the method is not implemented, by default any position is allowed.
 
 You can get the current position of the drag view using `-[DNDDragOperation locationInView:]`.
 
 @param operation The current drag operation
 @param target    The drop target view being moved in
 @return `YES` if you want to allow the drag view being placed at the current position or `NO` otherwise.
 */
- (BOOL)dragOperation:(DNDDragOperation *)operation shouldPositionDragViewInDropTarget:(UIView *)target;

@end


NS_ASSUME_NONNULL_END
