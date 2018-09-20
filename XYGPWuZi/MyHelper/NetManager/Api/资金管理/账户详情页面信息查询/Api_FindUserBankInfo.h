//
//  Api_FindUserBankInfo.h
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/5/3.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "MyRequest.h"
#import "JSONModel.h"
#import "Model_FacUser.h"

@interface Model_dm:JSONModel
@property (copy, nonatomic) NSString<Optional>
*dmCode/**/,
*dmId/**/,
*dmMoney/**/,
*dmBankName/**/,
*dmDatetime/**/,
*dmCodeName/**/,
*dmBankNo/**/,
*dmStatus/**/,
*dmRefuseReason
;
@property (strong, nonatomic) Model_FacUser* facUser;


@end

@interface Api_FindUserBankInfo : MyRequest
-(instancetype)init;
@end
