//
//  AddBiddingModel.h
//  XYGPWuZi
//
//  Created by Lzy on 2018/1/8.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "MyProductModel.h"


@interface AddBiddingModel : JSONModel


@property (nonatomic,copy)NSString <Optional>
*piId,
*piName,
*piNumber,
*piUnit,
*piXjcd,
*piCpxh,
*piCpcd,
*piGzxs,
*piStatus,
*piIsuse,
*piModtime,
*piAddress,
*picUrl,
*piSj/*产品状态：0已下架,1已寄售*/,
*codeId;
@property (nonatomic,copy)NSString <Optional>
*token/*登录令牌*/,
*tsId/*场次ID（生成场次不需要该参数，更新场次需要该参数）*/,
*tsSiteType/*场次类型（0单品1拼盘）*/,
*tsName/*场次名称*/,
*tsNoticeDate/*公告日*/,
*tsTradeDate/*竞价日*/,
*tsStartTime/*开始时间*/,
*tsEndTime/*结束时间*/,
*tsMinPrice/*起始价*/,
*tsProtectPrice/*最低出售价*/,
*tsAddPrice/*加价幅度*/,
*tsCountPrice/*总价格*/,
*tsNum/*数量*/,
*tsUnits/*单位*/,
*tsTradeType/*报盘方式（0：单价报盘1：总价报盘）*/,
*tsJjfs/*计价方式（0：重量计价1：数量计价）*/;// *tradeProducts/*场次中产品的集合，单品场次集合中一条数据，拼盘场次集合中多条数据，集合中的参数*/;//, *piId/*产品ID */, *piNumber/*产品数*/;

@property(nonatomic, copy)NSString <Optional>*tnId;//跳转场次详情用到
@property (nonatomic,copy)NSArray <Optional>*tradeProducts;
@property (strong, nonatomic) NSArray<MyProductModel, Optional>* productList;

@property (nonatomic,copy)NSString <Optional>
*tsTradeNo/*场次编号*/,
*tsCreTime/*场次创建时间*/,
*tsIsSuccess/*最终交易状态（0、失败 1、成功 2、流拍）*/;

@end
