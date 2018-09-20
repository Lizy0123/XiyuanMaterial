//
//  X_JJDetailFourCellModel.h
//  XYGPWuZi
//
//  Created by apple on 2017/6/14.
//  Copyright © 2017年 xiaoRan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface X_JJDetailFourCellModel : NSObject


//产品编号
@property(nonatomic,copy)NSString *piCode;
//品名
@property(nonatomic,copy)NSString *piName;
//仓库
@property(nonatomic,copy)NSString *piWarehouse;
//新旧程度
@property(nonatomic,copy)NSString *piXjcd;
//产品型号
@property(nonatomic,copy)NSString *piCpxh;
//产品产地
@property(nonatomic,copy)NSString *piCpcd;
//产品数量
@property(nonatomic,copy)NSString *pNum;
//产品重量
@property(nonatomic,copy)NSString *pWeight;
//捆包号
@property(nonatomic,copy)NSString *piKbh;
//产品规格
@property(nonatomic,copy)NSString *piCcgg;
//资源号
@property(nonatomic,copy)NSString *piZyh;

+(X_JJDetailFourCellModel *)modeleWithDictionary:(NSDictionary *)dic;


/*
 
 piName：品名 |
 piWarehouse：仓库|
 piXjcd：新旧程度 |
 piCpxh：产品型号 |
 piCpcd：产品产地 |
 piCode：产品编号 |
 pNum：产品数量 |
 pWeight：产品重量 |
 piKbh：捆包号 |
 piCcgg：产品规格 |
 piZyh：资源号
 
 */


@end
