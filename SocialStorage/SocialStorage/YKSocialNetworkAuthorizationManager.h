//
//  YKSocialNetworkAuthorizationManager.h
//  SocialStorage
//
//  Created by Yevhen Kharytonenko on 1/3/17.
//  Copyright © 2017 Yevhen Kharytonenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKSocialNetworkConstants.h"

@interface YKSocialNetworkAuthorizationManager : NSObject

+ (instancetype)sharedManager;

- (void)authorize:(BOOL)authorize forSocialNetworkName:(YKSocialNetworkName)socialNetworkName
  complitionBlock:(void (^)(BOOL success, NSError * error))complitionBlock;

@end
