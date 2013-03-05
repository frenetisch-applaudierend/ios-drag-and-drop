//
//  DNDAppDelegate.m
//  iOS Sample Application
//
//  Created by Markus Gasser on 3/1/13.
//  Copyright (c) 2013 Team RG. All rights reserved.
//

#import "DNDAppDelegate.h"
#import "DNDDragSampleViewController.h"
#import "DNDDropSampleViewController.h"
#import "DNDBlindSpotSampleViewController.h"
#import "DNDStackViewSampleViewController.h"


@implementation DNDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[
        [[DNDDragSampleViewController alloc] init],
        [[DNDDropSampleViewController alloc] init],
        [[DNDBlindSpotSampleViewController alloc] init],
        [[DNDStackViewSampleViewController alloc] init]
    ];
    self.window.rootViewController = tabBarController;
    
    return YES;
}

@end
