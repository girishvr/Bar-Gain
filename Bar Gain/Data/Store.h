//
//  Store.h
//  Bar Gain
//
//  Created by Nupur Mittal on 06/01/15.
//  Copyright (c) 2015 Anomaly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Store : NSObject
//@property(nonatomic, strong)NSMutableArray *arrayStores;
//@property(nonatomic, assign)NSUInteger count;
+(NSMutableArray *)getStoresArray;
+(NSUInteger)getStoresCount;
+(void)saveStoresData:(id)data;
+(NSDictionary *)getSelectedStore;
+(void)setExclusiveTouch:(NSInteger)index;
+(void)deselectStoreAt:(NSInteger)index;
+(BOOL)getIsSelected:(NSInteger)index;
@end
