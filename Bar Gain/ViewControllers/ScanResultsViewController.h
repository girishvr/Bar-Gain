//
//  ScanResultsViewController.h
//  Bar Gain
//
//  Created by Nupur Mittal on 10/12/14.
//  Copyright (c) 2014 Anomaly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIClass.h"
#import "Product.h"
@interface ScanResultsViewController : CommonBaseClass<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@property(nonatomic, strong)NSString *results;
-(IBAction)tappedButtonOk:(id)sender;
@end
