//
//  THLabel+Utils.m
//  WorryClient
//
//  Created by 蔡少武 on 15/6/3.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "THLabel+Utils.h"
#import "Utils.h"

@implementation THLabel (Utils)

- (void)customColorByBGImageView:(UIImageView *)imageView
{
    self.strokeSize = 1.0f;
    BOOL isBGLightColor = [Utils isLightColorInImageView:imageView];
    if (isBGLightColor) {
        self.textColor = [UIColor whiteColor];
        self.strokeColor = [UIColor blackColor];
    }else{
        self.textColor = [UIColor blackColor];
        self.strokeColor = [UIColor whiteColor];
    }
}

@end
