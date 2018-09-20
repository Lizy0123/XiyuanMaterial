//
//  UIBarButtonItem+Common.h
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/6/6.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Common)
+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
@end
