//
//  DNDBlindSpotSampleViewController.h
//  iOS Sample Application
//
//  Created by Markus Gasser on 3/3/13.
//  Copyright (c) 2013 konoma GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DNDDragAndDrop/DNDDragAndDrop.h>


@interface DNDBlindSpotSampleViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIView *dragSourceView;
@property (nonatomic, weak) IBOutlet UIView *dropTargetView;
@property (nonatomic, weak) IBOutlet UIView *blindSpotView;
@property (nonatomic, strong) IBOutlet DNDDragAndDropController *dragAndDropController;

@end
