//
//  DNDBlindSpotSampleViewController.h
//  iOS Sample Application
//
//  Created by Markus Gasser on 3/3/13.
//  Copyright (c) 2013 Team RG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DragAndDrop/DragAndDrop.h>


@interface DNDBlindSpotSampleViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIView *dragSourceView;
@property (nonatomic, weak) IBOutlet UIView *blindSpotView;
@end
