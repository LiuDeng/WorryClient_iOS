//
//  RecommendationService.m
//  WorryClient
//
//  Created by 蔡少武 on 15/5/15.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "RecommendationService.h"

#define kRecommendationClassName    @"Recommendation"
#define kImageUrlKey                @"imageUrl"
#define kContentKey                 @"content"

@implementation RecommendationService

IMPLEMENT_SINGLETON_FOR_CLASS(RecommendationService)

- (void)requireRecommendationWithBlock:(ServiceErrorResultBlock)block
{
    int dataCount = 3;
    if (_PBRecommendationArray == nil) {
        _PBRecommendationArray = [[NSMutableArray alloc]init];
    }
    
    AVQuery *avQuery = [AVQuery queryWithClassName:kRecommendationClassName];
    [avQuery whereKey:kContentKey notEqualTo:@""];  //   TODO
    [avQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error == nil) {
            NSUInteger count = dataCount < objects.count ? dataCount : objects.count;
            for (int i = 0; i < count ; i++) {
                AVObject *avObject = [objects objectAtIndex:i];
                NSString *imageUrl = [avObject objectForKey:kImageUrlKey];
                NSString *content = [avObject objectForKey:kContentKey];
                PBRecommendationBuilder *bulider = [PBRecommendation builder];
                [bulider setRecommendationId:avObject.objectId];
                [bulider setImage:imageUrl];
                [bulider setFeedId:content];
                PBRecommendation *pbRecommendation = [bulider build];
                [_PBRecommendationArray addObject:pbRecommendation];
            }
        }
        
        EXECUTE_BLOCK(block,error);
    }];
}

- (NSArray *)pbRecommendationArray
{
    return _PBRecommendationArray;
}

@end
