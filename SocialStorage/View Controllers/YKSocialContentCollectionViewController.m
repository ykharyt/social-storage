//
//  YKSocialContentCollectionViewController.m
//  SocialStorage
//
//  Created by Yevhen Kharytonenko on 3/20/17.
//  Copyright © 2017 Yevhen Kharytonenko. All rights reserved.
//

#import "YKSocialContentCollectionViewController.h"
#import "YKSocialContentBuilder.h"
#import "YKPhotoCollectionViewCell.h"
#import "UIView+YKProgressHUD.h"
#import "UIColor+YKColors.h"

#import "InstagramEngine.h"

@interface YKSocialContentCollectionViewController ()
@property (nonatomic,strong) NSArray * content;
@end

static NSString * const YKPhotoCollectionViewHeaderIdentifier = @"YKPhotoCollectionViewHeader";
static NSString * const YKPhotoCollectionViewFooterIdentifier = @"YKPhotoCollectionViewFooter";

@implementation YKSocialContentCollectionViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[InstagramEngine sharedEngine] getSelfUserDetailsWithSuccess:^(InstagramUser * _Nonnull user) {

    } failure:^(NSError * _Nonnull error, NSInteger serverStatusCode) {
        NSLog(@"Error : %@",[error description]);
    }];
    
    self.clearsSelectionOnViewWillAppear = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self emptyCollectionView];
    [self updateCollectionView];
}

#pragma mark - Private methods

- (void)emptyCollectionView
{
    self.content = @[];
    [self.collectionView reloadData];
    [self.collectionView performBatchUpdates:nil
                                  completion:nil];
}

- (void)updateCollectionView
{
    [self.view yk_showProgressHUDWithStatus:NSLocalizedString(@"Downloading photos",nil)];
    [YKSocialContentBuilder availablePhotosFromInstagram:^(NSError *error,
                                                           NSArray<YKPhoto *> *photos) {
        self.content = photos;
        [self.collectionView reloadData];
        [self.collectionView performBatchUpdates:nil
                                      completion:^(BOOL finished) {
                                          [self.view yk_hideProgressHUD];
                                          [self updateBadge];
                                      }];
    }];
}

- (void)updateBadge
{
    NSString * badgeValue = self.content.count > 0 ? [NSString stringWithFormat:@"%lu",(unsigned long)self.content.count] : nil;
    [self.navigationController.tabBarItem setBadgeValue:badgeValue];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return self.content.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YKPhoto * photo                 = (YKPhoto *)self.content[indexPath.row];
    YKPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([YKPhotoCollectionViewCell class])
                                                                                forIndexPath:indexPath];
    cell.image.image                = photo.imageInStandartResolution;
    cell.imageName.text             = photo.imageName;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView * reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                   withReuseIdentifier:YKPhotoCollectionViewHeaderIdentifier
                                                                                          forIndexPath:indexPath];
        reusableview = headerView;
    }
    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView * footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                                                   withReuseIdentifier:YKPhotoCollectionViewFooterIdentifier
                                                                                          forIndexPath:indexPath];
        reusableview = footerview;
    }
    reusableview.backgroundColor = [UIColor yk_pinkColor];
    return reusableview;
}
#pragma mark <UICollectionViewDelegate>


- (BOOL)collectionView:(UICollectionView *)collectionView
shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
	return YES;
}


- (BOOL)collectionView:(UICollectionView *)collectionView
shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (BOOL)collectionView:(UICollectionView *)collectionView
shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath
{
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView
      canPerformAction:(SEL)action
    forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView
         performAction:(SEL)action
    forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
	
}

@end
