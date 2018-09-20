//
//  UIButton+Common.m
//  LzyHelper
//
//  Created by Lzy on 2017/11/10.
//  Copyright © 2017年 Lzy. All rights reserved.
//

#import "UIButton+Common.h"
//#import <POP+MCAnimate/POP+MCAnimate.h>
#import <math.h>
#include <objc/runtime.h>

@implementation UIButton (Common)
- (void)layoutButtonWithEdgeInsetsStyle:(kBtnEdgeInsetsStyle)style imageTitleSpace:(CGFloat)space{
    //    self.backgroundColor = [UIColor cyanColor];

    /**
     *  前置知识点：titleEdgeInsets是title相对于其上下左右的inset，跟tableView的contentInset是类似的，
     *  如果只有title，那它上下左右都是相对于button的，image也是一样；
     *  如果同时有image和label，那这时候image的上左下是相对于button，右边是相对于label的；title的上右下是相对于button，左边是相对于image的。
     */
    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;

    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }

    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;

    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    switch (style) {
        case kbtnEdgeInsetsStyleTop:{
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
        }
            break;
        case kBtnEdgeInsetsStyleLeft:{
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }
            break;
        case kBtnEdgeInsetsStyleBottom:{
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
        }
            break;
        case kBtnEdgeInsetsStyleRight:{
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
        }
            break;
        default:
            break;
    }

    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}
+(UIButton *)buttonWithMyStyleTitle:(NSString *)title{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.backgroundColor = [UIColor whiteColor];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 5;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1] CGColor];
    [btn setTitleColor:[UIColor lightTextColor] forState:UIControlStateHighlighted];
    [btn.titleLabel setMinimumScaleFactor:0.5];
    
    CGFloat titleWidth = [title getWidthWithFont:btn.titleLabel.font constrainedToSize:CGSizeMake(kScreen_Width, 30)] +20;
    btn.frame = CGRectMake(0, 0, titleWidth, 30);
    
    [btn setTitle:title forState:UIControlStateNormal];
    return btn;
}


+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)color{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];

    btn.backgroundColor = [UIColor clearColor];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightTextColor] forState:UIControlStateHighlighted];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:kBackButtonFontSize]];
    [btn.titleLabel setMinimumScaleFactor:0.5];

    CGFloat titleWidth = [title getWidthWithFont:btn.titleLabel.font constrainedToSize:CGSizeMake(kScreen_Width, 30)] +20;
    btn.frame = CGRectMake(0, 0, titleWidth, 30);

    [btn setTitle:title forState:UIControlStateNormal];
    return btn;
}
+ (UIButton *)buttonWithUserStyle{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn userNameStyle];
    return btn;
}
- (void)userNameStyle{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 2.0;
    self.titleLabel.font = [UIFont systemFontOfSize:17];
    //    [self setTitleColor:kColor222 forState:UIControlStateNormal];
    [self setTitleColor:kColorHex(0x323A45) forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateHighlighted];
}
- (void)frameToFitTitle{
    CGRect frame = self.frame;
    CGFloat titleWidth = [self.titleLabel.text getWidthWithFont:self.titleLabel.font constrainedToSize:CGSizeMake(kScreen_Width, frame.size.height)];
    frame.size.width = titleWidth;
    [self setFrame:frame];
}
- (void)setUserTitle:(NSString *)aUserName{
    [self setTitle:aUserName forState:UIControlStateNormal];
    [self frameToFitTitle];
}
- (void)setUserTitle:(NSString *)aUserName font:(UIFont *)font maxWidth:(CGFloat)maxWidth{
    [self setTitle:aUserName forState:UIControlStateNormal];
    CGRect frame = self.frame;
    CGFloat titleWidth = [self.titleLabel.text getWidthWithFont:font constrainedToSize:CGSizeMake(CGFLOAT_MAX, frame.size.height)];
    if (titleWidth > maxWidth) {
        titleWidth = maxWidth;
        //        self.titleLabel.minimumScaleFactor = 0.5;
        //        self.titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    [self setWidth:titleWidth];
    [self.titleLabel setWidth:titleWidth];
}


//- (void)animateToImage:(NSString *)imageName{
//    UIImage *image = [UIImage imageNamed:imageName];
//    if (!image) {
//        return;
//    }
//    [self setImage:image forState:UIControlStateNormal];
//    if ([self superview]) {
//        UIView *superV = [self superview];
//        UIImageView *imageV = [[UIImageView alloc] initWithImage:image];
//        CGRect vFrame = [self convertRect:self.imageView.frame toView:superV];
//        imageV.frame = vFrame;
//        [superV addSubview:imageV];
//
//        //animate
//        CGAffineTransform fromTransform = imageV.transform;
//        CGPoint fromCenter = imageV.center;
//        CGFloat dx = CGRectGetWidth(self.frame) /2;
//        CGFloat dy = CGRectGetHeight(self.frame) *3;
//        CGFloat dScale = 3.0;
//        CGFloat dRotation = M_PI_4;
//
//        NSTimeInterval moveDurarion = 1.0;
//        POPCustomAnimation *moveA = [POPCustomAnimation animationWithBlock:^BOOL(id target, POPCustomAnimation *animation) {
//            float time_percent = (animation.currentTime - animation.beginTime)/moveDurarion;
//            UIView *view = (UIView *)target;
//            CGPoint toCenter = CGPointMake(fromCenter.x + time_percent * dx, fromCenter.y - (dy * time_percent * (2 - time_percent)));//抛物线移动
//            view.center = toCenter;
//
//            CGAffineTransform toTransform = fromTransform;
//            toTransform = CGAffineTransformTranslate(toTransform, 50, -50);
//
//            CGFloat toScale = 1 + time_percent *(dScale - 1);//线性放大
//            toTransform = CGAffineTransformMakeScale(toScale, toScale);
//            CGFloat toRotation = dRotation * (1- cosf(time_percent * M_PI_2));//cos曲线旋转（先慢后快）
//            toTransform = CGAffineTransformRotate(toTransform, toRotation);
//            view.transform = toTransform;
//
//            view.alpha = 1 - time_percent;
//            return time_percent < 1.0;
//        }];
//        [imageV pop_addAnimation:moveA forKey:@"animateToImage"];
//    }
//}
#pragma mark -
//开始请求时，UIActivityIndicatorView 提示
static char EAActivityIndicatorKey;
- (void)setActivityIndicator:(UIActivityIndicatorView *)activityIndicator{
    objc_setAssociatedObject(self, &EAActivityIndicatorKey, activityIndicator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}
- (UIActivityIndicatorView *)activityIndicator{
    return objc_getAssociatedObject(self, &EAActivityIndicatorKey);
}

- (void)startQueryAnimate{
    if (!self.activityIndicator) {
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.activityIndicator.hidesWhenStopped = YES;
        [self addSubview:self.activityIndicator];
        [self.activityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
    }
    [self.activityIndicator startAnimating];
    self.enabled = NO;
}
- (void)stopQueryAnimate{
    [self.activityIndicator stopAnimating];
    self.enabled = YES;
}












- (UIImage *) buttonImageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
-(void)bootstrapStyle{
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = CGRectGetHeight(self.bounds)/2;
    self.layer.masksToBounds = YES;
    [self setAdjustsImageWhenHighlighted:NO];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:self.titleLabel.font.pointSize]];
}

-(void)defaultStyle{
    [self bootstrapStyle];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    self.backgroundColor = kColorNav;
    self.layer.borderColor = [[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1]] forState:UIControlStateHighlighted];
    [self setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateDisabled];

}

