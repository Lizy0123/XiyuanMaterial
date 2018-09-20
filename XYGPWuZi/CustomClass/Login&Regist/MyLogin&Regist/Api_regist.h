//
//  Api_regist.h
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/5/25.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "MyRequest.h"

@interface Model_regist : JSONModel
@property(copy, nonatomic)NSString<Optional>
*account/*zhanghao*/,
*password/**/,
*name,
*mobile/**/,
*code,
*type,
*companyName
;
@end

@interface Api_regist : MyRequest
-(instancetype)initWithRegistM:(Model_regist *)regidtM;
@end
