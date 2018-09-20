//
//  X_JJDetailFourCellModel.m
//  XYGPWuZi
//
//  Created by apple on 2017/6/14.
//  Copyright © 2017年 xiaoRan. All rights reserved.
//

#import "X_JJDetailFourCellModel.h"

@implementation X_JJDetailFourCellModel
- (id)valueForUndefinedKey:(NSString *)key{
    return nil;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
}

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
        
        
    }
    return self;
}
+(X_JJDetailFourCellModel *)modeleWithDictionary:(NSDictionary *)dic{
    
    X_JJDetailFourCellModel *model = [[X_JJDetailFourCellModel alloc]initWithDic:dic];
    
    return model;
    
    
}
@end
