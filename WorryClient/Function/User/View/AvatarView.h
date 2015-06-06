//
//  AvatarView.h
//  WorryClient
//
//  Created by 蔡少武 on 15/2/19.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.pb.h"

typedef NS_ENUM(NSInteger, AvatarViewClickType){
    AvatarViewClickTypeZoom,
    AvatarViewClickTypeUserInfo
};

@interface AvatarView : UIImageView

@property (nonatomic,strong) PBUser *pbUser;

- (id)initWithBorderWidth:(CGFloat)borderWidth;
- (id)initWithPBUser:(PBUser *)pbUser;
- (void)addTapGestureWithClickType:(AvatarViewClickType)type;

@end
