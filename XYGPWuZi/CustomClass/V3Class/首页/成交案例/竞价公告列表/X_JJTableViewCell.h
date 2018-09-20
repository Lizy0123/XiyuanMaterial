//
//  X_JJTableViewCell.h
//  XYGPWuZi
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 xiaoRan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class X_JingJiaGongGaoModel;

@interface X_JJTableViewCell : UITableViewCell
@property (nonatomic, strong)X_JingJiaGongGaoModel *model;
+(CGFloat)cellHeight;
@end
