//
//  UIViewController+DNDDragAndDrop.m
//  iOS Library
//
//  Created by Markus Gasser on 3/3/13.
//  Copyright (c) 2013 Team RG. All rights reserved.
//

#import "UIViewController+DNDDragAndDrop.h"
#import <objc/runtime.h>


static const NSUInteger DNDDragAndDropControllerKey;


@implementation UIViewController (DNDDragAndDrop)

- (DNDDragAndDropController *)dragAndDropController {
    return objc_getAssociatedObject(self, &DNDDragAndDropControllerKey);
}

- (void)setDragAndDropController:(DNDDragAndDropController *)dragAndDropController {
    objc_setAssociatedObject(self, &DNDDragAndDropControllerKey, dragAndDropController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
