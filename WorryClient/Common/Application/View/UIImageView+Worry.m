//
//  UIImageView+Worry.m
//  WorryClient
//
//  Created by 蔡少武 on 15/6/17.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "UIImageView+Worry.h"

@implementation UIImageView (Worry)

- (void)setImageWithURLStr:(NSString *)urlStr placeholderImageName:(NSString *)imageName
{
    NSURL *url = [NSURL URLWithString:urlStr];
    UIImage *image = [UIImage imageNamed:imageName];
    [self sd_setImageWithURL:url placeholderImage:image];
}

- (void)setAvatarWithPBUser:(PBUser *)pbUser
{
//    if (pbUser.avatar.length>0) {
//        NSURL *url = [NSURL URLWithString:pbUser.avatar];
//        [self sd_setImageWithURL:url];
//    }else{
//        //  YES:male,NO:female
//        BOOL isMale = pbUser.gender;
//        NSString *imageName;
//        imageName = isMale ?  @"avatar_male" : @"avatar_female";
//        [self setImageWithURLStr:pbUser.avatar placeholderImageName:imageName];
//    }
    BOOL isMale = pbUser.gender;
    NSString *imageName;
    imageName = isMale ?  @"avatar_male" : @"avatar_female";
    [self setImageWithURLStr:pbUser.avatar placeholderImageName:imageName];

}

- (void)setBGImageWithPBUser:(PBUser *)pbUser
{
    NSString *urlStr = pbUser.bgImage;
    NSString *imageName = @"user_bg_image";
    [self setImageWithURLStr:urlStr placeholderImageName:imageName];
}

@end
