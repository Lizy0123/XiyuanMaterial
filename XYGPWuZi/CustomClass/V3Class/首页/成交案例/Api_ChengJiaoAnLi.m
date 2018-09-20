//
//  Api_ChengJiaoAnLi.m
//  XYGPWuZi
//
//  Created by apple on 2018/9/13.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "Api_ChengJiaoAnLi.h"
@implementation Model_ChengJiaoAnLi

@end

@implementation Api_ChengJiaoAnLi{
    Model_ChengJiaoAnLi *_successCaseM;
}
-(instancetype)initWithSuccessModel:(Model_ChengJiaoAnLi *)successCaseM{
    if (self = [super init]) {
        _successCaseM = successCaseM;
    }return self;
}
-(NSString *)requestUrl{
    return kPath_TradeNoticeList;
}
-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}
-(id)requestArgument{
    return @{
             @"pageNum":([NSObject isString:_successCaseM.pageNum]?_successCaseM.pageNum:@""),
             @"pageSize":([NSObject isString:_successCaseM.pageSize]?_successCaseM.pageSize:@"")/**/,
             @"status":([NSObject isString:_successCaseM.status]?_successCaseM.status:@"")/**/,
             @"tnCreTime":([NSObject isString:_successCaseM.tnCreTime]?_successCaseM.tnCreTime:@"")/**/,
             @"tnModtime":([NSObject isString:_successCaseM.tnModtime]?_successCaseM.tnModtime:@"")/**/,
             @"classOne":([NSObject isString:_successCaseM.classOne]?_successCaseM.classOne:@"")/**/,
             @"tsSiteType":([NSObject isString:_successCaseM.tsSiteType]?_successCaseM.tsSiteType:@"")/**/,
             @"tnUserType":([NSObject isString:_successCaseM.tnUserType]?_successCaseM.tnUserType:@"")/**/,
             };
}
@end
