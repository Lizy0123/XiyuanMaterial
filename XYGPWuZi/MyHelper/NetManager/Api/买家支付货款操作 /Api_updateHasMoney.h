//
//  Api_updateHasMoney.h
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/5/16.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "MyRequest.h"

@interface Api_updateHasMoney : MyRequest
-(instancetype)initWithCpId:(NSString *)cpId phoneCode:(NSString *)phoneCode;
@end
