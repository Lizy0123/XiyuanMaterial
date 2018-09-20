//
//  XRChengJiaoModel.m
//  XYGPWuZi
//
//  Created by apple on 2017/10/19.
//  Copyright © 2017年 xiaoRan. All rights reserved.
//

#import "XRChengJiaoModel.h"

@implementation XRChengJiaoModel
-(id)valueForUndefinedKey:(NSString *)key{
    
    return nil;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

-(instancetype)initWithDic:(NSDictionary *)dic{
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return  self;
    
}
+(XRChengJiaoModel *)analysisWithDic:(NSDictionary *)aDic
{
    
    XRChengJiaoModel *model = [[XRChengJiaoModel alloc]initWithDic:aDic];
    return model;
    
    
}

@end
