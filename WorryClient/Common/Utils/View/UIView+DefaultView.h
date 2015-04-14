//
//  UIView+DefaultView.h
//  WorryClient
//
//  Created by 蔡少武 on 15/4/13.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DefaultView)

//  普通横线
+ (UIView*)creatSingleLineWithColor:(UIColor *)color
                        borderWidth:(CGFloat)borderWidth
                          superView:(id)superView;
//  上方横线
+ (void)addTopLineWithColor:(UIColor *)color
                borderWidth:(CGFloat)borderWidth
                  superView:(id)superView;
//  下方横线
+ (void)addBottomLineWithColor:(UIColor *)color
                   borderWidth:(CGFloat)borderWidth
                     superView:(id)superView;


+(UITextField*)defaultTextField:(NSString*)placeholder
                      superView:(UIView*)superView;
@end
