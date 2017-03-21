//
//  YKPhotoCollectionViewCell.h
//  SocialStorage
//
//  Created by Yevhen Kharytonenko on 2/18/17.
//  Copyright © 2017 Yevhen Kharytonenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKPhotoCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *imageName;
@end
