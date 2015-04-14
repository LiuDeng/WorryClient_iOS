//
//  AvatarView.m
//  WorryClient
//
//  Created by 蔡少武 on 15/2/19.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "AvatarView.h"
#import "Masonry.h"
#import "UIView+Utils.h"

@implementation AvatarView

- (id)initWithFrame:(CGRect)frame borderWidth:(CGFloat)borderWidth
{

    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc]init];
        
        [self addSubview:self.imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.equalTo(self);
            make.height.equalTo(self);
        }];

        if (borderWidth < 0.0f) {
            self.layer.borderWidth = borderWidth;
            self.layer.borderColor = [UIColor whiteColor].CGColor;  //  TODO
        }
        [UIView setAsRound:self];
        [UIView setAsRound:self.imageView];
    }
    return self;
}


- (void)addTapGuesture
{
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickOnAvatar:)];
    tapGR.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tapGR];
}
- (void)clickOnAvatar:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(didClickOnAvatarView:)]) {
        [_delegate didClickOnAvatarView:self];
    }else {
        //  TODO
    }
}

@end
