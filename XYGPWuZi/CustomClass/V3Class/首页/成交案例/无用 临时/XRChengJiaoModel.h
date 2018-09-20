//
//  XRChengJiaoModel.h
//  XYGPWuZi
//
//  Created by apple on 2017/10/19.
//  Copyright © 2017年 xiaoRan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XRChengJiaoModel : NSObject

@property(nonatomic,copy)NSString *tnId;
@property(nonatomic,copy)NSString *tnTitle;
@property(nonatomic,copy)NSString *tnDeposit;
@property(nonatomic,copy)NSString *tnType;
@property(nonatomic,copy)NSString *tnPic;
@property(nonatomic,copy)NSString *tsStatus;
@property(nonatomic,copy)NSString *tsStartTime;
@property(nonatomic,copy)NSString *tsEndTime;
@property(nonatomic,copy)NSString *tsName;
@property(nonatomic,copy)NSString *tsTradeNo;
@property(nonatomic,copy)NSString *tsEndPrice;
@property(nonatomic,copy)NSString *tnNum;
@property(nonatomic,copy)NSString *tnUnits;

+(XRChengJiaoModel *)analysisWithDic:(NSDictionary *)aDic;

/*
 tnDeposit = 2000;
 tnId = 402880a055fc886b0155fc8d54ef0004;
 tnNum = 1;
 tnPic = "upload/xzwz/images/201607051007187001.jpg";
 tnTitle = "\U805a\U6c28\U916f\U7ec6\U7b5b\U7f51\U62cd\U5356\U516c\U544a";
 tnType = 0;
 tnUnits = "\U4e2a";
 tsEndPrice = 23600;
 tsEndTime = "2017-03-16 18:03:00";
 tsName = "\U805a\U6c28\U916f\U7ec6\U7b5b\U7f51\U62cd\U5356";
 tsStartTime = "2017-03-16 14:00:00";
 tsStatus = 0;
 tsTradeNo = P2016071813436367636;
 */
@end
