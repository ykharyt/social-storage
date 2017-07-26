//
//  YKSocialNetworkAuthorizationManager.m
//  SocialStorage
//
//  Created by Yevhen Kharytonenko on 1/3/17.
//  Copyright © 2017 Yevhen Kharytonenko. All rights reserved.
//

#import "YKSocialNetworkAuthorizationManager.h"
#import "InstagramEngine.h"
#import "FDKeychain.h"

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
        inWebView:(UIWebView *)webView
  complitionBlock:(void (^)(BOOL, NSError *))complitionBlock
{
    switch (socialNetworkName) {
        case YKSocialNetworkNameInstagram: {
            if ([self accessTokenForSocialNetwork:socialNetworkName].length == 0) {
                [webView loadRequest:[NSURLRequest requestWithURL:[[InstagramEngine sharedEngine] authorizationURLForScope:
                                                                   InstagramKitLoginScopeBasic | InstagramKitLoginScopePublicContent]]];
            }
            break;
        }
        default:
            break;
    }
    complitionBlock(YES,nil);
}

- (BOOL)receivedValidAccessTokenFromURL:(NSURL *)url forSocialNetwork:(YKSocialNetworkName)socialNetworkName
{
    BOOL received = NO;
    if (socialNetworkName == YKSocialNetworkNameInstagram) {
        NSError *error;
        received = [[InstagramEngine sharedEngine] receivedValidAccessTokenFromURL:url
                                                                             error:&error];
        NSLog(@"%@",error.localizedDescription);
    }
    return received;
}

- (NSString *)accessTokenForSocialNetwork:(YKSocialNetworkName)socialNetworkName
{
    NSString *accessToken = nil;
    if (socialNetworkName == YKSocialNetworkNameInstagram) {
        NSError *error = nil;
        [FDKeychain itemForKey:@"accessToken"
                    forService:@"Instagram"
                         error:&error];
        NSLog(@"%@", error.localizedDescription);
    }
    return accessToken;
}

- (void)saveAccessTokenForSocialNetwork:(YKSocialNetworkName)socialNetworkName
{
    if (socialNetworkName == YKSocialNetworkNameInstagram) {
        NSError *error = nil;
        [FDKeychain saveItem:[[InstagramEngine sharedEngine] accessToken]
                      forKey:@"accessToken"
                  forService:@"Instagram"
                       error:nil];
        NSLog(@"%@", error.localizedDescription);
    }
}

- (void)logoutFromSocialNetwork:(YKSocialNetworkName)socialNetworkName
{
    if (socialNetworkName == YKSocialNetworkNameInstagram) {
        [[InstagramEngine sharedEngine] logout];
        NSError *error = nil;
        [FDKeychain deleteItemForKey:@"accessToken"
                          forService:@"Instagram"
                               error:nil];
        NSLog(@"%@", error.localizedDescription);
    }
}


@end
