//
//  StoreViewController.m
//  Bar Gain
//
//  Created by Nupur Mittal on 04/12/14.
//  Copyright (c) 2014 Anomaly. All rights reserved.
//

#import "StoreViewController.h"

@interface StoreViewController ()

@end

@implementation StoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setHidden:NO];
    [self.parentViewController.navigationController.navigationBar setHidden:NO];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [tableStore reloadData];
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

-(IBAction)buttonBackOperation:(id)sender{
    [self clearSavedDataFromDefaults:nil];
    [self.tabBarController setSelectedIndex:2];
}


#pragma mark - Table view delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StoreTableViewCell *cell = (StoreTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[StoreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    int index = (int)(indexPath.row)%5;
    [cell.imageViewItems setImage:[UIImage imageNamed:[NSString stringWithFormat:@"a%d",index]]];

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 100;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 700, 100)];
//    [view setBackgroundColor:[UIColor grayColor]];
    
    
    UIImageView *storeView= [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    [storeView setImage:[UIImage imageNamed:@"bar-gain_17"]];
    [storeView.layer setCornerRadius:25];
    [storeView setBackgroundColor:[UIColor redColor]];
    [storeView setCenter:CGPointMake(storeView.center.x, view.center.y)];
    
    [view addSubview:storeView];
    
    UILabel *labelSection =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(storeView.frame)+10, 10, 100, 40)];
    [labelSection setText:[Store getSelectedStore][@"name"]];
    [labelSection setCenter:CGPointMake(labelSection.center.x, view.center.y)];

    [view addSubview:labelSection];
    
    UIButton *btnLogout = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnLogout setFrame:CGRectMake(600, 10, 80, 50)];
    [btnLogout setCenter:CGPointMake(btnLogout.center.x, view.center.y)];
    [btnLogout setBackgroundColor:[UIColor redColor]];
    [btnLogout.layer setCornerRadius:10.0];

    [btnLogout setTitle:@"Logout" forState:UIControlStateNormal];
    [btnLogout setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnLogout.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    
    [btnLogout addTarget:nil action:@selector(buttonBackOperation:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnLogout];
    
    return view;
}

@end
