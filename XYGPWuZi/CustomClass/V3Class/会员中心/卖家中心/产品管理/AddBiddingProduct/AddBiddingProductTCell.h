//
//  AddBiddingProductTCell.h
//  XYGPWuZi
//
//  Created by Lzy on 2018/1/5.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//
#define kCellIdentifier_AddBiddingProductTCell @"AddBiddingProductTCell"

#import <UIKit/UIKit.h>
#import "MyProductModel.h"

@interface AddBiddingProductTCell : UITableViewCell
@property(strong, nonatomic)MyProductModel *productM;

+(CGFloat)cellHeight;
@end
