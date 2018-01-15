//
//  TamHttpTool.m
//  TestDeviceInfo
//
//  Created by xin chen on 2018/1/13.
//  Copyright © 2018年 涂怀安. All rights reserved.
//

#import "TamHttpTool.h"

@implementation TamHttpTool

+(void)getRequestWithURL:(NSString *)url params:(NSDictionary *)params success:(TamSuccessBlock)success fail:(TamFailBlock)fail
{
    NSURLSession *session = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    request.HTTPMethod = @"get";
    if (params) {
        request.HTTPBody = [[self convertDictToString:params] dataUsingEncoding:NSUTF8StringEncoding];
    }
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                fail(error);
            }else{
                success([self responseConfiguration:data]);
            }
        });
    }];
    [task resume];
}

+(void)postRequestWithURL:(NSString *)url params:(NSDictionary *)params success:(TamSuccessBlock)success fail:(TamFailBlock)fail
{
    NSURLSession *session = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    request.HTTPMethod = @"post";
    if (params) {
        request.HTTPBody = [[self convertDictToString:params] dataUsingEncoding:NSUTF8StringEncoding];
    }
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                fail(error);
            }else{
                success([self responseConfiguration:data]);
            }
        });
    }];
    [task resume];
}

+(id)responseConfiguration:(id)responseObject{
    NSString*string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    string = [string stringByReplacingOccurrencesOfString:@"\n"withString:@""];
    NSData*data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary*dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    if (!dic) {
        NSLog(@"%@",error);
    }
    return dic;
}

+(NSString *)convertDictToString:(NSDictionary *)dict
{
    @autoreleasepool{
        __block NSMutableString *mutStr = [[NSMutableString alloc]init];
        __block NSInteger index = 0;
        [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [mutStr appendFormat:@"%@%@=%@",index == 0 ? @"" : @"&&",key,obj];
            index++;
        }];
        return mutStr;
    }
}

@end
