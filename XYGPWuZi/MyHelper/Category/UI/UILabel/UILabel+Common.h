//
//  UILabel+Common.h
//  XYGPWuZi
//
//  Created by Lzy on 2018/1/25.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, FakeAnimationDirection) {
    FakeAnimationRight = 1,       ///< left to right
    FakeAnimationLeft = -1,       ///< right to left
    FakeAnimationDown = -2,       ///< up to down
    FakeAnimationUp = 2           ///< down to up
};

// animation duration
static const NSTimeInterval kFakeLabelAnimationDuration = 0.2;


@interface UILabel (Common)
- (void)fakeStartAnimationWithDirection:(FakeAnimationDirection)direction toText:(NSString *)toText;

@end
