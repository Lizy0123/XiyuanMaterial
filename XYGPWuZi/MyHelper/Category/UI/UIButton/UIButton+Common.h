//
//  UIButton+Common.h
//  LzyHelper
//
//  Created by Lzy on 2017/11/10.
//  Copyright © 2017年 Lzy. All rights reserved.
//
#define  kBackButtonFontSize 16

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, kBtnEdgeInsetsStyle) {
    kbtnEdgeInsetsStyleTop, // image在上，label在下
    kBtnEdgeInsetsStyleLeft, // image在左，label在右
    kBtnEdgeInsetsStyleBottom, // image在下，label在上
    kBtnEdgeInsetsStyleRight // image在右，label在左
};
@interface UIButton (Common)

/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(kBtnEdgeInsetsStyle)style imageTitleSpace:(CGFloat)space;

+(UIButton *)buttonWithMyStyleTitle:(NSString *)title;
+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)color;
+ (UIButton *)buttonWithUserStyle;
- (void)userNameStyle;
- (void)frameToFitTitle;
- (void)setUserTitle:(NSString *)aUserName;
- (void)setUserTitle:(NSString *)aUserName font:(UIFont *)font maxWidth:(CGFloat)maxWidth;


//- (void)animateToImage:(NSString *)imageName;
//开始请求时，UIActivityIndicatorView 提示
- (void)startQueryAnimate;
- (void)stopQueryAnimate;


typedef enum {
    StrapBootstrapStyle = 0,
    StrapDefaultStyle,
    StrapPrimaryStyle,
    StrapSuccessStyle,
    StrapInfoStyle,
    StrapWarningStyle,
    StrapDangerStyle
} StrapButtonStyle;

+ (UIButton *)buttonWithStyle:(StrapButtonStyle)style andTitle:(NSString *)title andFrame:(CGRect)rect target:(id)target action:(SEL)selector;
- (UIImage *) buttonImageFromColor:(UIColor *)color ;
-(void)bootstrapStyle;
-(void)defaultStyle;
-(void)primaryStyle;
-(void)successStyle;
-(void)infoStyle;
-(void)warningStyle;
-(void)dangerStyle;







+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)name target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end
