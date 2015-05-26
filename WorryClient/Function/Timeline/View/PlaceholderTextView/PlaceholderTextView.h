//
//  PlaceholderTextView.h
//  BarrageClient
//
//  Created by 蔡少武 on 15/2/5.
//  Copyright (c) 2015年 PIPICHENG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceholderTextView : UITextView

@property (copy,nonatomic) NSString *placeholder;
@property (strong,nonatomic) UIColor *placeholderColor;
@property (strong,nonatomic) UIFont *placeholderFont;
- (id)initWithPlaceholder:(NSString*)placeholder
         placeholderColor:(UIColor*)color
          placeholderFont:(UIFont*)font;
- (id)initWithPlaceholder:(NSString*)placeholder;
@end
