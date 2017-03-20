//
//  YKSocialContentBuilder.h
//  SocialStorage
//
//  Created by Yevhen Kharytonenko on 2/23/17.
//  Copyright © 2017 Yevhen Kharytonenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKPhoto.h"

@interface YKSocialContentBuilder : NSObject
+ (void)availablePhotosFromInstagram:(void (^)(NSError * error,NSArray <YKPhoto *>* photos))complitionHandler;
@end
