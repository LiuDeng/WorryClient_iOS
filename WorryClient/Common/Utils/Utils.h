//
//  Utils.h
//  WorryClient
//
//  Created by 蔡少武 on 15/4/15.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import <Foundation/Foundation.h>

#define EXECUTE_BLOCK(A,...)            if(A != NULL) {A(__VA_ARGS__);}

@interface Utils : NSObject

@end
