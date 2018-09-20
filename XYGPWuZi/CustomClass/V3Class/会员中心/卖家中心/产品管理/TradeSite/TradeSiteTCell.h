//
//  TradeSiteTCell.h
//  XYGPWuZi
//
//  Created by Lzy on 2017/12/22.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyProductModel.h"

@class TradeSiteTCell;
@protocol TradeSiteTCellDelegate<NSObject>
-(void)delProductWithCell:(TradeSiteTCell *)cell;
@end

@interface TradeSiteTCell : UITableViewCell
@property(strong, nonatomic)MyProductModel *model;
@property(weak, nonatomic)id<TradeSiteTCellDelegate>delegate;
@end
