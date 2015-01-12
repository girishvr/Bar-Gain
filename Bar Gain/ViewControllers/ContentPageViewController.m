//
//  ContentPageViewController.m
//  Bar Gain
//
//  Created by Nupur Mittal on 26/12/14.
//  Copyright (c) 2014 Anomaly. All rights reserved.
//

#import "ContentPageViewController.h"

@implementation ContentPageViewController
@synthesize imageInfo=_imageInfo;

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSArray * pageTitles = @[@"Info-1.png",@"Info-2",@"Info-3",@"Info-4",@"Info-5"];
    UIImage *image = [UIImage imageNamed:pageTitles[_pageIndex]];
    [self.imageInfo setImage:image];
    self.imageInfo.layer.borderColor=[[UIColor redColor] CGColor];
    [_btnNextPage setHidden:([pageTitles count]-1==_pageIndex)];

}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:NO];
}

-(IBAction)dismissButton:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
