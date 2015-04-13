//
//  AvatarView.h
//  WorryClient
//
//  Created by 蔡少武 on 15/2/19.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AvatarView;

@protocol AvatarViewDelegate <NSObject>

@optional
- (void)didClickOnAvatarView:(AvatarView *)avatarView;

@end


@interface AvatarView : UIView

- (id)initWithFrame:(CGRect)frame borderWidth:(CGFloat)borderWidth;
//- (void)setAsRound;

@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,assign)id<AvatarViewDelegate> delegate;

@end
