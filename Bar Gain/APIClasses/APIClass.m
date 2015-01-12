//
//  APIClass.m
//  Bar Gain
//
//  Created by Nupur Mittal on 19/12/14.
//  Copyright (c) 2014 Anomaly. All rights reserved.
//

#import "APIClass.h"

@implementation APIClass

static NSString *baseUrlString = @"http://202.38.172.77:3001"; // @"http://202.38.172.77:83/api/entity/PostEntity";//@"http://202.38.172.77:83/api/entity/getuserentities?userid=1&parentid=0&type=userenquiry"; //


+(void)uploadWithParameters:(NSDictionary *)parameters{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    

//    Content-Type: application/json
    
    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = requestSerializer;
    
    NSString *requestString = [NSString stringWithFormat:@"%@/%@",baseUrlString, @"postentityWithOutAuthentication"];
    [manager POST:requestString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [[[UIAlertView alloc] initWithTitle:@"Alert" message:[NSString stringWithFormat:@"Success \n %@",responseObject[@"id"]] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);

    }];

    
}

+(void)getProductDetails:(NSString *)productId{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
//    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
//    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    manager.requestSerializer = requestSerializer;
    NSString *requestString = [NSString stringWithFormat:@"%@/getItem?id=%@",baseUrlString, productId];
    NSLog(requestString.description);
    [manager GET:requestString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog([responseObject description]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}


+(void)uploadImage:(NSString *)imagePath{
    UIImage *image = [UIImage imageNamed:@"sula"];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.1);
    NSString *requestString =@"http://202.38.172.77:9010/api/File/UploadFileNew?userId=1";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:@"undefined" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = requestSerializer;

    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    
    AFHTTPRequestOperation *op = [manager POST:requestString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"Sample" fileName:@"Sula.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        NSLog([responseObject description]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        NSLog([error description]);

    }];
    
    op.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"undefined"];
    [op start];

    
}
/*
 
 
 
 POST MULTI-PART REQUEST
 
 AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
 NSDictionary *parameters = @{@"foo": @"bar"};
 NSURL *filePath = [NSURL fileURLWithPath:@"file://path/to/image.png"];
 [manager POST:@"http://example.com/resources.json" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
 [formData appendPartWithFileURL:filePath name:@"image" error:nil];
 } success:^(AFHTTPRequestOperation *operation, id responseObject) {
 NSLog(@"Success: %@", responseObject);
 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
 NSLog(@"Error: %@", error);
 }];
 
 
 
 */

@end
