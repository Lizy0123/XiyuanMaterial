//
//  Api_JiaoYiYuGao.m
//  XYGPWuZi
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "Api_JiaoYiYuGao.h"
@implementation JiaoYiYuGaoModel

@end

@implementation Api_JiaoYiYuGao{
    NSString *_tnId;
}
-(instancetype)initWithTnID:(NSString *)tnID{
    if (self = [super init]) {
        _tnId = tnID;
    }return self;
}
-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}
- (NSString *)requestUrl {
    return @"xy/advanceNotice/getAdvanceNoticeDetail.json";
}

- (id)requestArgument {
    return @{
             @"tnId": _tnId,
             };
}

@end
