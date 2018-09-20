//
//  X_JJDetailTwoCellModel.h
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/6/14.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface X_JJDetailTwoCellModel : NSObject


//拼盘&场次编号
@property(nonatomic,copy)NSString *tsTradeNo;
//卖家会员
@property(nonatomic,copy)NSString *tnOwnerName;
//场次名称
@property(nonatomic,copy)NSString *tsName;
//竞价日期
@property(nonatomic,copy)NSString *tsTradeDate;
//参与方式
@property(nonatomic,copy)NSString *tsJoinType;
//竞价开始时间
@property(nonatomic,copy)NSString *tsStartTime;
//竞价结束时间
@property(nonatomic,copy)NSString *tsEndTime;



/*
 self.bhLabel.text = @"场次编号  P2016062210594536453";
 self.mjhyLabel.text = @"卖家会员    保密";
 self.cjmcLabel.text = @"    废旧弹簧专场";
 self.jjDateLabel.text = @"竞价日期    2017-07-15";
 self.cyfsLabel.text = @"参与方式    定向竞价";
 self.jjTimeLabel.text = @"竞价时间    13:00-15:00";
 */
@end
