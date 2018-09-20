//
//  Api_tradingRecordList.h
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/5/4.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "MyRequest.h"
#import "JSONModel.h"

@interface Model_TradingRecord:JSONModel
@property (nonatomic,copy)NSString <Optional>
*trObj  /*转入子账户名称*/,
*trType /*业务类型（1支付保证金，2退还保证金，3买家支付尾款，4出金，5入金，6支付平台佣金，7卖家收到尾款，8违约扣款）*/,
*tsNob  /*场次编号*/,
*jylsh  /*交易流水号*/,
*page  /*起始页*/,
*limit  /*每页数量*/,
*begin   /*开始时间(yyyy-MM-dd )*/,
*end   /*结束时间 (yyyy-MM-dd )*/,
*trMoney,
*tsName,
*tradTime,
*tsId
;

@end
@protocol Model_TradingRecord
@end


@interface Model_RecordResponse:JSONModel
@property (nonatomic,copy)NSString <Optional>
*payMoney  /**/,
*getMoney /**/,
*commission  /**/
;
@property(strong, nonatomic)NSArray <Model_TradingRecord>*jsonList;
@end
@interface Api_tradingRecordList : MyRequest
-(instancetype)initWithTradingRecordM:(Model_TradingRecord *)tradingRecordM;
@end
