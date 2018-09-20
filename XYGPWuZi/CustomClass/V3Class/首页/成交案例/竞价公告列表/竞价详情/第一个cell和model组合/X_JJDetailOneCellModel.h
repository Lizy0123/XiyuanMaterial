//
//  X_JJDetailOneCellModel.h
//  XYGPWuZi
//
//  Created by apple on 2017/6/14.
//  Copyright © 2017年 xiaoRan. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface X_JJDetailOneCellModel : NSObject

//标题
@property(nonatomic,copy)NSString *tnTitle;
//发布时间
@property(nonatomic,copy)NSString *tnCreTime;
//场次编号
@property(nonatomic,copy)NSString *tsTradeNo;
//数量
@property(nonatomic,copy)NSString *tnNum;
//重量
@property(nonatomic,copy)NSString *tnWeigth;
//竞价时间
@property(nonatomic,copy)NSString *tnTradeDate;
//竞价模式
@property(nonatomic,copy)NSString *tnType;
//会员属性
@property(nonatomic,copy)NSString *tnUserType;
//延时机制
@property(nonatomic,copy)NSString *tnYyjz;
//保留价
@property(nonatomic,copy)NSString *thBlPrice;
//tnId
@property(nonatomic,copy)NSString *tnId;

@end


