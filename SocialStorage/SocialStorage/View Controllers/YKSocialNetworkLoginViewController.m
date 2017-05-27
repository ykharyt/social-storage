//
//  YKSocialNetworkLoginViewController.m
//  SocialStorage
//
//  Created by Yevhen Kharytonenko on 1/6/17.
//  Copyright © 2017 Yevhen Kharytonenko. All rights reserved.
//

#import "YKSocialNetworkLoginViewController.h"
#import "YKSocialNetworkAuthorizationManager.h"
#import "InstagramKit.h"


@implementation YKSocialNetworkLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.webView.scrollView.bounces = NO;
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
    
    if (self.networkName == YKSocialNetworkNameInstagram) {
        NSURL *authURL = [[InstagramEngine sharedEngine] authorizationURLForScope:InstagramKitLoginScopeBasic | InstagramKitLoginScopePublicContent];
        [self.webView loadRequest:[NSURLRequest requestWithURL:authURL]];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

#pragma mark - UIWebView delegate methods

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType
{
    NSError * error = nil;
    if ([[InstagramEngine sharedEngine] receivedValidAccessTokenFromURL:request.URL
                                                                  error:&error]) {
        [self authenticationSuccess];
    } else {
        NSLog(@"receivedValidAccessTokenFromURL did fail : %@",error.localizedDescription);
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}

#pragma mark - etc

- (void)authenticationSuccess
{
    [self.navigationItem setLeftBarButtonItem:nil];
    [self.navigationItem.rightBarButtonItem setEnabled:YES];
}

@end
