//
//  TamHttpTool.h
//  TestDeviceInfo
//
//  Created by xin chen on 2018/1/13.
//  Copyright © 2018年 涂怀安. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^TamSuccessBlock)(id response);
typedef void(^TamFailBlock)(NSError *fail);

@interface TamHttpTool : NSObject

/**
 get请求

 @param url 地址
 @param params 参数
 @param success 成功回调
 @param fail 失败回调
 */
+(void)getRequestWithURL:(NSString *)url params:(NSDictionary *)params success:(TamSuccessBlock)success fail:(TamFailBlock)fail;

/**
 post请求

 @param url 地址
 @param params 参数
 @param success 成功回调
 @param fail 失败回调
 */
+(void)postRequestWithURL:(NSString *)url params:(NSDictionary *)params success:(TamSuccessBlock)success fail:(TamFailBlock)fail;

@end
