//
//  DNDStackSampleView.h
//  iOS Sample Application
//
//  Created by Markus Gasser on 3/5/13.
//  Copyright (c) 2013 Team RG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DNDStackSampleView : UIView

- (void)addStackedView:(UIView *)view animated:(BOOL)animated;
- (void)removeStackedView:(UIView *)view animated:(BOOL)animated;
- (UIView *)stackedViewAtPoint:(CGPoint)point;

@end
