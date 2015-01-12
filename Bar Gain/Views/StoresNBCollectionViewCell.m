//
//  StoresNBCollectionViewCell.m
//  Bar Gain
//
//  Created by Nupur Mittal on 19/12/14.
//  Copyright (c) 2014 Anomaly. All rights reserved.
//

#import "StoresNBCollectionViewCell.h"

@implementation StoresNBCollectionViewCell
@synthesize labelStores, imageViewStores;
-(void)prepareForReuse{
    [super prepareForReuse];
    [self setHighlighted:NO];
}
@end
