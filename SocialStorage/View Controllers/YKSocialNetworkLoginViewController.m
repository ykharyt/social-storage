//
//  YKSocialNetworkLoginViewController.m
//  SocialStorage
//
//  Created by Yevhen Kharytonenko on 1/6/17.
//  Copyright © 2017 Yevhen Kharytonenko. All rights reserved.
//

#import "YKSocialNetworkLoginViewController.h"
#import "YKSocialNetworkAuthorizationManager.h"


@implementation YKSocialNetworkLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.webView.scrollView.bounces = NO;
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
    
    [[YKSocialNetworkAuthorizationManager sharedManager] authorize:YES
                                              forSocialNetworkName:self.networkName
                                                         inWebView:self.webView
                                                   complitionBlock:^(BOOL success, NSError *error) {
                                                       
                                                   }];
}

#pragma mark - UIWebView delegate methods

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType
{
    if ([[YKSocialNetworkAuthorizationManager sharedManager] receivedValidAccessTokenFromURL:request.URL
                                                                            forSocialNetwork:self.networkName]) {
        [self handleAuthenticationSuccess];
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {}
- (void)webViewDidFinishLoad:(UIWebView *)webView {}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {}

#pragma mark - etc

- (void)handleAuthenticationSuccess
{
    [self.navigationItem setLeftBarButtonItem:nil];
    [self.navigationItem.rightBarButtonItem setEnabled:YES];
    
    [[YKSocialNetworkAuthorizationManager sharedManager] saveAccessTokenForSocialNetwork:self.networkName];
}

@end
