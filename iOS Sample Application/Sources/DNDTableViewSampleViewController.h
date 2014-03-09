//
//  DNDTableViewSampleViewController.h
//  iOS Sample Application
//
//  Created by Markus Gasser on 09.03.14.
//  Copyright (c) 2014 konoma GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DNDDragAndDrop/DNDDragAndDrop.h>


@interface DNDTableViewSampleViewController : UIViewController

@property (nonatomic, weak) IBOutlet UITableView *leftTableView;
@property (nonatomic, weak) IBOutlet UITableView *rightTableView;
@property (nonatomic, strong) IBOutlet DNDDragAndDropController *dragAndDropController;

@end
