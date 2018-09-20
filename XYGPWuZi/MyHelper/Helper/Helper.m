//
//  Helper.m
//  XYGPWuZi
//
//  Created by Lzy on 2017/12/23.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "Helper.h"
#import "AppDelegate.h"

#if defined(__IPHONE_10_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0)
@interface Helper () <CALayerDelegate, CAAnimationDelegate>
#else
@interface Helper ()
#endif
@property (strong , nonatomic) CALayer *layer;
@property (copy , nonatomic) animationFinisnBlock animationFinisnBlock;

@end


@implementation Helper

+(instancetype)sharedInstance{
    static Helper *Helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Helper = [[self alloc] init];
    });
    return Helper;
}
-(void)startAnimationandView:(UIView *)view andRect:(CGRect)rect andFinisnRect:(CGPoint)finishPoint andFinishBlock:(animationFinisnBlock)completion
{
    //图层
    _layer = [CALayer layer];
    _layer.contents = view.layer.contents;
    _layer.contentsGravity = kCAGravityResizeAspectFill;
    rect.size.width = 30;
    rect.size.height = 30;   //重置图层尺寸
    _layer.bounds = rect;
    _layer.cornerRadius = rect.size.width/2;
    _layer.masksToBounds = YES;          //圆角
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.window.layer addSublayer:_layer];
    
    _layer.position = CGPointMake(rect.origin.x+view.frame.size.width/2, CGRectGetMidY(rect)); //a 点
    // 路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:_layer.position];
    [path addQuadCurveToPoint:finishPoint controlPoint:CGPointMake(kScreen_Width/2, rect.origin.y-80)];
    //关键帧动画
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.path = path.CGPath;
    //
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotateAnimation.removedOnCompletion = YES;
    rotateAnimation.fromValue = [NSNumber numberWithFloat:0];
    rotateAnimation.toValue = [NSNumber numberWithFloat:12];
    rotateAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[pathAnimation,rotateAnimation];
    groups.duration = 0.8f;
    groups.removedOnCompletion=NO;
    groups.fillMode=kCAFillModeForwards;
    groups.delegate = self;
    [_layer addAnimation:groups forKey:@"group"];
    if (completion) {
        _animationFinisnBlock = completion;
    }
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //    [anim def];
    if (anim == [_layer animationForKey:@"group"]) {
        
        [_layer removeFromSuperlayer];
        _layer = nil;
        if (_animationFinisnBlock) {
            _animationFinisnBlock(YES);
        }
    }
}
+(void)shakeAnimation:(UIView *)shakeView
{
    CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    shakeAnimation.duration = 0.25f;
    shakeAnimation.fromValue = [NSNumber numberWithFloat:-5];
    shakeAnimation.toValue = [NSNumber numberWithFloat:5];
    shakeAnimation.autoreverses = YES;
    [shakeView.layer addAnimation:shakeAnimation forKey:nil];
}
@end

