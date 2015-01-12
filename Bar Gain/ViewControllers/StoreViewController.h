//
//  StoreViewController.h
//  Bar Gain
//
//  Created by Nupur Mittal on 04/12/14.
//  Copyright (c) 2014 Anomaly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreTableViewCell.h"

@interface StoreViewController : CommonBaseClass<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *tableStore;

}
@end
