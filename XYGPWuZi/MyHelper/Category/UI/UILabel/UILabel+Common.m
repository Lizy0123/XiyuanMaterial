//
//  UILabel+Common.m
//  XYGPWuZi
//
//  Created by Lzy on 2018/1/25.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "UILabel+Common.h"
#import <objc/runtime.h>

// st_isAnimating asscoiate key
static void * FakeLabelAnimationIsAnimatingKey = &FakeLabelAnimationIsAnimatingKey;

@interface UILabel ()

@property (assign, nonatomic) BOOL fake_isAnimating; ///< default is NO

@end

@implementation UILabel (Common)
- (void)fakeStartAnimationWithDirection:(FakeAnimationDirection)direction toText:(NSString *)toText {
    if (![toText respondsToSelector:@selector(length)]) {
        return;
    }
    if (self.fake_isAnimating) {
        return;
    }
    self.fake_isAnimating = YES;
    
    UILabel *fakeLabel = [UILabel new];
    fakeLabel.frame = self.frame;
    fakeLabel.textAlignment = self.textAlignment;
    fakeLabel.font = self.font;
    fakeLabel.textColor = self.textColor;
    fakeLabel.text = toText;
    fakeLabel.backgroundColor = self.backgroundColor != nil ? self.backgroundColor : [UIColor clearColor];
    [self.superview addSubview:fakeLabel];
    
    CGFloat labelOffsetX = 0.0;
    CGFloat labelOffsetY = 0.0;
    CGFloat labelScaleX = 0.1;
    CGFloat labelScaleY = 0.1;
    
    if (direction == FakeAnimationDown || direction == FakeAnimationUp) {
        labelOffsetY = direction * CGRectGetHeight(self.bounds) / 4;
        labelScaleX = 1.0;
    }
    if (direction == FakeAnimationLeft || direction == FakeAnimationRight) {
        labelOffsetX = direction * CGRectGetWidth(self.bounds) / 2;
        labelScaleY = 1.0;
    }
    fakeLabel.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(labelScaleX, labelScaleY), CGAffineTransformMakeTranslation(labelOffsetX, labelOffsetY));
    
    [UIView animateWithDuration:kFakeLabelAnimationDuration animations:^{
        fakeLabel.transform = CGAffineTransformIdentity;
        self.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(labelScaleX, labelScaleY), CGAffineTransformMakeTranslation(-labelOffsetX, -labelOffsetY));
    } completion:^(BOOL finished) {
        self.transform = CGAffineTransformIdentity;
        [fakeLabel removeFromSuperview];
        self.text = toText;
        self.fake_isAnimating = NO;
    }];
}

- (BOOL)fake_isAnimating {
    NSNumber *isAnimatingNumber = objc_getAssociatedObject(self, FakeLabelAnimationIsAnimatingKey);
    return isAnimatingNumber.boolValue;
}

- (void)setFake_isAnimating:(BOOL)fake_isAnimating {
    objc_setAssociatedObject(self, FakeLabelAnimationIsAnimatingKey, @(fake_isAnimating), OBJC_ASSOCIATION_ASSIGN);
}

@end
