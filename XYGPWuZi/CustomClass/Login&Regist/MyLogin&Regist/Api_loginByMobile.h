//
//  Api_loginByMobile.h
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/5/24.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "MyRequest.h"

@interface Api_loginByMobile : MyRequest
-(instancetype)initWithPhoneNum:(NSString *)phoneNum code:(NSString *)code;
@end
