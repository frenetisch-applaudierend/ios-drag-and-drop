//
//  DNDDragSampleViewController.h
//  iOS Sample Application
//
//  Created by Markus Gasser on 3/1/13.
//  Copyright (c) 2013 konoma GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DragAndDrop/DragAndDrop.h>


@interface DNDDragSampleViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIView *dragSourceView;
@property (nonatomic, strong) IBOutlet DNDDragAndDropController *dragAndDropController;

@end
