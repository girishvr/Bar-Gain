//
//  BarGainTabBarController.m
//  Bar Gain
//
//  Created by Nupur Mittal on 02/01/15.
//  Copyright (c) 2015 Anomaly. All rights reserved.
//

#import "BarGainTabBarController.h"

@implementation BarGainTabBarController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.delegate = self;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
//    [self.navigationController popToRootViewControllerAnimated:NO];
}
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if ([viewController isKindOfClass:[UINavigationController class]]){
        [(UINavigationController *)viewController popToRootViewControllerAnimated:NO];
    }
}
@end
