//
//  Api_findBackPsd.h
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/5/24.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "MyRequest.h"

@interface Api_findBackPsd : MyRequest
-(instancetype)initWithMobile:(NSString *)mobile password:(NSString *)password code:(NSString *)code;
@end
