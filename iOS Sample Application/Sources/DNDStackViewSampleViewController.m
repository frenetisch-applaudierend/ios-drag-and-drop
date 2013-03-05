//
//  DNDStackViewSampleViewController.m
//  iOS Sample Application
//
//  Created by Markus Gasser on 3/5/13.
//  Copyright (c) 2013 Team RG. All rights reserved.
//

#import "DNDStackViewSampleViewController.h"
#import "DNDStackSampleView.h"
#import "DNDSampleDragView.h"


@interface DNDStackViewSampleViewController () <DNDDragSourceDelegate, DNDDropTargetDelegate>
@end


@implementation DNDStackViewSampleViewController

#pragma mark - Initialization

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        self.title = @"Stacks";
    }
    return self;
}


#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    const CGRect DragViewFrame = CGRectMake(0.0f, 0.0f, 150.0f, 75.0f);
    for (NSUInteger i = 0; i < 8; i++) {
        [self.leftStackView addStackedView:[[DNDSampleDragView alloc] initWithFrame:DragViewFrame] animated:NO];
    }
    
    [self.dragAndDropController registerDragSource:self.leftStackView withDelegate:self];
    [self.dragAndDropController registerDropTarget:self.leftStackView withDelegate:self];
    [self.dragAndDropController registerDragSource:self.rightStackView withDelegate:self];
    [self.dragAndDropController registerDropTarget:self.rightStackView withDelegate:self];
}


#pragma mark - Drag and Drop

- (UIView *)draggingViewForDragOperation:(DNDDragOperation *)operation {
    DNDStackSampleView *stackView = (DNDStackSampleView *)operation.dragSourceView;
    UIView *view = [stackView stackedViewAtPoint:[operation locationInView:stackView]];
    [stackView removeStackedView:view animated:YES];
    return view;
}

- (void)dragOperationWillCancel:(DNDDragOperation *)operation {
    DNDStackSampleView *stackView = (DNDStackSampleView *)operation.dragSourceView;
    operation.draggingView.center = [operation locationInView:stackView];
    [operation removeDraggingView];
    [stackView addStackedView:operation.draggingView animated:YES];
}

- (void)dragOperation:(DNDDragOperation *)operation didDropInDropTarget:(UIView *)target {
    DNDStackSampleView *stackView = (DNDStackSampleView *)operation.dropTargetView;
    operation.draggingView.center = [operation locationInView:stackView];
    [operation removeDraggingView];
    [stackView addStackedView:operation.draggingView animated:YES];
}

@end
