//
//  Model_FacInfo.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/5/3.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "Model_FacInfo.h"

@implementation Model_FacInfo
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"initBank" : @"faceInfo_initBank", @"initAccount" : @"faceInfo_initAccount"}];
}
@end
