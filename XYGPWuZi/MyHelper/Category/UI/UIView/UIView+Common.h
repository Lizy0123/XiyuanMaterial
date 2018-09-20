//
//  UIView+Common.h
//  XYGPWuZi
//
//  Created by Lzy on 2017/12/14.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBadgeView.h"

typedef NS_ENUM(NSInteger, BadgePositionType) {
    
    BadgePositionTypeDefault = 0,
    BadgePositionTypeMiddle
};


@interface UIView (Common)
#pragma mark - Property
@property(assign, nonatomic) CGPoint origin;
@property(assign, nonatomic) CGFloat x;
@property(assign, nonatomic) CGFloat y;
@property(assign, nonatomic) CGFloat top;
@property(assign, nonatomic) CGFloat left;
@property(assign, nonatomic) CGFloat bottom;
@property(assign, nonatomic) CGFloat right;
@property(assign, nonatomic) CGSize size;
@property(assign, nonatomic) CGFloat width;
@property(assign, nonatomic) CGFloat height;
@property(assign, nonatomic) CGFloat boundsWidth;
@property(assign, nonatomic) CGFloat boundsHeight;
@property(assign, nonatomic) CGFloat centerX;
@property(assign, nonatomic) CGFloat centerY;
@property(assign, nonatomic) CGFloat maxX;
@property(assign, nonatomic) CGFloat maxY;
@property(readonly, nonatomic) CGFloat screenX;
@property(readonly, nonatomic) CGFloat screenY;
@property(readonly, nonatomic) CGRect screenFrame;

@property(nonatomic) IBInspectable CGFloat cornerRadius;
@property(nonatomic) IBInspectable CGFloat borderWidth;
@property(nonatomic) IBInspectable UIColor *borderColor;
@property(nonatomic) IBInspectable UIColor *shadowColor;
@property(nonatomic) IBInspectable float shadowOpacity;
@property(nonatomic) IBInspectable CGSize shadowOffset;
@property(nonatomic) IBInspectable CGFloat shadowRadius;
@property(nonatomic) IBInspectable BOOL masksToBounds;


+ (UIView *)lineViewWithPointYY:(CGFloat)pointY andColor:(UIColor *)color andLeftSpace:(CGFloat)leftSpace;
- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown andColor:(UIColor *)color andLeftSpace:(CGFloat)leftSpace;




- (void)addBadgeTip:(NSString *)badgeValue withCenterPosition:(CGPoint)center;
- (void)addBadgeTip:(NSString *)badgeValue;
- (void)addBadgePoint:(NSInteger)pointRadius withPosition:(BadgePositionType)type;
- (void)addBadgePoint:(NSInteger)pointRadius withPointPosition:(CGPoint)point;
- (void)removeBadgePoint;
- (void)removeBadgeTips;

@end
