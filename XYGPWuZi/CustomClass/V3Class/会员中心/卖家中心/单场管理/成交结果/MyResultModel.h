//
//  MyResultModel.h
//  XYGPWuZi
//
//  Created by Lzy on 2018/1/10.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "MyProductModel.h"

@interface MyResultModel : JSONModel
//我的场次成交结果
@property(nonatomic, copy)NSString <Optional>
*tsName/*场次名称*/,
*tsEndPrice/*成交价*/,
*tsTradeNo/*场次编号*/,
*buyTime/*竞得时间*/,
*tsMinPrice/*起拍价*/,
*buyUsername/*竞得方*/,
*bidCount/*出价次数*/;

//查询我的竞价成交结果
@property(nonatomic, copy)NSString <Optional>
*diNeedPay/**/,
*saleUsername,
*tsSiteType;

@property(nonatomic, copy)NSArray <MyProductModel, Optional>*productList;

@end
