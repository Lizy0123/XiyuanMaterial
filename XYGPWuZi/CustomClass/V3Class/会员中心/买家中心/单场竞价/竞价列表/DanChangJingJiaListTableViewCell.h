//
//  DanChangJingJiaListTableViewCell.h
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/1/4.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DanChangJingJiaListModel;
@class DanChangJingJiaListTableViewCell;

@protocol MyJingJiaListTableViewCellBtnClickedDelegate <NSObject>

/**
 按钮点击协议方法
 @param btn 当前按钮
 @param cell 当前cell
 */
-(void)clickBtn:(UIButton *)btn onCell:(DanChangJingJiaListTableViewCell *)cell;
@end

@interface DanChangJingJiaListTableViewCell : UITableViewCell
@property(copy, nonatomic)NSString *serverTime;
//竞价model
@property(nonatomic,strong)DanChangJingJiaListModel *model;
//竞价状态
@property(nonatomic,assign)kMyJingJingListStatus myJingJiaListStatus;
//代理
@property(nonatomic,assign)id<MyJingJiaListTableViewCellBtnClickedDelegate>delegate;
//根据状态返回不同的行高
+(CGFloat)cellHightWithListStatus:(kMyJingJingListStatus)kMyJingJingListStatus;

@end
