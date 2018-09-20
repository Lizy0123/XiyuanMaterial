//
//  NSObject+Common.m
//  XYGPWuZi
//
//  Created by Lzy on 2017/12/14.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "NSObject+Common.h"
#import "AppDelegate.h"
#import "ProductCategoryModel.h"
#import "UIView+Toast.h"
#import "MBProgressHUD+Add.h"

@implementation NSObject (Common)
#pragma mark - 判断
+(BOOL)isDictionary:(id)dic{
    if (!dic) {
        return NO;
    }
    if ((NSNull *)dic == [NSNull null]) {
        return NO;
    }
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return NO;
    }
    if ([dic count] <= 0) {
        return NO;
    }
    return YES;
}
+ (BOOL)isArray:(id)array{
    if (!array) {
        return NO;
    }
    if ((NSNull *)array == [NSNull null]) {
        return NO;
    }
    if (![array isKindOfClass:[NSArray class]]) {
        return NO;
    }
    if ([array count] <= 0) {
        return NO;
    }
    if (array == nil) {
        NO;
    }
    return YES;
}

+(BOOL)isString:(id)str{
    if (!str) {
        return NO;
    }
    if ((NSNull *)str == [NSNull null]) {
        return NO;
    }
    if (![str isKindOfClass:[NSString class]]) {
        return NO;
    }
    if ([str isEqualToString:@""]) {
        return NO;
    }
    if (((NSString *)str).length == 0) {
        return NO;
    }
    if ([str isEqualToString:@"(null)"]) {
        return NO;
    }
    if ([str isEqualToString:@"<null>"]) {
        return NO;
    }
    if ([str isKindOfClass:[NSNull class]]) {
        return NO;
    }
    return YES;
}
#pragma 手机号判断
//+(BOOL)isMobileNum:(NSString *)mobNum{
//    //    电信号段:133/149/153/173/177/180/181/189
//    //    联通号段:130/131/132/145/155/156/171/175/176/185/186
//    //    移动号段:134/135/136/137/138/139/147/150/151/152/157/158/159/178/182/183/184/187/188
//    //    虚拟运营商:170
//
//    NSString *MOBILE = @"^1(3[0-9]|4[579]|5[0-35-9]|7[0135-8]|8[0-9])\\d{8}$";
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    return [regextestmobile evaluateWithObject:mobNum];
//}
//判断手机号码格式是否正确
+(BOOL)isMobileNum:(NSString *)mobNum{
    mobNum = [mobNum stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobNum.length != 11){
        return NO;
    }else{
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8])|(198))\\d{8}|(1705)\\d{7}$";/*** 移动号段正则表达式*/
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6])|(166))\\d{8}|(1709)\\d{7}$";/*** 联通号段正则表达式*/
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9])|(199))\\d{8}$";/*** 电信号段正则表达式*/
        
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobNum];
        
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobNum];
        
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobNum];
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}
+ (BOOL)validateCellPhoneNumber:(NSString *)cellNum{
    /** * 手机号码 * 移动:134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188 * 联通:130,131,132,152,155,156,185,186 * 电信:133,1349,153,177,180,189  *大陆地区固话及小灵通:区号:010,020,021,022,023,024,025,027,028,029号码:七位或八位*/
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])//d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])//d)//d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])//d{8}$";
    NSString * CT = @"^1((33|53|77|8[09])[0-9]|349)//d{7}$";
    NSString * PHS = @"^0(10|2[0-5789]|//d{3})//d{7,8}$";/**验证固话的谓词.*/
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    BOOL isMatch1 = [regextestmobile evaluateWithObject:cellNum];

    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    BOOL isMatch2 = [regextestcm evaluateWithObject:cellNum];

    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    BOOL isMatch4 = [regextestcu evaluateWithObject:cellNum];

    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT]; //
    BOOL isMatch3 = [regextestct evaluateWithObject:cellNum];

    NSPredicate *regextestPHS = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    BOOL isMatch5 = [regextestPHS evaluateWithObject:cellNum];

    if(isMatch1|| isMatch2 || isMatch3 || isMatch4){
        return YES;
    }else{
        return NO;
    }
}






#pragma mark - 样式
+(NSString *)moneyStyle:(NSString *)money{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *numTemp = [numberFormatter numberFromString:money];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle =NSNumberFormatterCurrencyStyle;
    formatter.locale= [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    return [formatter stringFromNumber:numTemp];
}
+(UIView *)lineViewWithFrame:(CGRect)rect color:(UIColor *)color{
    UIView *view = [[UIView alloc] initWithFrame:rect];
    if (!color) {
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }else{
        view.backgroundColor = color;
    }
    return view;
}
#pragma mark 获取当前的时间
+ (NSString *)currentDateString {
    return [self currentDateStringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

#pragma mark 按指定格式获取当前的时间
+ (NSString *)currentDateStringWithFormat:(NSString *)formatterStr {
    // 获取系统当前时间
    NSDate *currentDate = [NSDate date];
    // 用于格式化NSDate对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置格式：yyyy-MM-dd HH:mm:ss
    formatter.dateFormat = formatterStr;
    // 将 NSDate 按 formatter格式 转成 NSString
    NSString *currentDateStr = [formatter stringFromDate:currentDate];
    // 输出currentDateStr
    return currentDateStr;
}
+(NSString *)formateTimeString:(NSString *)timeStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //    [formatter setDateStyle:NSDateFormatterFullStyle];// 修改下面提到的北京时间的日期格式
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];//
    
    NSDate *date = [formatter dateFromString:timeStr];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];// 此行代码与上面两行作用一样，故上面两行代码失效
    NSString *currentDateString = [formatter stringFromDate:date];
    return currentDateString;
}
+(NSString *)revertTimeString:(NSString *)timeStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //    [formatter setDateStyle:NSDateFormatterFullStyle];// 修改下面提到的北京时间的日期格式
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//
    
    NSDate *date = [formatter dateFromString:timeStr];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];// 此行代码与上面两行作用一样，故上面两行代码失效
    NSString *currentDateString = [formatter stringFromDate:date];
    return currentDateString;
}

