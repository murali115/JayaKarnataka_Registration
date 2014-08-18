//
//  GetData.h
//  Registration_Mock
//
//  Created by Mac1 on 8/5/14.
//  Copyright (c) 2014 youflik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetData : NSObject
+(void) getDataFromUrl:(NSString*)url withParameters:(NSDictionary *)params withHeader:(NSString*)header WithCompletion:(void (^)(NSMutableArray*))completion;
+(void) postDataToUrl:(NSString*)url withParameters:(NSDictionary *)params withHeader:(NSString*)header WithCompletion:(void (^)(NSMutableArray*))completion;
@end
