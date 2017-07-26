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
    [[InstagramEngine sharedEngine] getSelfRecentMediaWithSuccess:^(NSArray<InstagramMedia *> * _Nonnull media,
                                                                    InstagramPaginationInfo * _Nonnull paginationInfo) {
        NSMutableArray * photos = [NSMutableArray array];
        for (InstagramMedia * instaMedia in media) {
            if (![instaMedia isVideo]) {
                YKPhoto * photo                 = [YKPhoto new];
                photo.imageName                 = instaMedia.caption.text;
                photo.imageInStandartResolution = [self getImageFromURL:instaMedia.standardResolutionImageURL];
                [photos addObject:photo];
            }
        }
        complitionHandler(nil,[photos copy]);
    } failure:^(NSError * _Nonnull error, NSInteger serverStatusCode) {
        complitionHandler(error,nil);
    }];
}

+ (void)availableVideosFromInstagram:(void (^)(NSError * error,NSArray <YKVideo *>* videos))complitionHandler
{
    [[InstagramEngine sharedEngine] getSelfRecentMediaWithSuccess:^(NSArray<InstagramMedia *> * _Nonnull media,
                                                                    InstagramPaginationInfo * _Nonnull paginationInfo) {
        NSMutableArray * videos  = [NSMutableArray array];
        for (InstagramMedia * instaMedia in media) {
            if ([instaMedia isVideo]) {
                YKVideo * video = [YKVideo new];
                video.videoName = instaMedia.caption.text;
                [videos addObject:video];
            }
        }
        complitionHandler(nil,[videos copy]);
    } failure:^(NSError * _Nonnull error, NSInteger serverStatusCode) {
        complitionHandler(error,nil);
    }];
}

+ (void)availablePhotosFromFacebook:(void (^)(NSError *, NSArray<YKPhoto *> *))complitionHandler
{
    
}

+ (void)availableVideosFromFacebook:(void (^)(NSError *, NSArray<YKVideo *> *))complitionHandler
{
    
}

#pragma mark - Helpers

+ (UIImage *)getImageFromURL:(NSURL *)fileURL
{
    NSData * data = [NSData dataWithContentsOfURL:fileURL];
    return [UIImage imageWithData:data];
}

@end
