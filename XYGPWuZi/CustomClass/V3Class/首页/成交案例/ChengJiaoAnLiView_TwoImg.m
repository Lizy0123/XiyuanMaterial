//
//  ChengJiaoAnLiView_TwoImg.m
//  XYGPWuZi
//
//  Created by apple on 2018/9/10.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "ChengJiaoAnLiView_TwoImg.h"

#define kOneImgWidth (kScreen_Width-kMyPadding/4)/2
@interface ChengJiaoAnLiView_TwoImg()

@property(strong, nonatomic)Model_ChengJiaoAnLi *leftProductM;
@property(strong, nonatomic)Model_ChengJiaoAnLi *rightProductM;

@end

@implementation ChengJiaoAnLiView_TwoImg

-(ChengJiaoAnLiCView *)leftProduct{
    if (!_leftProduct) {
        _leftProduct = [[ChengJiaoAnLiCView alloc] initWithFrame:CGRectMake(0, 0, kOneImgWidth, self.frame.size.height)];
        _leftProduct.contentMode = UIViewContentModeScaleAspectFill;
        _leftProduct.clipsToBounds = YES;
        _leftProduct.userInteractionEnabled = YES;
        [_leftProduct addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionLeft:)]];
    }return _leftProduct;
}
-(ChengJiaoAnLiCView *)rightProduct{
    if (!_rightProduct) {
        _rightProduct = [[ChengJiaoAnLiCView alloc] initWithFrame:CGRectMake(kOneImgWidth +kMyPadding/4, 0, kOneImgWidth, self.frame.size.height)];
        _rightProduct.contentMode = UIViewContentModeScaleAspectFill;
        _rightProduct.clipsToBounds = YES;
        [_rightProduct addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionRight:)]];
    }return _rightProduct;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.leftProduct];
        [self addSubview:self.rightProduct];
    }return self;
}
-(void)configProductWithArr:(NSArray *)productArr indexPath:(NSIndexPath *)indexPath{
    for (UIView * views in self.subviews) {
        [views setHidden:NO];
    }
    if (productArr.count % 2 != 0) {
        for (UIView * views  in self.subviews) {
            [views setHidden:NO];
            if (views.tag == productArr.count) {
                [views setHidden:YES];
            }
        }
    }
    //配置左侧的产品
    _leftProductM = [productArr objectAtIndex:indexPath.row*2];

    self.leftProduct.successM = _leftProductM;
    //配置右侧的产品
    if (indexPath.row*2+1 < productArr.count) {
        _rightProductM = [productArr objectAtIndex:indexPath.row * 2 + 1];
        
        self.rightProduct.successM = _rightProductM;
    }
}
-(void)actionLeft:(UITapGestureRecognizer *)tap{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(productView_TwoImg:didSelectProduct:)]) {
        [self.delegate productView_TwoImg:self didSelectProduct:self.leftProductM];
    }
}
-(void)actionRight:(UITapGestureRecognizer *)tap{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(productView_TwoImg:didSelectProduct:)]) {
        [self.delegate productView_TwoImg:self didSelectProduct:self.rightProductM];
    }
}
+(CGFloat)cellHeight{
    return ((kScreen_Width - kMyPadding/4)/2+65);
}

@end
