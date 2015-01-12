//
//  Product.m
//  Bar Gain
//
//  Created by Nupur Mittal on 05/01/15.
//  Copyright (c) 2015 Anomaly. All rights reserved.
//

#import "Product.h"

@implementation Product

-(id)init{
    self = [super init];
    if (self) {
        NSString *path = [[NSBundle mainBundle] pathForResource:
                          @"Products" ofType:@"plist"];

        _arrayProducts = [NSMutableArray arrayWithContentsOfFile:path];
        self.count = (int)_arrayProducts.count;
    }
    return self;
}

-(NSDictionary *)getProductDetailsForBarCode:(NSString *)barCode{
    NSDictionary *dictionaryItem = @{
                                     @"brand" : @"Sula",
                                     @"color" : @"Red",
                                     @"cost" : @"100",
                                     @"description" : @"Default Product",
                                     @"id" : @"",
                                     @"image_name" : @"sula",
                                     @"name" : @"Sula",
                                     @"quantity" : @"500ml",
                                     @"type" : @"Wine"};

    for (NSDictionary *item in _arrayProducts) {
        if ([item[@"id"] isEqualToString:barCode]) {
            dictionaryItem = item;
            break;
        }
    }
    
    return dictionaryItem;
}

@end
