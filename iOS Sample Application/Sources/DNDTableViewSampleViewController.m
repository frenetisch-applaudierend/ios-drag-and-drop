//
//  DNDTableViewSampleViewController.m
//  iOS Sample Application
//
//  Created by Markus Gasser on 09.03.14.
//  Copyright (c) 2014 konoma GmbH. All rights reserved.
//

#import "DNDTableViewSampleViewController.h"
#import "DNDSampleDragView.h"


@interface DNDTableViewSampleViewController () <UITableViewDataSource, DNDDragSourceDelegate, DNDDropTargetDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, readonly) NSMutableArray *leftItems;
@property (nonatomic, readonly) NSMutableArray *rightItems;
@property (nonatomic, copy) NSIndexPath *sourceIndexPath;

@end

@implementation DNDTableViewSampleViewController

#pragma mark - Initialization

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        self.title = @"Table Views";
        
        _leftItems = [NSMutableArray arrayWithObjects:@"So", @"Long", @"And", @"Thanks", @"For", @"All", @"The", @"Fish", nil];
        _rightItems = [NSMutableArray array];
    }
    return self;
}


#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.leftTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ItemCell"];
    [self registerTableViewForDragging:self.leftTableView];
    
    [self.rightTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ItemCell"];
    [self registerTableViewForDragging:self.rightTableView];
}

- (void)registerTableViewForDragging:(UITableView *)tableView {
    DNDLongPressDragRecognizer *dragRecognizer = [[DNDLongPressDragRecognizer alloc] init];
    dragRecognizer.minimumPressDuration = 0.05;
    [tableView.panGestureRecognizer requireGestureRecognizerToFail:dragRecognizer]; // prevent UITableView from hijacking Touches
    
    [self.dragAndDropController registerDragSource:tableView withDelegate:self dragRecognizer:dragRecognizer];
    [self.dragAndDropController registerDropTarget:tableView withDelegate:self];
}


#pragma mark - UITableViewDataSource

- (NSMutableArray *)itemsForTableView:(UITableView *)tableView {
    return (tableView == self.leftTableView ? self.leftItems : self.rightItems);
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self itemsForTableView:tableView] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell"];
    cell.textLabel.text = [[self itemsForTableView:tableView] objectAtIndex:indexPath.row];
    return cell;
}


#pragma mark - Drag and Drop

- (UIView *)draggingViewForDragOperation:(DNDDragOperation *)operation {
    UITableView *tableView = (UITableView *)operation.dragSourceView;
    NSMutableArray *items = [self itemsForTableView:tableView];
    
    NSIndexPath *indexPath = [tableView indexPathForRowAtPoint:[operation locationInView:tableView]];
    if (indexPath == nil) {
        return nil;
    }
    
    NSString *item = [items objectAtIndex:indexPath.row];
    [items removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    self.sourceIndexPath = indexPath;
    
    DNDSampleDragView *dragView = [[DNDSampleDragView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 150.0f, 75.0f)];
    dragView.text = item;
    return dragView;
}

- (void)dragOperationWillCancel:(DNDDragOperation *)operation {
    DNDSampleDragView *dragView = (DNDSampleDragView *)operation.draggingView;
    UITableView *tableView = (UITableView *)operation.dragSourceView;
    NSMutableArray *items = [self itemsForTableView:tableView];
    
    [items insertObject:dragView.text atIndex:self.sourceIndexPath.row];
    [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:self.sourceIndexPath]
                     withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [operation removeDraggingView];
}

- (void)dragOperation:(DNDDragOperation *)operation didDropInDropTarget:(UITableView *)target {
    DNDSampleDragView *dragView = (DNDSampleDragView *)operation.draggingView;
    UITableView *tableView = (UITableView *)operation.dropTargetView;
    NSMutableArray *items = [self itemsForTableView:tableView];
    
    
    NSIndexPath *indexPath = [tableView indexPathForRowAtPoint:[operation locationInView:tableView]];
    if (indexPath == nil) {
        indexPath = [NSIndexPath indexPathForRow:[tableView numberOfRowsInSection:0] inSection:0];
    }
    
    [items insertObject:dragView.text atIndex:indexPath.row];
    [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [operation removeDraggingView];
}

@end
