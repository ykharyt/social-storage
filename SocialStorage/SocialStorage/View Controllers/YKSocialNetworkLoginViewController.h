//
//  YKSocialNetworkLoginViewController.h
//  SocialStorage
//
//  Created by Yevhen Kharytonenko on 1/6/17.
//  Copyright © 2017 Yevhen Kharytonenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YKSocialNetworkConstants.h"

@interface YKSocialNetworkLoginViewController : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView           *webView;
@property (nonatomic      ) YKSocialNetworkName networkName;
@end
