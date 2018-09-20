//
//  Api_JiaoYiYuGao.h
//  XYGPWuZi
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "MyRequest.h"

#import <JSONModel/JSONModel.h>

@interface JiaoYiYuGaoModel : JSONModel
@property(copy, nonatomic)NSString<Optional> *tnId, *tnTitle, *tnAddress, *tnCretime;

@end

@interface Api_JiaoYiYuGao : MyRequest
-(instancetype)initWithTnID:(NSString *)tnID;
@end
