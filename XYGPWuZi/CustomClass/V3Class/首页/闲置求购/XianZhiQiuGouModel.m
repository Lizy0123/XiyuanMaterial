//
//  XianZhiQiuGouModel.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/10/20.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "XianZhiQiuGouModel.h"

@implementation XianZhiQiuGouModel

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


+(XianZhiQiuGouModel *)analysisWithDic:(NSDictionary *)aDic{
    
    XianZhiQiuGouModel *model = [[XianZhiQiuGouModel alloc]initWithDic:aDic];
    return model;
    
}

@end
