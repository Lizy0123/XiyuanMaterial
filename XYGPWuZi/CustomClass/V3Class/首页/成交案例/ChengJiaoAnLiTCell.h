//
//  ChengJiaoAnLiTCell.h
//  XYGPWuZi
//
//  Created by Lzy on 2018/1/2.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChengJiaoAnLiModel.h"

@interface ChengJiaoAnLiTCell : UITableViewCell

@property(nonatomic,strong)ChengJiaoAnLiModel *model;

+(CGFloat)cellHeight;
@end
