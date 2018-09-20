//
//  X_JingJiaGongGaoModel.h
//  XYGPWuZi
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 xiaoRan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface X_JingJiaGongGaoModel : NSObject

@property(nonatomic,copy)NSString *tnId;
@property(nonatomic,copy)NSString *tnTitle;
@property(nonatomic,copy)NSString *tnDeposit;
@property(nonatomic,copy)NSString *tnNum;
@property(nonatomic,copy)NSString *tnUnits;
@property(nonatomic,copy)NSString *tnType;
@property(nonatomic,copy)NSString *tnPic;
@property(nonatomic,copy)NSString *tsStatus;
@property(nonatomic,copy)NSString *tsStartTime;
@property(nonatomic,copy)NSString *tsEndTime;
@property(nonatomic,copy)NSString *tsName;
@property(nonatomic,copy)NSString *tsTradeNo;
@property(nonatomic,copy)NSString *tsEndPrice;

/*
 tnDeposit = 10000;
 tnId = 402880865f0ee27a015f0f65f9cd000f;
 tnNum = 1;
 tnPic = "upload/xzwz/images/201607051007821001.jpg";
 tnTitle = "\U738b\U5c0f\U5189\U7ade\U4ef7\U6d4b\U8bd5\U62cd\U5356 ";
 tnType = 0;
 tnUnits = "\U4e2a";
 tsEndTime = "2017-10-20 15:00:00";
 tsName = "\U738b\U5c0f\U5189\U7ade\U4ef7\U6d4b\U8bd5\U62cd\U5356";
 tsStartTime = "2017-10-12 15:08:00";
 tsStatus = 0;
 tsTradeNo = P20171012150345510455;
 */








/* 1.0 */
/* 字段
 isEnd = 0;
 onGoing = 0;
 picUrl = "upload/xzwz/images/user/20170923150994004.jpg";
 tnCode = 10000099;
 tnId = 8a88888a5ed201fe015f0e477ef3003c;
 tnTitle = "\U7b5b\U7ade\U62cd\U516c\U544a";
 tnTradeDate = "2017/10/12 09:59--10:05 ";
 toBegin = 0;
 
 


@property(nonatomic,copy)NSString *isEnd;
@property(nonatomic,copy)NSString *onGoing;
@property(nonatomic,copy)NSString *picUrl;
@property(nonatomic,copy)NSString *tnCode;
@property(nonatomic,copy)NSString *tnId;
@property(nonatomic,copy)NSString *tnTitle;
@property(nonatomic,copy)NSString *tnTradeDate;
@property(nonatomic,copy)NSString *toBegin;
*/
@end
