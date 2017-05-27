//
//  UIView+YKActivityIndicator.m
//  SocialStorage
//
//  Created by Yevhen Kharytonenko on 4/20/17.
//  Copyright © 2017 Yevhen Kharytonenko. All rights reserved.
//

#import "UIView+YKProgressHUD.h"
#import "M13ProgressHUD.h"
#import "M13ProgressViewRing.h"
#import <objc/runtime.h>
#import "UIColor+YKColors.h"

static char progressHUDKey;

@implementation UIView (YKProgressHUD)

- (void)yk_setProgressHUD:(M13ProgressHUD *)progressHUD
{
    objc_setAssociatedObject(self, &progressHUDKey, progressHUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (M13ProgressHUD *)yk_progressHUD
{
    M13ProgressHUD * hud = objc_getAssociatedObject(self, &progressHUDKey);
    if (!hud) {
        M13ProgressViewRing * ring = [[M13ProgressViewRing alloc] init];
        
        hud = [[M13ProgressHUD alloc] initWithProgressView:ring];
        hud.progressViewSize = CGSizeMake(60.0, 60.0);
        hud.animationPoint = CGPointMake([UIScreen mainScreen].bounds.size.width/2,
                                         [UIScreen mainScreen].bounds.size.height/2);
        hud.primaryColor = [UIColor yk_pinkColor];
        hud.secondaryColor = [UIColor yk_pinkColor];
        hud.indeterminate = YES;

        [self yk_setProgressHUD:hud];
    }
    return hud;
}

- (void)yk_showProgressHUDWithStatus:(NSString *)status
{
    self.userInteractionEnabled = NO;
    
    M13ProgressHUD * hud = [self yk_progressHUD];
    hud.status = status;  
    
    [self addSubview:self.yk_progressHUD];
    [self.yk_progressHUD show:YES];
}

- (void)yk_hideProgressHUD
{
    [self.yk_progressHUD hide:YES];
    [self yk_setProgressHUD:nil];
    
    self.userInteractionEnabled = YES;
}

@end
