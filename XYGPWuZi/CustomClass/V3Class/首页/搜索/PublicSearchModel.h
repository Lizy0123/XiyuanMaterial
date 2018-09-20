//
//  PublicSearchModel.h
//  XYGPWuZi
//
//  Created by Lzy on 2018/1/2.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "TradeNoticeModel.h"
#import "Api_JiaoYiYuGao.h"
#import "XianZhiQiuGouModel.h"
#import "XianZhiGongYingModel.h"



@interface PublicSearchModel : JSONModel
@property(nonatomic,strong)TradeNoticeModel *jingJiaGongGaoM;
@property(nonatomic,strong)XianZhiQiuGouModel *wantToBuyM;
@property(nonatomic,strong)XianZhiGongYingModel *idleProductM;
@property(nonatomic,strong)JiaoYiYuGaoModel *transactionPreviewM;

@end
