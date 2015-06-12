//
//  Utils.h
//  WorryClient
//
//  Created by 蔡少武 on 15/4/15.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define EXECUTE_BLOCK(A,...)            if(A != NULL) {A(__VA_ARGS__);}

@interface Utils : NSObject

+ (NSString *)getUUID;
+ (NSString *)appendArray:(NSArray *)array with:(NSString *)symbol; //  the name should change
+ (BOOL)isLightColorInImage:(UIImage *)image;
+ (BOOL)isLightColorInImageView:(UIImageView *)imageView;
+ (NSString *)dateStringCompareToDate:(NSDate *)date;
+ (NSString *)dateStringCompareTo:(int64_t)timestamp;
+ (BOOL)isValidEmail:(NSString *)checkString;
+ (BOOL)isValidMobile:(NSString *)checkString;

@end
