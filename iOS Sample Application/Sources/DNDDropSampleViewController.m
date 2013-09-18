//
//  DNDDropSampleViewController.m
//  iOS Sample Application
//
//  Created by Markus Gasser on 3/1/13.
//  Copyright (c) 2013 Team RG. All rights reserved.
//

#import "DNDDropSampleViewController.h"
#import "DNDSampleDragView.h"
#import <QuartzCore/QuartzCore.h>


@interface DNDDropSampleViewController () <DNDDragSourceDelegate, DNDDropTargetDelegate>
@end


@implementation DNDDropSampleViewController

#pragma mark - Initialization

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        self.title = @"Drag and Drop";
    }
    return self;
}


#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.dragAndDropController registerDragSource:self.dragSourceView withDelegate:self];
    for (UIView *dropTargetView in self.dropTargetViews) {
        dropTargetView.layer.borderColor = [[UIColor whiteColor] CGColor];
        dropTargetView.layer.borderWidth = 4.0f;
        [self.dragAndDropController registerDropTarget:dropTargetView withDelegate:self];
    }
}


#pragma mark - Drag Source Delegate

- (UIView *)draggingViewForDragOperation:(DNDDragOperation *)operation {
    UIView *dragView = [[DNDSampleDragView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 150.0f, 75.0f)];
    dragView.alpha = 0.0f;
    [UIView animateWithDuration:0.2 animations:^{
        dragView.alpha = 1.0f;
    }];
    return dragView;
}

- (void)dragOperationWillCancel:(DNDDragOperation *)operation {
    [operation removeDraggingViewAnimatedWithDuration:0.2 animations:^(UIView *draggingView) {
        draggingView.alpha = 0.0f;
        draggingView.center = [operation convertPoint:self.dragSourceView.center fromView:self.view];
    }];
}


#pragma mark - Drop Target Delegate

- (void)dragOperation:(DNDDragOperation *)operation didDropInDropTarget:(UIView *)target {
    target.backgroundColor = operation.draggingView.backgroundColor;
    target.layer.borderColor = [[UIColor whiteColor] CGColor];
}

- (void)dragOperation:(DNDDragOperation *)operation didEnterDropTarget:(UIView *)target {
    target.layer.borderColor = [operation.draggingView.backgroundColor CGColor];
}

- (void)dragOperation:(DNDDragOperation *)operation didLeaveDropTarget:(UIView *)target {
    target.layer.borderColor = [[UIColor whiteColor] CGColor];
}

@end