+(int)compareDateStr:(NSString*)date01 withDateStr:(NSString*)date02{
    int ci;
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date1 = [[NSDate alloc] init];
    NSDate *date2 = [[NSDate alloc] init];
    date1 = [dateFormater dateFromString:date01];
    date2 = [dateFormater dateFromString:date02];
    NSComparisonResult result = [date1 compare:date2];
    switch (result)
    {
            //date02比date01大
        case NSOrderedAscending: ci=1; break;
            //date02比date01小
        case NSOrderedDescending: ci=-1; break;
            //date02=date01
        case NSOrderedSame: ci=0; break;
        default: NSLog(@"erorr dates %@, %@", date2, date1); break;
    }
    return ci;
}

+(NSMutableAttributedString *)attributedStr:(NSString *)str color:(UIColor *)color length:(NSInteger)strLength{
    NSMutableAttributedString *countString = [[NSMutableAttributedString alloc] initWithString:str];
    [countString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(strLength,str.length-strLength)];
    return countString;
}

#pragma mark - 工具
+(void)archiverWithSomeThing:(id)someThing someName:(NSString *)name{
    // 创建归档时所需的data 对象.
    NSMutableData *data = [NSMutableData data];
    // 归档类.
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    // 开始归档（@"model" 是key值，也就是通过这个标识来找到写入的对象）.
    [archiver encodeObject:someThing forKey:name];
    // 归档结束.
    [archiver finishEncoding];
    // 写入本地（@"weather" 是写入的文件名）.
    NSString *file = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:name];
    [data writeToFile:file atomically:YES];
}
+(id)unarchiverWithName:(NSString *)name{
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:[NSData dataWithContentsOfFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:name]]];
    id someThing = [unarchiver decodeObjectForKey:name];
    [unarchiver finishDecoding];
    return someThing;
}
+(void)serveCategory{
    [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_GetFirstListId] parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"LzyresponseObject---%@",responseObject);
        if ([responseObject[@"code"] intValue] == 200) {
            NSArray *arr = [ProductCategoryModel arrayOfModelsFromDictionaries:responseObject[@"object"] error:nil];
            [Helper archiverWithSomeThing:arr someName:kProductCategoryCache];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}






#pragma mark - 提示
#pragma mark Toast
+(void)ToastActivityShow{
    [kKeyWindow makeToastActivity:CSToastPositionCenter];
}
+(void)ToastActivityHide{
    [kKeyWindow hideToastActivity];
}
+(void)ToastShowStr:(NSString *)str{
    if (str.length>40) {
        [Helper ToastShowStr:str during:2.0f];
    }else{
        [Helper ToastShowCustomeStr:str during:2.0f];
    }
}
+(void)ToastShowStr:(NSString *)str during:(CGFloat)during{
    [kKeyWindow makeToast:str
                 duration:during
                 position:CSToastPositionCenter
                    title:nil
                    image:nil
                    style:nil
               completion:nil];
}
+(void)ToastShowCustomeStr:(NSString *)str during:(CGFloat)during{
    // Show a custom view as toast
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 180, 120)];
    customView.cornerRadius = 10;
    customView.layer.masksToBounds = YES;
    customView.opaque = YES;
    customView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.7];
    
    [customView setAutoresizingMask:(UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin)]; // autoresizing masks are respected on custom views
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(customView.frame) + 20, CGRectGetMinY(customView.frame) + 20, CGRectGetWidth(customView.frame) - 20*2, CGRectGetHeight(customView.frame) - 20*2)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    label.numberOfLines = 0;
    label.text = str;
    [customView addSubview:label];
    
    [kKeyWindow showToast:customView
                 duration:during
                 position:CSToastPositionCenter
               completion:nil];
}
+(void)ToastHide{
    [kKeyWindow hideToast];
}
+(void)ToastHideAll{
    [kKeyWindow hideAllToasts];
}




#pragma mark MBProgressHUD
+ (void)HUDShowStr:(NSString *)tipStr{
    if (tipStr && tipStr.length > 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabelFont = [UIFont boldSystemFontOfSize:15.0];
        hud.detailsLabelText = tipStr;
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1.5];
    }
}
+ (id)HUDActivityShowStr:(NSString *)titleStr{
    titleStr = titleStr.length > 0? titleStr: @"正在加载...";
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
    hud.tag = kHUDQueryViewTag;
    hud.labelText = titleStr;
    hud.labelFont = [UIFont boldSystemFontOfSize:15.0];
    hud.margin = 10.f;
    return hud;
}
+ (NSUInteger)HUDActivityHide{
    __block NSUInteger count = 0;
    NSArray *huds = [MBProgressHUD allHUDsForView:kKeyWindow];
    [huds enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if (obj.tag == kHUDQueryViewTag) {
            [obj removeFromSuperview];
            count++;
        }
    }];
    return count;
}




@end
