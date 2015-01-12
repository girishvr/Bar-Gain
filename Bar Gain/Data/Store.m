//
//  Store.m
//  Bar Gain
//
//  Created by Nupur Mittal on 06/01/15.
//  Copyright (c) 2015 Anomaly. All rights reserved.
//

#import "Store.h"
static NSMutableArray *arrayStores;
static NSUInteger count;;
@implementation Store
//+(id)init{
//    self = [super init];
//    if (self) {
//        _arrayStores = [NSMutableArray array];
//    }
//    return self;
//}

+(void)saveStoresData:(id)data{
    arrayStores = [@[
                      [@{@"store_id":@"1",@"name":@"Store 1",@"isSelected":@(YES)} mutableCopy],
                      [@{@"store_id":@"2",@"name":@"Store 2",@"isSelected":@(NO)} mutableCopy],
                      [@{@"store_id":@"3",@"name":@"Store 3",@"isSelected":@(NO)} mutableCopy],
                      [@{@"store_id":@"4",@"name":@"Store 4",@"isSelected":@(NO)} mutableCopy],
                      [@{@"store_id":@"5",@"name":@"Store 5",@"isSelected":@(NO)} mutableCopy],
                      [@{@"store_id":@"6",@"name":@"Store 6",@"isSelected":@(NO)} mutableCopy]
                      ] mutableCopy];
    count = arrayStores.count;

}
+(NSMutableArray *)getStoresArray{
    return arrayStores;
}
+(NSUInteger)getStoresCount{
    return count;
}
+(NSDictionary *)getStoreDetailsForId:(NSString *)storeId{
    NSDictionary *dictionaryItem = [@{@"store_id":@"1",@"name":@"Store 1",@"isSelected":@(NO)} mutableCopy];
    
    for (NSDictionary *item in arrayStores) {
        if ([item[@"store_id"] isEqualToString:storeId]) {
            dictionaryItem = item;
            break;
        }
    }
    
    return dictionaryItem;
}

+(NSDictionary *)getSelectedStore{
    NSDictionary *dictionaryItem = [@{@"store_id":@"1",@"name":@"Store 1",@"isSelected":@(NO)} mutableCopy];
    
    for (NSDictionary *item in arrayStores) {
        if ([item[@"isSelected"] boolValue]) {
            dictionaryItem = item;
            break;
        }
    }
    
    return dictionaryItem;
    
}

+(void)setExclusiveTouch:(NSInteger)index{
    for (NSMutableDictionary *items in arrayStores) {
        items[@"isSelected"] = @(NO);
    }
    arrayStores[index][@"isSelected"] = @(YES);
    
}

+(void)deselectStoreAt:(NSInteger)index{
    arrayStores[index][@"isSelected"] = @(NO);
}

+(BOOL)getIsSelected:(NSInteger)index{
    return [arrayStores[index][@"isSelected"] boolValue];
}

@end
