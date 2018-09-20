//
//  Api_findDepositForUpdate.h
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/5/4.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "MyRequest.h"
#import "Model_FacUser.h"

@interface Model_TradeSite:JSONModel
@property(copy, nonatomic)NSString<Optional>
*tsName/*场次名称*/,
*tsTradeNo/*场次编号*/,
*tsStartTime,
*zizhanghao//银行监管账号
;
@end

@interface Model_Trade:JSONModel
@property(copy, nonatomic)NSString<Optional>
*diNeedPay/*需要支付的金额*/,
*diHasPay/*已经支付的金额*/,
*diId;
@property(strong, nonatomic)Model_FacUser *facUser;
@property(strong, nonatomic)Model_TradeSite *tradeSite;
@end


@interface Api_findDepositForUpdate : MyRequest
-(instancetype)initWithtsId:(NSString *)tsId;
@end
