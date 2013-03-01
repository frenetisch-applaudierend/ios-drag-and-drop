//
//  DNDDragSampleViewController.m
//  iOS Sample Application
//
//  Created by Markus Gasser on 3/1/13.
//  Copyright (c) 2013 Team RG. All rights reserved.
//

#import "DNDDragSampleViewController.h"
#import <DragAndDrop/DragAndDrop.h>


@interface DNDDragSampleViewController () <DNDDragSourceDelegate>
@end


@implementation DNDDragSampleViewController {
    DNDDragAndDropController *_dragAndDropController;
    __weak UIView *_dragSource;
}

#pragma mark - Initialization

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        self.title = @"Drag Sample";
        _dragAndDropController = [[DNDDragAndDropController alloc] init];
    }
    return self;
}


#pragma mark - View Lifecycle

- (void)loadView {
    self.view = [[UIView alloc] init];
    self.view.backgroundColor = [UIColor blackColor];
    
    UIView *dragSource = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 200.0f)];
    dragSource.center = CGPointZero;
    dragSource.backgroundColor = [UIColor whiteColor];
    dragSource.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin
                                   | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    [self.view addSubview:dragSource];
    _dragSource = dragSource;
    
    [_dragAndDropController registerDragSource:dragSource withDelegate:self];
}


#pragma mark - Drag Source Delegate

- (UIView *)dragAndDropController:(DNDDragAndDropController *)controller viewForDraggingWithContext:(DNDDragContext *)context {
    UIView *dragView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 100.0f)];
    dragView.backgroundColor = [UIColor orangeColor];
    dragView.alpha = 0.0f;
    [UIView animateWithDuration:0.2 animations:^{
        dragView.alpha = 1.0f;
    }];
    return dragView;
}

- (void)dragAndDropController:(DNDDragAndDropController *)controller cancelDraggingWithContext:(DNDDragContext *)context {
    [context cancelDraggingAnimatedWithDuration:0.2 animations:^{
        context.draggingView.alpha = 0.0f;
        context.draggingView.center = [context convertPoint:_dragSource.center fromView:self.view];
    }];
}

@end
