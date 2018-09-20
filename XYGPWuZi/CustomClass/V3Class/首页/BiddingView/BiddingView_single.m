//
//  BiddingView_single.m
//  XYGPWuZi
//
//  Created by apple on 2018/7/2.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//
#define kCellHeight (((kScreen_Width - kMyPadding*4)/3)+kMyPadding*2)
#define kImageHeight ((kScreen_Width - kMyPadding*4)/3)

#import "BiddingView_single.h"

@interface BiddingView_single ()
@property(strong, nonatomic)UIImageView *imageView, *rightTopImgView;
@property(strong, nonatomic)UILabel *titleLabel, *productDescLabel;
@property(strong, nonatomic)UILabel *priceLabel;
@end

@implementation BiddingView_single
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.userInteractionEnabled = YES;
        _imageView.clipsToBounds = YES;
        _imageView.backgroundColor = [UIColor whiteColor];        
    }return _imageView;
}
-(UIImageView *)rightTopImgView{
    if (!_rightTopImgView) {
        _rightTopImgView =({
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.userInteractionEnabled = YES;
            imageView.clipsToBounds = YES;
            imageView.backgroundColor = [UIColor whiteColor];
            imageView;
        });
    }return _rightTopImgView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.numberOfLines = 2;
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:17];
            label.backgroundColor = UIColor.clearColor;
            label;
        });
    }return _titleLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:(CGRect){0,0,100,50}];
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = UIColor.grayColor;
            label.font = [UIFont systemFontOfSize:17];
            label.backgroundColor = UIColor.clearColor;
            label;
        });
    }return _priceLabel;
}
-(UILabel *)productDescLabel{
    if (!_productDescLabel) {
        _productDescLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.textAlignment = NSTextAlignmentLeft;
            label.numberOfLines = 2;
            label.textColor = UIColor.grayColor;
            label.font = [UIFont systemFontOfSize:13];
            label.backgroundColor = UIColor.clearColor;
            label;
        });
    }return _productDescLabel;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.whiteColor;
        [self addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(kMyPadding/2);
            make.left.equalTo(self).offset(kMyPadding);
            make.height.mas_equalTo(kImageHeight);
            make.width.mas_equalTo(kImageHeight);
        }];
        
        [self addSubview:self.rightTopImgView];
        [self.rightTopImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(kMyPadding/2);
            make.right.equalTo(self).offset(-kMyPadding);
            make.size.mas_equalTo((CGSize){25,35});
        }];
        
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.imageView.mas_right).offset(kMyPadding);
            make.top.mas_equalTo(self).offset(kMyPadding);
            make.right.equalTo(self).offset(-kMyPadding-25);
            make.height.mas_equalTo(50);
        }];
        
        [self addSubview:self.productDescLabel];
        [self.productDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.imageView.mas_right).offset(kMyPadding);
//            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(kMyPadding/2);
            make.right.equalTo(self).offset(-kMyPadding-25);
            make.height.mas_equalTo(20);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(5);
        }];
        
        [self addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.productDescLabel.mas_bottom).offset(kMyPadding/2);
            make.left.mas_equalTo(self.imageView.mas_right).offset(kMyPadding);
            make.right.equalTo(self).offset(-kMyPadding);
            make.height.mas_equalTo(30);
        }];
        
        
        
    }return self;
}
-(void)setBiddingM:(BiddingModel *)biddingM{
    self.titleLabel.text = @"2018年京城矿业首批闲置物资";
    self.productDescLabel.text = @"专场开始时间：2018-03-03- 18：00";
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:kImgUrl_Light] placeholderImage:[UIImage imageNamed:@"placeholderImg"]];
    
    [self.rightTopImgView setImage:[UIImage imageNamed:@"isComing"]];
    [self.rightTopImgView setImage:[UIImage imageNamed:@"onGoing"]];
    
    NSString *aheadStr = @"保证金：";
    NSString *moneyStr1 = @"99.00";
    NSString *moneyStr2 = [NSString stringWithFormat:@"   数量%@ 吨",@"20"];
    
    NSMutableAttributedString * moneyAttrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@%@",aheadStr,[NSObject moneyStyle:moneyStr1],moneyStr2]];
    [moneyAttrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0f] range:NSMakeRange(0, moneyAttrStr.length)];
//    [moneyAttrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17.0f] range:NSMakeRange(aheadStr.length, moneyAttrStr.length - aheadStr.length)];
    [moneyAttrStr addAttribute:NSForegroundColorAttributeName value:UIColor.redColor range:NSMakeRange(aheadStr.length, moneyStr1.length+1)];
    
    self.priceLabel.attributedText = moneyAttrStr;
}
+(CGFloat)cellHeight{
    return kCellHeight;
}
@end