-(void)primaryStyle{
    [self bootstrapStyle];
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [[UIColor grayColor] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:kColorHex(0x28a464)] forState:UIControlStateHighlighted];
}

-(void)successStyle{
    [self bootstrapStyle];
    self.layer.borderColor = [[UIColor clearColor] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor grayColor]] forState:UIControlStateNormal];
    [self setBackgroundImage:[self buttonImageFromColor:kColorHex(0x3bbc79)] forState:UIControlStateDisabled];
    [self setBackgroundImage:[self buttonImageFromColor:kColorHex(0x32a067)] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.5] forState:UIControlStateDisabled];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];

}

-(void)infoStyle{
    [self bootstrapStyle];
    self.layer.borderColor = [[UIColor clearColor] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:kColorHex(0x4E90BF)] forState:UIControlStateNormal];
    [self setBackgroundImage:[self buttonImageFromColor:kColorHex(0x4E90BF)] forState:UIControlStateDisabled];
    [self setBackgroundImage:[self buttonImageFromColor:kColorHex(0x4E90BF)] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.5] forState:UIControlStateDisabled];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
}

-(void)warningStyle{
    [self bootstrapStyle];
    self.backgroundColor = kColorHex(0xff5847);
    self.layer.borderColor = [kColorHex(0xff5847) CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:kColorHex(0xef4837)] forState:UIControlStateHighlighted];
}

-(void)dangerStyle{
    [self bootstrapStyle];
    self.backgroundColor = [UIColor colorWithRed:217/255.0 green:83/255.0 blue:79/255.0 alpha:1];
    self.layer.borderColor = [[UIColor colorWithRed:212/255.0 green:63/255.0 blue:58/255.0 alpha:1] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:210/255.0 green:48/255.0 blue:51/255.0 alpha:1]] forState:UIControlStateHighlighted];
}
+ (UIButton *)buttonWithStyle:(StrapButtonStyle)style andTitle:(NSString *)title andFrame:(CGRect)rect target:(id)target action:(SEL)selector{
    UIButton *btn = [[UIButton alloc] initWithFrame:rect];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    const  SEL selArray[] = {@selector(bootstrapStyle), @selector(defaultStyle), @selector(primaryStyle), @selector(successStyle), @selector(infoStyle), @selector(warningStyle), @selector(dangerStyle)};
    if ([btn respondsToSelector:selArray[style]]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [btn performSelector:selArray[style]];
#pragma clang diagnostic pop
    }
    return btn;
}


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

+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)name target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    // btn
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setTitle:name forState:UIControlStateNormal];
    [btn sizeToFit];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:controlEvents];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    return  [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 40);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}
@end
