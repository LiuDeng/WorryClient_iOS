//
//  UIImageView+Worry.h
//  WorryClient
//
//  Created by 蔡少武 on 15/6/17.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "User.pb.h"

@interface UIImageView (Worry)

- (void)setAvatarWithPBUser:(PBUser *)pbUser;
- (void)setBGImageWithPBUser:(PBUser *)pbUser;
- (void)setImageWithURLStr:(NSString *)urlStr placeholderImageName:(NSString *)imageName;

@end
