//
//  ChengJiaoAnLiView_TwoImg.h
//  XYGPWuZi
//
//  Created by apple on 2018/9/10.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChengJiaoAnLiCView.h"
#import "Api_ChengJiaoAnLi.h"

@class ChengJiaoAnLiView_TwoImg;
@protocol ProductView_TwoImgDelegate<NSObject>
-(void)productView_TwoImg:(ChengJiaoAnLiView_TwoImg *)productView_TwoImg didSelectProduct:(Model_ChengJiaoAnLi *)productM;

@end
@interface ChengJiaoAnLiView_TwoImg : UIView

@property(weak, nonatomic)id<ProductView_TwoImgDelegate> delegate;
@property(strong, nonatomic)ChengJiaoAnLiCView *leftProduct;
@property(strong, nonatomic)ChengJiaoAnLiCView *rightProduct;
-(void)configProductWithArr:(NSArray *)productArr indexPath:(NSIndexPath *)indexPath;
+(CGFloat)cellHeight;
@end
