//
//  DNDDropSampleViewController.h
//  iOS Sample Application
//
//  Created by Markus Gasser on 3/1/13.
//  Copyright (c) 2013 Team RG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DragAndDrop/DragAndDrop.h>


@interface DNDDropSampleViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIView *dragSourceView;
@property (nonatomic, strong) IBOutletCollection(UIView) NSArray *dropTargetViews;
@property (nonatomic, strong) IBOutlet DNDDragAndDropController *dragAndDropController;

@end
