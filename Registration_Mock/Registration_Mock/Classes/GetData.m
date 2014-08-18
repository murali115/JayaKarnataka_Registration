//
//  GetData.m
//  Registration_Mock
//
//  Created by Mac1 on 8/5/14.
//  Copyright (c) 2014 youflik. All rights reserved.
//

#import "GetData.h"
#import "AFNetworking.h"

@implementation GetData

+(void) getDataFromUrl:(NSString*)url withParameters:(NSDictionary *)params withHeader:(NSString*)header WithCompletion:(void (^)(NSMutableArray *array))completion{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:header forHTTPHeaderField:@"X-Auth-Token"];
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [array addObject:responseObject];

        if(completion) {
            completion(array);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failed");
    }];
}
+(void) postDataToUrl:(NSString*)url withParameters:(NSDictionary *)params withHeader:(NSString*)header WithCompletion:(void (^)(NSMutableArray *array))completion{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:header forHTTPHeaderField:@"X-Auth-Token"];
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"%@",responseObject);
        [array addObject:responseObject];
        
        if(completion) {
            completion(array);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failed");
    }];
}

@end
