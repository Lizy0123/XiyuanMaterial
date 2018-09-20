//
//  XianZhiGongYingTCell.h
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/10/12.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XianZhiGongYingModel.h"
#import "MyProductModel.h"

@interface XianZhiGongYingTCell : UITableViewCell


@property(strong, nonatomic)XianZhiGongYingModel *idleModel;
@property(strong, nonatomic)MyProductModel *productModel;

+(CGFloat)cellHeight;

@end
