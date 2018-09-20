//
//  TitleValueView.h
//  XYGPWuZi
//
//  Created by Lzy on 2018/1/23.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleValueView : UIView
@property(copy, nonatomic)NSString *titleStr;
@property(copy, nonatomic)NSString *valueStr;
@property(strong, nonatomic)UILabel *label;

-(void)setTitleStr:(NSString *)titleStr valueStr:(NSString*)valueStr valueColor:(UIColor *)color;

@end
