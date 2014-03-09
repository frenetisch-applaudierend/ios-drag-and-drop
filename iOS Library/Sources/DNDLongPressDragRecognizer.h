//
//  DNDLongPressDragRecognizer.h
//  iOS Library
//
//  Created by Markus Gasser on 09.03.14.
//  Copyright (c) 2014 konoma GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DNDLongPressDragRecognizer : UIGestureRecognizer

/** How long the user must long press before the drag gesture starts.
 *  Defaults to 0.5 seconds.
 */
@property (nonatomic, assign) NSTimeInterval minimumPressDuration;

@end
