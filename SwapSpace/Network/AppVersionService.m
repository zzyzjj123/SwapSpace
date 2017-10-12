//
//  AppVersionService.m
//  SwapSpace
//
//  Created by zzy on 12/09/2017.
//  Copyright © 2017 lanmao. All rights reserved.
//

#import "AppVersionService.h"
#import "RestService.h"
@implementation AppVersionService
/**
 * 获取app版本号
 */
+ (void)getAppVersion:(void(^)(NSDictionary *dict))completion {
    
    [[RestService sharedService] afnetworkingPost:kAPIAppVersion responseType:Json parameters:nil completion:^(id myAfNetBlokResponeDic, BOOL flag) {
        if (flag) {
            NSDictionary *dict = myAfNetBlokResponeDic;
            if ([dict[@"code"] isEqualToString:@"1"]) {
                
                BOOL hasNewVersion = NO;

                NSArray *realVersionNums = [dict[@"version"] componentsSeparatedByString:@"."];
                NSArray *appVersionNums = [kAppVersion componentsSeparatedByString:@"."];
            
                for (int i = 0; i < [appVersionNums count]; i++) {
                    if (appVersionNums.count > i && realVersionNums.count > i) {
                        if ([realVersionNums[i] integerValue] > [appVersionNums[i] integerValue]) {
                            hasNewVersion = YES;
                            break;
                        }
                    }
                }
                
                if (hasNewVersion) {

                    completion(dict);
                }
            }
        }
    }];
}


@end
