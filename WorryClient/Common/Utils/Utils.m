//
//  Utils.m
//  WorryClient
//
//  Created by 蔡少武 on 15/4/15.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (NSString *)getUUID
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    NSString* retStr = (__bridge_transfer NSString *)string;
    return [[retStr stringByReplacingOccurrencesOfString:@"-" withString:@""] lowercaseString];
}

+ (NSString *)appendArray:(NSArray *)array with:(NSString *)symbol
{
    NSMutableString *string = [[NSMutableString alloc]init];
    for (int i = 0; i<array.count; i++) {
        NSString *tempStr = [array objectAtIndex:i];
        if (i == array.count-1) {
            [string appendFormat:@"%@",tempStr];
        }else{
            [string appendFormat:@"%@",tempStr];
            [string appendString:symbol];
        }
    }
    return string;
}
@end
