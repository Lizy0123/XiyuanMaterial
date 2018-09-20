//
//  TitleTextTCell.h
//  XYGPWuZi
//
//  Created by Lzy on 2018/1/13.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//
#define kCellIdentifier_TitleTextTCell @"TitleTextTCell"

#import <UIKit/UIKit.h>

@interface TitleTextTCell : UITableViewCell
- (void)setTitleStr:(NSString *)titleStr valueStr:(NSString *)contentStr;
+(CGFloat)cellHeightWithObj:(id)obj;
@end
