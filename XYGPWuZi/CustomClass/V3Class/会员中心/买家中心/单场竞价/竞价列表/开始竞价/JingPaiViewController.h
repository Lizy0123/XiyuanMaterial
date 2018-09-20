//
//  JingPaiViewController.h
//  WebSocketTest
//
//  Created by 河北熙元科技有限公司 on 2017/5/27.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BiddingModel.h"

@class XRTimeModel;

@protocol JingPaiViewControllerBackRefreshDelegate <NSObject>
//pop回来刷新界面
-(void)backRefresh;

@end

@interface JingPaiViewController : UIViewController

@property(nonatomic,assign)id<JingPaiViewControllerBackRefreshDelegate>backDelegate;
//结果请求参数
@property (nonatomic,strong)NSMutableDictionary *dictParma;
@property(strong, nonatomic)BiddingModel *biddingM;
/**
 初始化方法

 @param title 公告名称
 @param tsName 场次名称
 @param minPrice 起始价格
 @param addPrice 加价幅度
 @param bianHao 场次编号
 @param userName 账号名称
 @param companyName 公司名称
 @param type 企业类型
 @param maxPrice 最高出价
 @param buyTime 出价时间
 @param endTime 系统时间距离结束时间的毫秒数
 @return self
 */
-(id)initWithTitle:(NSString *)title tsName:(NSString *)tsName tsMinPrice:(NSString *)minPrice tsAddPrice:(NSString *)addPrice bianHao:(NSString *)bianHao userName:(NSString *)userName companyName:(NSString *)companyName qiYeType:(NSString *)type maxPrice:(NSString *)maxPrice buyTime:(NSString *)buyTime endTime:(NSInteger)endTime overTime:(NSString *)overTime andtsId:(NSString *)tsId;


/*
 公告名称    "tnTitle": "振动筛和锁紧缸拍卖公告",
 场次名称    "tsName": "振动筛和锁紧缸拍卖",
 起始价格    "tsMinPrice": "150000",
 加价幅度    "tsAddPrice": "3000",
 场次编号    "tsTradeNo": "P2017032413427773777",
 账号名称    "userName": "谢宏伟",
 公司名称    "companyName": "滦平建龙矿业有限公司",
 企业类型    "type": "0",           (0 公司,1 个人)
 最高出价    "maxPrice": "159000",  (返回"no"无人出价)
 出价时间    "buyTime": "2017-03-24 13:54:09",
 "endTime": 16323893  系统时间距离结束时间的毫秒数
 */

@end
