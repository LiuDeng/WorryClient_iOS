//
//  LogUtils.m
//  WorryClient
//
//  Created by 蔡少武 on 15/4/5.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "LogUtils.h"

@implementation LogUtils

+ (void)output:(const char*)fileName
    lineNumber:(int)lineNumber
         input:(NSString*)input, ...
{
    va_list argList;
    NSString *filePath, *formatStr;
    
    // Build the path string
    filePath = [[NSString alloc] initWithBytes:fileName
                                        length:strlen(fileName)
                                      encoding:NSUTF8StringEncoding];
    
    // Process arguments, resulting in a format string
    va_start(argList, input);
    formatStr = [[NSString alloc] initWithFormat:input arguments:argList];
    va_end(argList);
    
    NSLog(@"%@[%d] %@", [filePath lastPathComponent], lineNumber, formatStr);
}
@end
