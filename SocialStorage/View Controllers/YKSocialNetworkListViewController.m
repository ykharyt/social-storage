//
//  YKSocialNetworkListViewController.m
//  SocialStorage
//
//  Created by Yevhen Kharytonenko on 12/24/16.
//  Copyright © 2016 Yevhen Kharytonenko. All rights reserved.
//

#import "YKSocialNetworkListViewController.h"
#import "FAKFontAwesome.h"
#import "YKSocialNetworkConstants.h"
#import "YKSocialNetworkLoginViewController.h"
#import "YKSocialNetworkAuthorizationManager.h"

static NSString * const YKShowLoginSegueIdentifier = @"YKShowLoginSegueIdentifier";
static NSUInteger const YKFacebookSwitchTag        = 0;
static NSUInteger const YKInstagramSwitchTag       = 1;

@interface YKSocialNetworkListViewController ()
@end

@implementation YKSocialNetworkListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupBrandImages];
    
    // TODO: check login statuses
}

#pragma mark - Actions

- (IBAction)switchAction:(UISwitch *)sender
{
    if (sender.on) {
       [self performSegueWithIdentifier:YKShowLoginSegueIdentifier
                                 sender:sender];
    } else {
        // FIXME: logout
        if (sender.tag == YKInstagramSwitchTag) {
            [[YKSocialNetworkAuthorizationManager sharedManager] logoutFromSocialNetwork:YKSocialNetworkNameInstagram];
        }
    }
}

#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    if ([segue.identifier isEqualToString:YKShowLoginSegueIdentifier] &&
        [sender isKindOfClass:[UISwitch class]]) {
        
        YKSocialNetworkLoginViewController * loginViewController = [segue destinationViewController];
        
        switch ([(UISwitch *)sender tag]) {
            case YKFacebookSwitchTag: {
                loginViewController.networkName = YKSocialNetworkNameFacebook;
                break;
            }
            case YKInstagramSwitchTag: {
                loginViewController.networkName = YKSocialNetworkNameInstagram;
                break;
            }
            default: {
                break;
            }
        }
    }
}

#pragma mark - etc

- (void)setupBrandImages
{
    [self.statusImages[0] setImage:[[FAKFontAwesome facebookIconWithSize:14.0f]
                                    imageWithSize:CGSizeMake(40,40)]];
    [self.statusImages[1] setImage:[[FAKFontAwesome instagramIconWithSize:14.0f]
                                    imageWithSize:CGSizeMake(40,40)]];
}

@end
