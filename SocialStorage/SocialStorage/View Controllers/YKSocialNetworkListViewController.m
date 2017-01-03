//
//  YKSocialNetworkListViewController.m
//  SocialStorage
//
//  Created by Yevhen Kharytonenko on 12/24/16.
//  Copyright © 2016 Yevhen Kharytonenko. All rights reserved.
//

#import "YKSocialNetworkListViewController.h"
#import "YKSocialNetworkAuthorizationManager.h"

@implementation YKSocialNetworkListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - Actions

- (IBAction)facebookSwitchAction:(UISwitch *)sender
{
    [[YKSocialNetworkAuthorizationManager sharedManager] authorize:sender.on
                                              forSocialNetworkName:YKSocialNetworkNameFacebook
                                                   complitionBlock:^(BOOL success, NSError *error) {
                                                       [self updateUIForSocialNetwork:YKSocialNetworkNameFacebook
                                                                              success:success];
                                                   }];
}

- (IBAction)instagramSwitchAction:(UISwitch *)sender
{
    [[YKSocialNetworkAuthorizationManager sharedManager] authorize:sender.on
                                              forSocialNetworkName:YKSocialNetworkNameInstagram
                                                   complitionBlock:^(BOOL success, NSError *error) {
                                                       [self updateUIForSocialNetwork:YKSocialNetworkNameInstagram
                                                                              success:success];
                                                   }];
}

- (IBAction)vkSwitchAction:(UISwitch *)sender
{
    [[YKSocialNetworkAuthorizationManager sharedManager] authorize:sender.on
                                              forSocialNetworkName:YKSocialNetworkNameVK
                                                   complitionBlock:^(BOOL success, NSError *error) {
                                                       [self updateUIForSocialNetwork:YKSocialNetworkNameVK
                                                                              success:success];
                                                   }];
}

#pragma mark -

- (void)updateUIForSocialNetwork:(YKSocialNetworkName)networkName success:(BOOL)success
{
    UIImage * imageForStatus = success ? [UIImage imageNamed:@"LoggedInStatusImage"] : [UIImage imageNamed:@"LoggedOutStatusImage"];
    
    switch (networkName) {
        case YKSocialNetworkNameFacebook: {
            [[self.switchers firstObject] setOn:success];
            [[self.statusImages firstObject] setImage:imageForStatus
                                             forState:UIControlStateNormal];
            break;
        }
        case YKSocialNetworkNameInstagram: {
            [self.switchers[1] setOn:success];
            [self.statusImages[1] setImage:imageForStatus
                                  forState:UIControlStateNormal];
            break;
        }
        case YKSocialNetworkNameVK: {
            [self.switchers[2] setOn:success];
            [self.statusImages[2] setImage:imageForStatus
                                  forState:UIControlStateNormal];
            break;
        }
        default: {
            break;
        }
    }
}

@end
