//
//  Product.h
//  Bar Gain
//
//  Created by Nupur Mittal on 05/01/15.
//  Copyright (c) 2015 Anomaly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject
@property(nonatomic, strong)NSMutableArray *arrayProducts;
@property(nonatomic, assign)int count;
-(NSDictionary *)getProductDetailsForBarCode:(NSString *)barCode;
@end
