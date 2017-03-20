//
//  YKSocialContentViewController.m
//  SocialStorage
//
//  Created by Yevhen Kharytonenko on 2/18/17.
//  Copyright © 2017 Yevhen Kharytonenko. All rights reserved.
//

#import "YKSocialContentViewController.h"
#import "YKSocialContentTableViewCell.h"
#import "YKSocialContentBuilder.h"

static NSString * YKSocialContentTableViewCellIdentifier = @"YKSocialContentTableViewCell";

@interface YKSocialContentViewController ()
@property (nonatomic,strong) NSArray * content;
@end

@implementation YKSocialContentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [YKSocialContentBuilder availablePhotosFromInstagram:^(NSError *error, NSArray<YKPhoto *> *photos) {
        self.content = photos;
        [self.tableView reloadData];
    }];
    
//    [[InstagramEngine sharedEngine] getSelfUserDetailsWithSuccess:^(InstagramUser * _Nonnull user) {
//        
//    } failure:^(NSError * _Nonnull error, NSInteger serverStatusCode) {
//        NSLog(@"Error : %@",[error description]);
//    }];


}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YKPhoto * photo = (YKPhoto *)self.content[indexPath.row];
    
    YKSocialContentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:YKSocialContentTableViewCellIdentifier
                                                                          forIndexPath:indexPath];
    cell.imageName.text = photo.imageName;
    cell.imageView.image = photo.imageInStandartResolution;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.content.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

@end
