//
//  ChengJiaoAnLiModel.h
//  XYGPWuZi
//
//  Created by Lzy on 2018/1/2.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ChengJiaoAnLiModel : JSONModel
@property(copy, nonatomic)NSString<Optional> *tnId, *tnTitle, *tnDeposit, *tnType, *tnPic, *tsStatus, *tsStartTime, *tsEndTime, *tsName, *tsTradeNo, *tsEndPrice, *tnNum, *tnUnits;

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
