//
//  YKSocialNetworkAuthorizationManager.h
//  SocialStorage
//
//  Created by Yevhen Kharytonenko on 1/3/17.
//  Copyright © 2017 Yevhen Kharytonenko. All rights reserved.
//

@import UIKit;
#import "YKSocialNetworkConstants.h"

@interface YKSocialNetworkAuthorizationManager : NSObject

+ (instancetype)sharedManager;

- (void)authorize:(BOOL)authorize forSocialNetworkName:(YKSocialNetworkName)socialNetworkName
        inWebView:(UIWebView *)webView
  complitionBlock:(void (^)(BOOL, NSError *))complitionBlock;

- (BOOL)receivedValidAccessTokenFromURL:(NSURL *)url forSocialNetwork:(YKSocialNetworkName)socialNetworkName;
- (NSString *)accessTokenForSocialNetwork:(YKSocialNetworkName)socialNetworkName;
- (void)saveAccessTokenForSocialNetwork:(YKSocialNetworkName)socialNetworkName;
- (void)logoutFromSocialNetwork:(YKSocialNetworkName)socialNetworkName;

@end
