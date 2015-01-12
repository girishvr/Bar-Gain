//
//  ViewController.m
//  Bar Gain
//
//  Created by Nupur Mittal on 04/12/14.
//  Copyright (c) 2014 Anomaly. All rights reserved.
//

#import "ViewController.h"
#import "ScanViewController.h"
#import "StoreViewController.h"
@interface ViewController (){
    IBOutletCollection(UIView)NSArray *collectionSubViews;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self checkFirstLaunch];
    [APIClass uploadImage:nil];

    launchedAnimation = NO;
    [self.tabBarController.tabBar setHidden:YES];
    [collectionSubViews.lastObject setHidden:YES];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (!launchedAnimation) {
        [self animateOnLaunch];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)buttonTapped:(id)sender{
    switch ([sender tag]) {
        case 0:{
            //load scan
//            ScanViewController *scanViewController = [ScanViewController new];
//            [self.navigationController pushViewController:scanViewController animated:YES];
            break;
        }
        case 1:{
            //load store
//            StoreViewController *storeViewController = [StoreViewController new];
//            [self.navigationController pushViewController:storeViewController animated:YES];
            break;
            
        }
        case 2:{
//            [self loadNearByStoresPage];
            break;
        }
            
        default:
            break;
    }
}

-(void)loadNearByStoresPage{
    secondStoryBoard = [UIStoryboard storyboardWithName:@"Second" bundle:nil];
    CommonBaseClass *viewController = [secondStoryBoard instantiateInitialViewController];
    [self.navigationController pushViewController:viewController animated:YES];
//    [self.navigationController presentViewController:viewController animated:YES completion:^{
//        //
//    }];
}

-(void)checkFirstLaunch{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isFirstLaunch"]){
        // app already launched
    }else{
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isFirstLaunch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        // This is the first launch ever
        [self showInfoPage];
    }
}

#pragma mark - Seague

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
//    if ([identifier isEqualToString:@"ViewControllerTwoSegue"]) {
//        return NO;
//    }
    return YES;
}


- (IBAction)backToRootViewController:(UIStoryboardSegue *)segue
{
    NSLog(@"from segue id: %@", segue.identifier);
}


#pragma mark - Animations

-(void)animateOnLaunch{
    launchedAnimation = YES;
    __block int k =0;
    for (int i=0; i<2; i++) {
        UIView *view = collectionSubViews[i];
        CGPoint center = view.center;
        [view setCenter:self.view.center];
        [UIView transitionWithView:view duration:0.5f options:UIViewAnimationOptionCurveLinear animations:^{
            [view setHidden:NO];
            [view setCenter:center];
        } completion:^(BOOL finished) {
            k=k+1;
            if (k==2) {
                for (int i=2; i<5; i++) {
                    UIView *view = collectionSubViews[i];
                    CGPoint center = view.center;
                    [view setCenter:self.view.center];
                    [UIView transitionWithView:view duration:1.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
                        [view setHidden:NO];
                        [view setCenter:center];
                    } completion:^(BOOL finished) {
                        [self.tabBarController.tabBar setHidden:NO];
                        [collectionSubViews.lastObject setHidden:NO];
                    }];
                }
            }

        }];
    }
}

@end

















