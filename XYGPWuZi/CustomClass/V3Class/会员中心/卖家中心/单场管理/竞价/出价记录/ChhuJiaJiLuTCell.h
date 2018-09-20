//
//  ChhuJiaJiLuTCell.h
//  XYGPWuZi
//
//  Created by Lzy on 2018/1/10.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//
#define kCellIdentifier_RecordTCell @"RecordTCell"

#import <UIKit/UIKit.h>
#import "ChuJiaJiLuModel.h"

@interface ChhuJiaJiLuTCell : UITableViewCell
@property(strong, nonatomic)ChuJiaJiLuModel *recordM;
@property(strong, nonatomic)RecordDetailModel *recordDetailM;
@property(strong, nonatomic)RecordJiaoyiModel *recordJiaoyiM;
+(CGFloat)cellHeight;
@end
