//
//  UIView+YKProgressHUD.h
//  SocialStorage
//
//  Created by Yevhen Kharytonenko on 4/20/17.
//  Copyright © 2017 Yevhen Kharytonenko. All rights reserved.
//

@import UIKit;

@interface UIView (YKProgressHUD)

- (void)yk_showProgressHUDWithStatus:(NSString *)status;
- (void)yk_hideProgressHUD;

@end
