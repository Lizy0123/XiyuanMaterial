//
//  Api_tradingRecordList.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/5/4.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "Api_tradingRecordList.h"

@implementation Model_TradingRecord

@end

@implementation Model_RecordResponse

@end

@implementation Api_tradingRecordList{
    Model_TradingRecord *_tradingRecordM;
}
-(instancetype)initWithTradingRecordM:(Model_TradingRecord *)tradingRecordM{
    if (self = [super init]) {
        _tradingRecordM = tradingRecordM;
    }return self;
}
-(NSString *)requestUrl{
    return @"xy/money/tradingRecordList";
}
-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}
-(id)requestArgument{
    return @{
             @"token":[UserManager readUserInfo].token,
             @"trObj":[NSObject isString:_tradingRecordM.trObj]?_tradingRecordM.trObj:@"",
             @"trType":[NSObject isString:_tradingRecordM.trType]?_tradingRecordM.trType:@"",
             @"tsNob":[NSObject isString:_tradingRecordM.tsNob]?_tradingRecordM.tsNob:@"" ,
             @"jylsh":[NSObject isString:_tradingRecordM.jylsh]?_tradingRecordM.jylsh:@"" ,
             @"page":[NSObject isString:_tradingRecordM.page]?_tradingRecordM.page:@"" ,
             @"limit":[NSObject isString:_tradingRecordM.limit]?_tradingRecordM.limit:@"" ,
             @"begin":[NSObject isString:_tradingRecordM.begin]?_tradingRecordM.begin:@"" ,
             @"end":[NSObject isString:_tradingRecordM.end]?_tradingRecordM.end:@"" ,
             };
}
@end
