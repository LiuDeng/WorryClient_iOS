//
//  DataUtils.h
//  WorryClient
//
//  Created by 蔡少武 on 15/4/12.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import <Foundation/Foundation.h>

#define USER_DEFAULTS_GET(key)                   ( (key != nil) ? [[NSUserDefaults standardUserDefaults] objectForKey:key] : nil )
#define USER_DEFAULTS_REMOVE(key)                ( (key != nil) ? [[NSUserDefaults standardUserDefaults] removeObjectForKey:key] : nil )

@interface DataUtils : NSObject

@end
