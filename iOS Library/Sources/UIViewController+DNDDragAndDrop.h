//
//  UIViewController+DNDDragAndDrop.h
//  iOS Library
//
//  Created by Markus Gasser on 3/3/13.
//  Copyright (c) 2013 Team RG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DNDDragAndDropController.h"


@interface UIViewController (DNDDragAndDrop)

@property (nonatomic, strong) IBOutlet DNDDragAndDropController *dragAndDropController;

@end
