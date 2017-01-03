//
//  YKSocialNetworkAuthorizationManager.m
//  SocialStorage
//
//  Created by Yevhen Kharytonenko on 1/3/17.
//  Copyright © 2017 Yevhen Kharytonenko. All rights reserved.
//

#import "YKSocialNetworkAuthorizationManager.h"

@implementation YKSocialNetworkAuthorizationManager

+ (instancetype)sharedManager
{
    static YKSocialNetworkAuthorizationManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [YKSocialNetworkAuthorizationManager new];
    });
    return sharedManager;
}

- (void)authorize:(BOOL)authorize forSocialNetworkName:(YKSocialNetworkName)socialNetworkName
  complitionBlock:(void (^)(BOOL, NSError *))complitionBlock
{
    complitionBlock(YES,nil);
}

@end
