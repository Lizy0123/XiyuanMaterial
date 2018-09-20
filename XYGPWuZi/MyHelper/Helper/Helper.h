//
//  Helper.h
//  XYGPWuZi
//
//  Created by Lzy on 2017/12/23.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//
#define kKeyWindow [UIApplication sharedApplication].keyWindow
#define kHUDQueryViewTag 101

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Helper : NSObject
/**
 单例实例化一个当前对象
 
 @return 返回当前的对象
 */
+(instancetype)sharedInstance;
typedef void (^animationFinisnBlock)(BOOL finish);

/**
 *  开始动画
 *
 *  @param view        添加动画的view
 *  @param rect        view 的绝对frame
 *  @param finishPoint 下落的位置
 *  @param completion 动画完成回调
 */

-(void)startAnimationandView:(UIView *)view andRect:(CGRect)rect andFinisnRect:(CGPoint)finishPoint andFinishBlock:(animationFinisnBlock)completion;
/**
 *  摇晃动画
 */
+(void)shakeAnimation:(UIView *)shakeView;

@end


