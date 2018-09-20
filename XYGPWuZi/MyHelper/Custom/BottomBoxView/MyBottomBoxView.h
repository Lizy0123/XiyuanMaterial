//
//  MyBottomBoxView.h
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/6/12.
//  Copyright © 2017年 Lzy. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^BottomBoxClickBlock)(UIView *);
@interface MyBottomBoxView : UIView
@property(strong, nonatomic)UIScrollView *scrollView;
/// 初始化数据
- (void)initWithTitle:(NSString *)titleStr titleArray:(NSArray *)modelArray detailArray:(NSArray *)detailArray imageArray:(NSArray *)imageArray;
- (void)initWithTitle:(NSString *)titleStr;

@property(assign, nonatomic)BOOL showInfoBtn;
/// 显示弹框
- (void)showBottomBoxView;
/// 销毁弹框
- (void)closeBottomBoxView;
/// 点击block
@property (copy,nonatomic) BottomBoxClickBlock clickBlock;
@end



@interface BoxItemView : UIView
/// imageView
@property (nonatomic,strong) UIImageView *imageView;
/// label
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *detailLabel;

@end

