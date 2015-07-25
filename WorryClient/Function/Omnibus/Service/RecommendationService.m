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
/**
 *  Get recommendations
 *
 *  @param block return the pbRecommendations
 */
- (void)getRecommendationsWithBlock:(ServiceArrayResultBlock)block
{
    AVQuery *avQuery = [AVQuery queryWithClassName:kRecommendationClassName];
    [avQuery whereKey:kContentKey notEqualTo:@""];  //   TODO
    avQuery.cachePolicy = kAVCachePolicyCacheElseNetwork;
    avQuery.maxCacheAge = kMaxCacheAge;
    [avQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSMutableArray *pbObjects = [[NSMutableArray alloc]init];
        if (error == nil) {
            for (AVObject *avObject in objects) {
                PBRecommendation *pbRecommendation = [self pbRecommendationWithAVObject:avObject];
                [pbObjects addObject:pbRecommendation];
            }
        }
        EXECUTE_BLOCK(block,pbObjects,error);
    }];
}
/**
 *  Get pbRecommendation with all info from avObject with className:Recommendation.
 *
 *  @param avObject AVObject with className "Recommendation"
 *
 *  @return pbRecommendation with all info
 */
- (PBRecommendation *)pbRecommendationWithAVObject:(AVObject *)avObject
{
    NSString *imageUrl = [avObject objectForKey:kImageUrlKey];
    NSString *content = [avObject objectForKey:kContentKey];
    PBRecommendationBuilder *bulider = [PBRecommendation builder];
    [bulider setRecommendationId:avObject.objectId];
    [bulider setImage:imageUrl];
    [bulider setFeedId:content];
    return [bulider build];
}

@end
