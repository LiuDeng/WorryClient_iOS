//
//  UIViewController+Utils.h
//  WorryClient
//
//  Created by 蔡少武 on 15/4/22.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Utils)

- (void)addRightButtonWithTitle:(NSString*)title
                         target:(id)target
                         action:(SEL)action;

- (void)addRightButtonWithImageName:(NSString*)imageName
                             target:(id)target
                             action:(SEL)action;
- (void)loadBackButton;
@end
