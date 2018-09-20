//
//  TradeNoticeTCell.h
//  XYGPWuZi
//
//  Created by Lzy on 2018/1/2.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TradeNoticeModel.h"

@interface TradeNoticeTCell : UITableViewCell
@property (nonatomic, strong)TradeNoticeModel *model;
+(CGFloat)cellHeight;

@end
