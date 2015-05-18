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
{
    NSMutableArray *_PBRecommendationArray;
}

DEFINE_SINGLETON_FOR_CLASS(RecommendationService)

- (void)requireRecommendation;

/*
 *  called after 'requireRecommendation'
 */
- (NSArray *)pbRecommendationArray;

@end
