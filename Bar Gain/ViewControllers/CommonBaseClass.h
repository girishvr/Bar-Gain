//
//  CommonBaseClass.h
//  Bar Gain
//
//  Created by Nupur Mittal on 09/12/14.
//  Copyright (c) 2014 Anomaly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentPageViewController.h"
#import "Store.h"

@interface CommonBaseClass : UIViewController<UIPageViewControllerDataSource>{
    UIStoryboard *secondStoryBoard;
    bool launchedAnimation;
}
@property(nonatomic, strong) NSArray * pageTitles;
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property(nonatomic, strong) Store *stores;
-(void)showInfoPage;
-(IBAction)clearSavedDataFromDefaults:(id)sender;
@end
