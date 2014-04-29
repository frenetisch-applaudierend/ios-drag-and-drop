# iOS Drag and Drop Library

This is a library that helps you support drag and drop operations in your iOS applications. This software is licensed under a MIT license (see the LICENSE file for more info).


## Installation

To install it using CococaPods add the following to your `Podfile`:

    pod 'DNDDragAndDrop', '~> 1.1.0'

Thanks to Hok Shun Poon for providing the podspec.


## Usage

The main class to interact with is the `DNDDragAndDropController`. You provide the controller with two kinds of views to work with:

* **Drag Sources**: These are the views that can be used to begin a dragging operation
* **Drop Targets**: These are the views where you can drop something


### Registering

When registering you need to provide a delegate for both. The `DNDDragSourceDelegate` is responsible for providing a view that can be dragged around the screen and to handle when a dragging operation was canceled. The `DNDDropTargetDelegate` on the other hand is used to react to events related to the drop target, like the user entering or leaving the region of a drop target with his fingers, or that a view was just dropped onto a target.

    self.dragAndDropController = [[DNDDragAndDropController alloc] init];
    [self.dragAndDropController registerDragSource:mySourceView withDelegate:self];
    [self.dragAndDropController registerDropTarget:myDropTarget withDelegate:self];

If necessary you can provide your own gesture recognizer for dragging. The passed recognizer must be a continuous gesture recognizer (like a `UIPanGestureRecognizer`).

    [self.dragAndDropController registerDragSource:mySourceView withDelegate:self dragRecognizer:myRecognizer];

By default a `UIPanGestureRecognizer` is used.


### Dragging

To interact, the user will start panning over a drag source, which in turn will ask the delegate to provide a view to be used while dragging around. You provide one with the `-draggingViewForDragOperation:` method declared in the `DNDDragSourceDelegate` protocol.

    - (UIView *)draggingViewForDragOperation:(DNDDragOperation *)operation {
        // Create a drag view
        CGRect frame = CGRectMake(0.0f, 0.0f, 150.0f, 75.0f);
        UIView *dragView = [[UIView alloc] initWithFrame:frame];
        dragView.backgroundColor = [UIColor orangeColor];
        
        // Let it fade in
        dragView.alpha = 0.0f;
        [UIView animateWithDuration:0.2 animations:^{
            dragView.alpha = 1.0f;
        }];
        
        return dragView;
    }

If you would like to have the dragged view appear animated, you can do so directly in this method.

Now the user moves the drag view around the screen. When the drag view enters or leaves a registered drop target, the respective delegate methods from `DNDDropTargetDelegate` are called. You can for example change the appearance of the target view in these methods.

    - (void)dragOperation:(DNDDragOperation *)operation didEnterDropTarget:(UIView *)target {
        target.layer.borderColor = [operation.draggingView.backgroundColor CGColor];
    }
    
    - (void)dragOperation:(DNDDragOperation *)operation didLeaveDropTarget:(UIView *)target {
        target.layer.borderColor = [[UIColor whiteColor] CGColor];
    }


### Dropping

When the user now drops the drag view at some point, one of two things will happen.

If the drag view was dropped above a vaild drop target, the method `-dragOperation:didDropInDropTarget:` of the drop targets delegate will be called. You can use this method for one to implement anything that needs to happen when a view is dropped on this target, and secondly for example to animate the removal of the drag view.

    - (void)dragOperation:(DNDDragOperation *)operation didDropInDropTarget:(UIView *)target {
        // Fade out
        [operation removeDraggingViewAnimatedWithDuration:0.2 animations:^(UIView *dv) {
            dv.alpha = 0.0f;
        }];
    }

If the drag view was dropped outside any valid drop targets then the drag was canceled and the drag source delegate is notified of this fact using the `-dragOperationWillCancel:` delegate method. Analog to dropping on a target, you use this method to implement anything related to cancelling a drag and to animate the removal of the drag view.

    - (void)dragOperationWillCancel:(DNDDragOperation *)operation {
        [operation removeDraggingViewAnimatedWithDuration:0.2 animations:^(UIView *dv) {
            dv.alpha = 0.0f;
            dv.center = self.dragSourceView.center; // jump back to the source view
        }];
    }


### Removing a drag view

To remove a drag view (either in `-dragOperation:didDropInDropTarget:` or in `-dragOperationWillCancel:`) you have a few options on `DNDDragOperation`.

If you don't do anything until the method returns, then by default for both methods the operations `-removeDraggingView` is called which removes the drag view without any animations.

If you'd like to animate the removal you can use `-removeDraggingViewAnimatedWithDuration:animations:` which allows you to pass an animation block.

Third, for most control you can use the `-beginRemovingDraggingView`/`-completeRemovingDraggingView` method pair. Once you called `-beginRemovingDraggingView` the dragging view is considered "being removed" and you can return from the method without a default action happening. Then at any point you can remove the dragging view by calling `-completeRemovingDraggingView`. This can be useful if you need to chain animations for example.


## Examples

Check the *iOS Sample Application* project for a few samples of simple drag and drop operations.