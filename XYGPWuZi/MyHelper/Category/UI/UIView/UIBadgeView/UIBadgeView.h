//
//  UIBadgeView.h
//  XYGPWuZi
//
//  Created by Lzy on 2018/1/5.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBadgeView : UIView
@property (nonatomic, copy) NSString *badgeValue;

+ (UIBadgeView *)viewWithBadgeTip:(NSString *)badgeValue;
+ (CGSize)badgeSizeWithStr:(NSString *)badgeValue font:(UIFont *)font;

- (CGSize)badgeSizeWithStr:(NSString *)badgeValue;
@end
