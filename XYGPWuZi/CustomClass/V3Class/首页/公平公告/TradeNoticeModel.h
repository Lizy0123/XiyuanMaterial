//
//  TradeNoticeModel.h
//  XYGPWuZi
//
//  Created by Lzy on 2018/1/2.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface TradeNoticeModel : JSONModel
@property(copy, nonatomic)NSString<Optional> *tnId, *tnTitle, *tnDeposit, *tnNum, *tnUnits, *tnType, *tnPic, *tsStatus, *tsStartTime, *tsEndTime, *tsName, *tsTradeNo, *tsEndPrice;

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
