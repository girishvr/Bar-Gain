//
//  APIClass.h
//  Bar Gain
//
//  Created by Nupur Mittal on 19/12/14.
//  Copyright (c) 2014 Anomaly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface APIClass : NSObject
+(void)uploadWithParameters:(NSDictionary *)parameters;
+(void)getProductDetails:(NSString *)productId;
+(void)uploadImage:(NSString *)imagePath;
@end
