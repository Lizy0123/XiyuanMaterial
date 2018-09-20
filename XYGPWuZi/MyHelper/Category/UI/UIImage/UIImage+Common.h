//
//  UIImage+Common.h
//  XYGPWuZi
//
//  Created by Lzy on 2017/12/16.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Common)
+ (UIImage*) imageWithName:(NSString *) imageName;
+ (UIImage*) resizableImageWithName:(NSString *)imageName;
- (UIImage*) scaleImageWithSize:(CGSize)size;


+(UIImage *)imageWithColor:(UIColor *)aColor;
+(UIImage *)imageWithColor:(UIColor *)aColor withFrame:(CGRect)aFrame;
@end
