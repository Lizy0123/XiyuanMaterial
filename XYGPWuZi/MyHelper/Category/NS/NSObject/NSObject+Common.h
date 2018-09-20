//
//  NSObject+Common.h
//  XYGPWuZi
//
//  Created by Lzy on 2017/12/14.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Common)
#pragma mark - 判断
+(BOOL)isDictionary:(id)dic;/*判断是否是字典*/
+(BOOL)isArray:(id)array;/*判断是否是数组*/
+(BOOL)isString:(id)str;/*判断是否是字符串*/
+(BOOL)isMobileNum:(NSString *)mobNum;/*判断是否是手机号*/

#pragma mark - 样式
+(NSString *)moneyStyle:(NSString *)money;
+(UIView *)lineViewWithFrame:(CGRect)rect color:(UIColor *)color;
+(NSString *)currentDateString;/** 获取当前的时间 */
+(NSString *)formateTimeString:(NSString *)timeStr;
+(NSString *)revertTimeString:(NSString *)timeStr;
+(int)compareDateStr:(NSString*)date01 withDateStr:(NSString*)date02;
+(NSMutableAttributedString *)attributedStr:(NSString *)str color:(UIColor *)color length:(NSInteger)strLength;

#pragma mark - 工具
+(void)archiverWithSomeThing:(id)someThing someName:(NSString *)name;
+(id)unarchiverWithName:(NSString *)name;
+(void)serveCategory;





#pragma mark - 提示
#pragma mark Toast
+(void)ToastActivityShow;
+(void)ToastActivityHide;
+(void)ToastShowStr:(NSString *)str;
+(void)ToastShowStr:(NSString *)str during:(CGFloat)during;
+(void)ToastShowCustomeStr:(NSString *)str during:(CGFloat)during;
+(void)ToastHide;
+(void)ToastHideAll;

#pragma mark MBProgressHUD
+ (void)HUDShowStr:(NSString *)tipStr;
+ (id)HUDActivityShowStr:(NSString *)titleStr;
+ (NSUInteger)HUDActivityHide;



@end
