//
//  JiaoYiYuGaoTCell.h
//  XYGPWuZi
//
//  Created by Lzy on 2017/12/28.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Api_JiaoYiYuGao.h"

#import <UIKit/UIKit.h>

@interface CustomLabel : UILabel
@property (nonatomic, assign) UIEdgeInsets textInsets; // 控制字体与控件边界的间隙
@end



@interface JiaoYiYuGaoTCell : UITableViewCell

@property(strong, nonatomic)JiaoYiYuGaoModel *transactionM;

+(CGFloat)cellHeight;

@end
