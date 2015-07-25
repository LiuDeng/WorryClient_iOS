//
//  RecommendationService.h
//  WorryClient
//
//  Created by 蔡少武 on 15/5/15.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "CommonService.h"
#import "Recommendation.pb.h"

@interface RecommendationService : CommonService

DEFINE_SINGLETON_FOR_CLASS(RecommendationService)

- (void)getRecommendationsWithBlock:(ServiceArrayResultBlock)block;

@end
