//
//  ContentPageViewController.h
//  Bar Gain
//
//  Created by Nupur Mittal on 26/12/14.
//  Copyright (c) 2014 Anomaly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentPageViewController : UIViewController{
}
@property(nonatomic, weak)IBOutlet UIImageView *imageInfo;
@property(nonatomic, strong)IBOutlet UIButton *btnNextPage;
@property NSUInteger pageIndex;
@end
