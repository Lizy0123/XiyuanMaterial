//
//  MyRequest.h
//  LzyTool
//
//  Created by 河北熙元科技有限公司 on 2018/3/27.
//  Copyright © 2018年 熙元科技有限公司. All rights reserved.
//

#import "YTKRequest.h"
#import "YTKBaseRequest+AnimatingAccessory.h"
#import "WMHUDUntil.h"

//@class ZCHTTPError;
@interface MyRequest : YTKRequest

//@property (nonatomic,strong) ZCHTTPError * httpError;

- (BOOL)isHideErrorToast;
@end
