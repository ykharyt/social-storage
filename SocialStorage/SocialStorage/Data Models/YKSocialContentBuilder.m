//
//  YKSocialContentBuilder.m
//  SocialStorage
//
//  Created by Yevhen Kharytonenko on 2/23/17.
//  Copyright © 2017 Yevhen Kharytonenko. All rights reserved.
//

#import "YKSocialContentBuilder.h"

#import "InstagramEngine.h"
#import "InstagramMedia.h"
#import "InstagramComment.h"

@implementation YKSocialContentBuilder

+ (void)availablePhotosFromInstagram:(void (^)(NSError * error,NSArray <YKPhoto *>* photos))complitionHandler
{
    [[InstagramEngine sharedEngine] getSelfRecentMediaWithSuccess:^(NSArray<InstagramMedia *> * _Nonnull media, InstagramPaginationInfo * _Nonnull paginationInfo) {
        NSMutableArray * photos = [NSMutableArray array];
        for (InstagramMedia * instaMedia in media) {
            if (![instaMedia isVideo]) {
                YKPhoto * photo = [YKPhoto new];
                photo.imageName = instaMedia.caption.text;
                photo.imageInStandartResolution = [self getImageFromURL:instaMedia.standardResolutionImageURL];
                [photos addObject:photo];
            }
        }
        complitionHandler(nil,[photos copy]);
    } failure:^(NSError * _Nonnull error, NSInteger serverStatusCode) {
        complitionHandler(error,nil);
    }];
}

+ (void)availableVideosFromInstagram:(void (^)(NSError * error,NSArray * videos))complitionHandler
{
    [[InstagramEngine sharedEngine] getSelfRecentMediaWithSuccess:^(NSArray<InstagramMedia *> * _Nonnull media, InstagramPaginationInfo * _Nonnull paginationInfo) {
        NSMutableArray * videos = [NSMutableArray array];
        for (InstagramMedia * instaMedia in media) {
            if ([instaMedia isVideo]) {
                
            }
        }
        complitionHandler(nil,[videos copy]);
    } failure:^(NSError * _Nonnull error, NSInteger serverStatusCode) {
        complitionHandler(error,nil);
    }];
}

//[[InstagramEngine sharedEngine] getSelfUserDetailsWithSuccess:^(InstagramUser * _Nonnull user) {
//    
//} failure:^(NSError * _Nonnull error, NSInteger serverStatusCode) {
//    
//}];

#pragma mark - Helpers

+ (UIImage *)getImageFromURL:(NSURL *)fileURL
{
    UIImage * result = nil;
    NSData * data = [NSData dataWithContentsOfURL:fileURL];
    result = [UIImage imageWithData:data];
    return result;
}

@end
