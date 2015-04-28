//
//  LogUtils.h
//  WorryClient
//
//  Created by 蔡少武 on 15/4/5.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG

#define JDDebug(format, ...) ([LogUtils output:__FILE__ lineNumber:__LINE__ input:(format), ## __VA_ARGS__])

#else

#define JDDebug(format, ...)

#endif

@interface LogUtils : NSObject

+ (void)output:(const char*)fileName
    lineNumber:(int)lineNumber
         input:(NSString*)input, ...;

@end
