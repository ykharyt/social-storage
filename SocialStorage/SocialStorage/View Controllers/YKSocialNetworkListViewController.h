//
//  YKSocialNetworkListViewController.h
//  SocialStorage
//
//  Created by Yevhen Kharytonenko on 12/24/16.
//  Copyright © 2016 Yevhen Kharytonenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKSocialNetworkListViewController : UIViewController

@property (strong, nonatomic) IBOutletCollection(UISwitch) NSArray *switchers;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *statusImages;

- (IBAction)switchAction:(id)sender;

@end
