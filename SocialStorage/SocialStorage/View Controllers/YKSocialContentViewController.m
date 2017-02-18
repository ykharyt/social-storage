//
//  YKSocialContentViewController.m
//  SocialStorage
//
//  Created by Yevhen Kharytonenko on 2/18/17.
//  Copyright © 2017 Yevhen Kharytonenko. All rights reserved.
//

#import "YKSocialContentViewController.h"
#import "YKSocialContentTableViewCell.h"

static NSString * YKSocialContentTableViewCellIdentifier = @"YKSocialContentTableViewCell";

@interface YKSocialContentViewController ()

@end

@implementation YKSocialContentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YKSocialContentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:YKSocialContentTableViewCellIdentifier
                                                                          forIndexPath:indexPath];
    cell.imageName.text = @"test";
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

@end
