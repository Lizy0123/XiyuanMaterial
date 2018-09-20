//
//  UIBarButtonItem+Common.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/6/6.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "UIBarButtonItem+Common.h"

@implementation UIBarButtonItem (Common)
+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    // btn
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setBackgroundImage:highImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    
    [btn addTarget:target action:action forControlEvents:controlEvents];
    
    return  [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
