//
//  PriceRangeModel.h
//  ZYSideSlipFilter
//
//  Created by zhiyi on 16/10/21.
//  Copyright © 2016年 zhiyi. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PRICE_RANGE_MODEL @"PRICE_RANGE_MODEL"

@interface PriceRangeModel : NSObject
@property (copy, nonatomic) NSString *firstTime;
@property (copy, nonatomic) NSString *secondTime;
@property(copy, nonatomic)NSString *keyWord;
@end
