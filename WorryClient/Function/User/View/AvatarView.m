//
//  AvatarView.m
//  WorryClient
//
//  Created by 蔡少武 on 15/2/19.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "AvatarView.h"
#import "UIView+Utils.h"
#import "AppDelegate.h"
#import "UserInfoController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "TGRImageViewController.h"

@implementation AvatarView

- (id)initWithBorderWidth:(CGFloat)borderWidth
{
    self = [super init];
    if (self) {
        if (borderWidth > 0.0f) {
            self.layer.borderWidth = borderWidth;
            self.layer.borderColor = [UIColor whiteColor].CGColor;
        }
    }
    return self;
}

- (id)initWithPBUser:(PBUser *)pbUser
{
    self = [self initWithBorderWidth:1.0f];
    self.pbUser = pbUser;
    NSURL *url = [NSURL URLWithString:pbUser.avatar];
    [self sd_setImageWithURL:url];
    [self addTapGestureWithClickType:AvatarViewClickTypeUserInfo];
    return self;
}

- (void)addTapGestureWithClickType:(AvatarViewClickType)type
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGR;
    switch (type) {
        case AvatarViewClickTypeUserInfo:{
            tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(displayUserInfo)];
            break;
        }
        case AvatarViewClickTypeZoom:{
            tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zoomAvatar)];
            break;
        }
        default:
            break;
    }
    [self addGestureRecognizer:tapGR];
}

#pragma mark - Utils

- (void)displayUserInfo
{
    JDDebug(@"avatar click");
    AppDelegate* delegate = [UIApplication sharedApplication].delegate;
    UINavigationController* currentNavigationController = delegate.currentNavigationController;
    UserInfoController *vc = [[UserInfoController alloc]initWithPBUser:self.pbUser];
    [currentNavigationController pushViewController:vc animated:YES];
}

- (void)zoomAvatar
{
    JDDebug(@"avatar click");
    AppDelegate* delegate = [UIApplication sharedApplication].delegate;
    UINavigationController* currentNavigationController = delegate.currentNavigationController;
    TGRImageViewController *vc = [[TGRImageViewController alloc]initWithImage:self.image];
    [currentNavigationController pushViewController:vc animated:YES];
}

#pragma mark - Default methods

-(void)layoutSubviews
{
    [super layoutSubviews];
    [UIView setAsRound:self];
}

@end
