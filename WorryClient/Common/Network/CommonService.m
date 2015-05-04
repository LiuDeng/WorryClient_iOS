//
//  CommonService.m
//  WorryClient
//
//  Created by 蔡少武 on 15/4/12.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "CommonService.h"

//const CGFloat kUpdateImageQuality = 1.0f;

@implementation CommonService

- (void)updateImage:(UIImage *)image imageName:(NSString *)imageName block:(ServiceImageBlock)block
{
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5f);
    AVFile *avFile = [AVFile fileWithName:imageName data:imageData];
    [avFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            EXECUTE_BLOCK(block,error,avFile.url);
        }
    }];
}


@end
