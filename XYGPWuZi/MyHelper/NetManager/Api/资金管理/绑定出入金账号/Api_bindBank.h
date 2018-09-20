//
//  Api_bindBank.h
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/5/4.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "MyRequest.h"
#import "JSONModel.h"

@interface Model_BindBank : JSONModel

@property (nonatomic,copy)NSString <Optional>
*fbaId /*账户id*/,
*fbaBankBs/*0、平安银行 1、其它银行*/,
*fbaBankHh /*出入金银行行号*/,
*fbaBankHm /*出入金银行行名*/,
*fbaBankName /*出入金账户名称*/,
*fbaBankNo /*出入金账户号码*/;

@end

@interface Api_bindBank : MyRequest

-(instancetype)initWithModelBindBank:(Model_BindBank *)openAccountM;
@end
