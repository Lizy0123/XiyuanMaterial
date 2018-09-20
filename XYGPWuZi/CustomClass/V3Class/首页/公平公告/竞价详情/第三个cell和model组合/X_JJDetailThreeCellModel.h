//
//  X_JJDetailThreeCellModel.h
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/6/14.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface X_JJDetailThreeCellModel : NSObject
//拼盘&场次编号
@property(nonatomic,copy)NSString *tsTradeNo;
//竞价模式
@property(nonatomic,copy)NSString *tnType;
//报盘方式
@property(nonatomic,copy)NSString *tsTradeType;
//计价方式
@property(nonatomic,copy)NSString *tsJjfs;
//总量
@property(nonatomic,copy)NSString *tsNum;
//竞价状态
@property(nonatomic,copy)NSString *isEnd;
@property(nonatomic,copy)NSString *toBegin;
@property(nonatomic,copy)NSString *onGoing;
//起拍价
@property(nonatomic,copy)NSString *tsMinPrice;
//竞价梯度
@property(nonatomic,copy)NSString *tsAddPrice;
//销售底价
@property(nonatomic,copy)NSString *tsProtectPrice;
//成家价格
@property(nonatomic,copy)NSString *tsEndPrice;



@end
