//
//  CommonBaseClass.m
//  Bar Gain
//
//  Created by Nupur Mittal on 09/12/14.
//  Copyright (c) 2014 Anomaly. All rights reserved.
//

#import "CommonBaseClass.h"

@interface CommonBaseClass (){

}
-(IBAction)showInfoPage;
@end

@implementation CommonBaseClass

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeInfoDark];
    [btn addTarget:self action:@selector(showInfoPage) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bar-gain_03"]];

    [self.tabBarController.tabBar setTintColor:[UIColor redColor]];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
//    _stores = [[Store alloc] init];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(IBAction)clearSavedDataFromDefaults:(id)sender{
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"userEmail"];
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"userTel"];
}

-(IBAction)showInfoPage{
    
    _pageTitles = @[@"Info-1.png",@"Info-2",@"Info-3",@"Info-4",@"Info-5"];
    
    secondStoryBoard = [UIStoryboard storyboardWithName:@"Second" bundle:nil];
    self.pageViewController = [secondStoryBoard instantiateViewControllerWithIdentifier:@"InstructionPageView"];
    
    self.pageViewController.dataSource = self;
    
    ContentPageViewController *startingViewController = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = @[startingViewController];
    
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
    [self.navigationController presentViewController:_pageViewController animated:YES completion:^{
        //
    }];
}
-(IBAction)nextInfoPage:(id)sender{
    ContentPageViewController *startingViewController = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = @[startingViewController];
    
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((ContentPageViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((ContentPageViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageTitles count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageTitles count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

- (ContentPageViewController *)viewControllerAtIndex:(NSUInteger)index
{
    NSLog(@"%lu",(unsigned long)index);

    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    ContentPageViewController * pageContentViewController = [secondStoryBoard instantiateViewControllerWithIdentifier:@"ContentPageView"];
    
    //    pageContentViewController.titleText = self.pageTitles[index];
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}


@end
