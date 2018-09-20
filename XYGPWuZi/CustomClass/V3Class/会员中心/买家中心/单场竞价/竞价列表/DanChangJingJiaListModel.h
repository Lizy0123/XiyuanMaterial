//
//  DanChangJingJiaListModel.h
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/1/4.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface DanChangJingJiaListModel : JSONModel
@property (nonatomic,copy)NSString <Optional>
*tsEndTime,
*diPayProof,
*diNeedPay,
*diIsCheck,
*tsId,
*diIsUploadProof,
*tsProcess,
*tsIsSuccess,
*tsName,
*tsTradeNo,
*tsSiteType,
*beginTime,
*bidNo,
*tnId,
*endTime,
*bidTime,
*cpId;

//tsId：场次id tnId：公告ID diNeedPay：保证金 tsName：场次的名称 endTime:当前时间距离竞价开始时间的时间戳 bidTime：当前时间距离竞价结束时间的时间戳 beginTime：竞买开始时间 tsEndTime:竞买结束时间 diIsCheck：保证金的审核状态（0未审核1审核通过2审核未通过）diIsUploadProof：是否上传了付款凭证（0：未上传 1：已上传）diPayProof：付款凭证的图片路径 tsTradeNo：场次编号 tsProcess：流程的编号 tsSiteType：场次类型（0单品1拼盘） bidNo：竞拍编号 tsIsSuccess：最终交易状态（0、失败 1、成功 2、流拍）

@end
