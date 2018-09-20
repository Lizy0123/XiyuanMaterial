//
//  GongPingGongGaoTCell.h
//  XYGPWuZi
//
//  Created by apple on 2018/9/13.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GongPingGongGaoTCell : UITableViewCell
@property(strong,nonatomic) UILabel *titleLabel, *descLabel, *timeLabel;
+(CGFloat)cellHeight;
@end
