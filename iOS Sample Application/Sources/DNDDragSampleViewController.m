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
    dragSource.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    dragSource.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:dragSource];
    
    [_dragAndDropController registerDragSource:dragSource withDelegate:self];
}


#pragma mark - Drag Source Delegate

- (UIView *)dragAndDropController:(DNDDragAndDropController *)controller draggedViewForDragSource:(UIView *)dragSource context:(DNDDragContext *)ctx {
    UIView *dragView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 100.0f)];
    dragView.backgroundColor = [UIColor orangeColor];
    return dragView;
}

@end
