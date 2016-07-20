//
//  DNDLongPressDragRecognizer.h
//  iOS Library
//
//  Created by Markus Gasser on 09.03.14.
//  Copyright (c) 2014 konoma GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

/**
 A gesture recognizer combining a long press and a pan gesture.
 
 To begin the gesture, the user must long press for a given duration. Then moving the finger updates
 the gesture recognizer until the user lifts the finger again.
 
 This gesture recognizer is useful when working with `UITableView` or `UICollectionView` as the drag source,
 as it allows the user to pan without the gesture being recognized as a drag.
 */
@interface DNDLongPressDragRecognizer : UIGestureRecognizer

/// How long the user must long press before the drag gesture starts. Default is 0.5 seconds.
@property (nonatomic, assign) NSTimeInterval minimumPressDuration;

/// How far the user is allowed to "wiggle" their finger while long pressing. Default is 10pt.
@property (nonatomic, assign) CGFloat allowableMovement;

@end


NS_ASSUME_NONNULL_END
