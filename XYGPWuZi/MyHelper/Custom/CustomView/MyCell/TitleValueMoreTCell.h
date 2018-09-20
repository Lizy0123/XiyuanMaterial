//
//  TitleValueMoreTCell.h
//  XYGPWuZi
//
//  Created by Lzy on 2018/1/5.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//
#define kCellIdentifier_TitleValueMoreTCell @"TitleValueMoreTCell"

#import <UIKit/UIKit.h>

@interface TitleValueMoreTCell : UITableViewCell
- (void)setTitleStr:(NSString *)title valueStr:(NSString *)value;
+ (CGFloat)cellHeight;
@end
