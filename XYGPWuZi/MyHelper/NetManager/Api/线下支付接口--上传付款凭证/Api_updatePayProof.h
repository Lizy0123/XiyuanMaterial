//
//  Api_updatePayProof.h
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/5/4.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "MyRequest.h"

@interface Api_updatePayProof : MyRequest
-(instancetype)initWithdiId:(NSString *)diId payProof:(NSString *)payProof;
@end
