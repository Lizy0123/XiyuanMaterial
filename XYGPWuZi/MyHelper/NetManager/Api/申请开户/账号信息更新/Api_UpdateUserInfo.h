//
//  Api_UpdateUserInfo.h
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/5/3.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "MyRequest.h"
#import "Model_FacUser.h"
#import "Model_FacInfo.h"

@interface Api_UpdateUserInfo : MyRequest
-(instancetype)initWithFacUser:(Model_FacUser *)facUser withFacInfo:(Model_FacInfo *)facInfo phoneCode:(NSString *)phoneCode;
@end
