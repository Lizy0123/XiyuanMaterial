//
//  HistoryModel.m
//  XYGPWuZi
//
//  Created by felix on 16/9/1.
//  Copyright © 2016年 河北熙元科技有限公司. All rights reserved.
//

#import "HistoryModel.h"

@implementation HistoryModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"itemsArray" : ContentModel.class};
}

@end

@implementation ContentModel

@end
