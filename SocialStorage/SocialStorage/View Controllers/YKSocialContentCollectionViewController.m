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
#import "M13ProgressHUD.h"
#import "M13ProgressViewRing.h"

@interface YKSocialContentCollectionViewController ()
@property (nonatomic,strong) NSArray * content;
@property (nonatomic,strong) M13ProgressHUD *hud;
@end

static NSString * const YKPhotoCollectionViewHeaderIdentifier = @"YKPhotoCollectionViewHeader";

@implementation YKSocialContentCollectionViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [[InstagramEngine sharedEngine] getSelfUserDetailsWithSuccess:^(InstagramUser * _Nonnull user) {
//
//    } failure:^(NSError * _Nonnull error, NSInteger serverStatusCode) {
//        NSLog(@"Error : %@",[error description]);
//    }];
    
    self.clearsSelectionOnViewWillAppear = NO;
    [self.collectionView registerClass:[UICollectionReusableView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:YKPhotoCollectionViewHeaderIdentifier];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self setupHUD];
    [self.hud show:YES];

    [YKSocialContentBuilder availablePhotosFromInstagram:^(NSError *error,
                                                           NSArray<YKPhoto *> *photos) {
        self.content = photos;
        [self.collectionView reloadData];
        [self.collectionView performBatchUpdates:nil completion:nil];
        [self.hud dismiss:YES];
    }];
}

- (void)setupHUD
{
    M13ProgressViewRing * ring = [[M13ProgressViewRing alloc] init];
    M13ProgressHUD * hud = [[M13ProgressHUD alloc] initWithProgressView:ring];
    
    hud.progressViewSize = CGSizeMake(60.0, 60.0);
    hud.animationPoint = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2);
    hud.primaryColor = [UIColor colorWithRed:236/255.0f green:221/255.0f blue:208/255.0f alpha:1];
    hud.secondaryColor = [UIColor colorWithRed:236/255.0f green:221/255.0f blue:208/255.0f alpha:1];
    [hud setIndeterminate:YES];
    hud.status = NSLocalizedString(@"Downloading photos",nil);
    
    [self.view addSubview:hud];
    
    self.hud = hud;
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
