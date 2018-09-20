//
//  BiddingModel.h
//  XYGPWuZi
//
//  Created by Lzy on 2018/1/22.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface BiddingModel : JSONModel
@property (nonatomic,copy)NSString <Optional>
*userName,
*tnTitle,
*endTime,
*tsMinPrice,
*maxPrice,
*tsAddPrice,
*buyTime,
*tsName,
*companyName,
*tsTradeNo,
*type,
*tsEndTime,
*bidTime,
*tsId,
*saleUsername,
*beginTime
;

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
/*//列表页的数据模型
 object =     (
 {
 tsEndTime = "2018-02-22 16:24:43",
 tnId = "40288086611ce2f401611cf8d94a0017",
 diNeedPay = "4",
 diIsCheck = "1",
 tsId = "40288086611ce2f401611cf819360012",
 diIsUploadProof = "0",
 bidTime = 2533402738,
 tsProcess = "2",
 tsSiteType = "0",
 tsName = "通通通",
 tsTradeNo = "P2018012216248871887",
 beginTime = "2018-01-22 16:30:36",
 bidNo = "10000337",
 },
 ),
 */
/*//请求出价页的数据模型
 object =     {
 tsAddPrice = "3",
 tsMinPrice = "33",
 charges =     (
 ),
 tsEndTime = "2018-02-22 16:24:43",
 tsId = "40288086611ce2f401611cf819360012",
 tnTitle = "嘎嘎嘎",
 userName = "谢宏伟",
 type = "0",
 buyTime = "2018-01-24 08:33:29",
 endTime = 2533391410,
 tsName = "通通通",
 tsTradeNo = "P2018012216248871887",
 tradeProductInfos =     (
 ),
 companyName = "河北熙元科技有限公司",
 maxPrice = "48",
 },

 */

/*NSString *userName = responseObject[@"object"][@"userName"];
 NSString *title = responseObject[@"object"][@"tnTitle"];
 NSInteger endTime = [responseObject[@"object"][@"endTime"]integerValue];
 NSString *minPrice = responseObject[@"object"][@"tsMinPrice"];
 NSString *maxPrice = responseObject[@"object"][@"maxPrice"];
 NSString *addPrice = responseObject[@"object"][@"tsAddPrice"];
 NSString *buyTime = responseObject[@"object"][@"buyTime"];
 NSString *tsName = responseObject[@"object"][@"tsName"];
 NSString *companyName = responseObject[@"object"][@"companyName"];
 NSString *bianHao = responseObject[@"object"][@"tsTradeNo"];
 NSString *qyType = responseObject[@"object"][@"type"];
 NSString *overTime = responseObject[@"object"][@"tsEndTime"];
*/
@end
