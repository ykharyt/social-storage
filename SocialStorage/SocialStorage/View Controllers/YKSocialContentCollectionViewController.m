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

#import "InstagramEngine.h"

@interface YKSocialContentCollectionViewController ()
@property (nonatomic,strong) NSArray * content;
@end

static NSString * const YKPhotoCollectionViewHeaderIdentifier = @"YKPhotoCollectionViewHeader";

@implementation YKSocialContentCollectionViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[InstagramEngine sharedEngine] getSelfUserDetailsWithSuccess:^(InstagramUser * _Nonnull user) {

    } failure:^(NSError * _Nonnull error, NSInteger serverStatusCode) {
        NSLog(@"Error : %@",[error description]);
    }];
    
    self.clearsSelectionOnViewWillAppear = NO;
    [self.collectionView registerClass:[UICollectionReusableView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:YKPhotoCollectionViewHeaderIdentifier];
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
    [self.view yk_showProgressHUD];
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
    [self.navigationController.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%lu",(unsigned long)self.content.count]];
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
    YKPhoto * photo = (YKPhoto *)self.content[indexPath.row];
    YKPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([YKPhotoCollectionViewCell class])
                                                                                forIndexPath:indexPath];
    cell.image.image = photo.imageInStandartResolution;
    cell.imageName.text = photo.imageName;
    return cell;
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
