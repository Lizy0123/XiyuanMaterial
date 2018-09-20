//
//  X_JingJiaDetailViewController.h
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/6/12.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface X_JingJiaDetailViewController : UIViewController


@property(nonatomic,copy)NSString *tnId;

@property(nonatomic,assign)BOOL isShowBottomView;

@end
/*
 code：200 成功 |
 tnId：公告主键ID |
 facUserid：用户主键ID | 
 tnTitle：公告名称 | 
 tnTradeDate：竞价时间 |
 tnDeposit：保证金 | 
 tnOwnerName：卖家会员 |
 tnPpNum：拼盘个数 | 
 tnWeigth：重量 | 
 tnNum：数量 |
 tnUnits：单位 | 
 tnType：竞价模式（0、公开增价 1、 加权竞价 2、自由出价 ）|
 tnUserType：会员属性（0、只限企业 1、只限个人 2、都可以）| 
 tnYyjz：延迟机制 |
 thBlPrice：保留价 |
 tnContent：公告内容 |
 tnIstj：是否推荐（0、否 1、是）|
 tnCreTime：发布时间 |
 tnCreUser：发布人 |
 tsId：场次主键ID | 
 tsName：场次名称 |
 tsNoticeDate：公告日 | 
 tsTradeDate：竞价日 |
 tsStartTime：竞价开始时间 | 
 tsEndTime：竞价结束时间 |
 tsJoinType：参与方式（0、不定向竞价 1、定向竞价） |
 tsCreMan：创建人 | 
 tsCreTime：创建时间 |
 tsSiteType 场次类型(0、单品 1、拼盘) |
 tsIsSuccess 最终交易状态（0、失败 1、成功 2、流拍）|
 tsMinPrice：起始价 | 
 tsAddPrice：加价幅度 |
 tsEndPrice：成交价格 | 
 tsProtectPrice：最低出售低价 |
 tsWeigth：交易重量 |
 tsNum：交易数量 |
 tsUnits：数量单位 | 
 tsWeightUnit：重量单位 |
 tsCountPrice：总价格 |
 tsHouse：交易仓库 |
 tsIsCheck：是否发布了公告（0、否 1、是）|
 tsIsEnd：是否结束（0、否 1、是） | 
 tsDeal：协议内容 |
 tsType：场次交易类型（0、公开增价 1、 加权竞价 2、自由出价 ）| 
 tsJjfs：计价方式（0、重量计价1、数量计价）|
 tsTradeType：报盘方式（0、单价报盘1、总价报盘） |
 tsTradeNo：场次编号 |
 tnCode：公告编码 |
 isEnd：是否结束（0、否 1、是）| 
 toBegin：即将开始倒计时 |
 onGoing：正在进行倒计时 | 
 piName：品名 |
 piWarehouse：仓库| 
 piXjcd：新旧程度 |
 piCpxh：产品型号 |
 piCpcd：产品产地 |
 piCode：产品编号 | 
 pNum：产品数量 |
 pWeight：产品重量 | 
 piKbh：捆包号 |
 piCcgg：产品规格 |
 piZyh：资源号
 
 */
