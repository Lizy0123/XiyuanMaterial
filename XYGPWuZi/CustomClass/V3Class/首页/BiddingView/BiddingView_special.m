//
//  BiddingView_special.m
//  XYGPWuZi
//
//  Created by apple on 2018/7/2.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//
#define kHeaderHeight (60 + kMyPadding*2/3)
#define kImageSectionHeight (((kScreen_Width - kMyPadding*4)/3)+kMyPadding*2)
#define kImageWidth ((self.frame.size.width - kMyPadding*4)/3)

#define kPriceHeight 40

#import "BiddingView_special.h"

@interface BiddingView_special ()
@property(strong, nonatomic)UILabel *titleLabel, *detailLabel;
@property(strong, nonatomic)UILabel *priceLabel;
@property(strong, nonatomic)UIImageView *rightTopImgView, *imageView_Left, *imageView_Center, *imageView_Right;
@property(strong, nonatomic)UILabel *titleLabel_Left, *titleLabel_Center, *titleLabel_Right;

@end

@implementation BiddingView_special

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = UIColor.blackColor;
            label.font = [UIFont systemFontOfSize:17];
            label.backgroundColor = UIColor.whiteColor;
            label;
        });
    }return _titleLabel;
}
-(UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.textAlignment = NSTextAlignmentLeft;
            label.numberOfLines = 2;
            label.textColor = UIColor.grayColor;
            label.font = [UIFont systemFontOfSize:13];
            label.backgroundColor = UIColor.clearColor;
            label;
        });
    }return _detailLabel;
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
-(UIImageView *)imageView_Left{
    if (!_imageView_Left) {
        _imageView_Left = ({
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.userInteractionEnabled = YES;
            imageView.clipsToBounds = YES;
            imageView.backgroundColor = [UIColor whiteColor];
            imageView;
        });
    }return _imageView_Left;
}
-(UILabel *)titleLabel_Left{
    if (!_titleLabel_Left) {
        _titleLabel_Left = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:17];
            label.backgroundColor = [UIColor whiteColor];
            label;
        });
    }return _titleLabel_Left;
}
-(UIImageView *)imageView_Center{
    if (!_imageView_Center) {
        _imageView_Center = ({
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.userInteractionEnabled = YES;
            imageView.clipsToBounds = YES;
            imageView.backgroundColor = [UIColor whiteColor];
            imageView;
        });
    }return _imageView_Center;
}
-(UILabel *)titleLabel_Center{
    if (!_titleLabel_Center) {
        _titleLabel_Center = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:17];
            label.backgroundColor = [UIColor whiteColor];
            label;
        });
    }return _titleLabel_Center;
}
-(UIImageView *)imageView_Right{
    if (!_imageView_Right) {
        _imageView_Right = ({
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.userInteractionEnabled = YES;
            imageView.clipsToBounds = YES;
            imageView.backgroundColor = [UIColor whiteColor];
            imageView;
        });
    }return _imageView_Right;
}
-(UILabel *)titleLabel_Right{
    if (!_titleLabel_Right) {
        _titleLabel_Right = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:17];
            label.backgroundColor = [UIColor whiteColor];
            label;
        });
    }return _titleLabel_Right;
}



-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.whiteColor;
        //Header
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(kMyPadding);
            make.top.mas_equalTo(self).offset(kMyPadding);
            make.right.equalTo(self).offset(-kMyPadding);
            make.height.mas_equalTo(20);
        }];
        
        [self addSubview:self.detailLabel];
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(kMyPadding);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(kMyPadding/2);
            make.right.equalTo(self).offset(-kMyPadding);
            make.height.mas_equalTo(20);
        }];
        
        [self addSubview:self.rightTopImgView];
        [self.rightTopImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(kMyPadding/2);
            make.right.equalTo(self).offset(-kMyPadding);
            make.size.mas_equalTo((CGSize){25,35});
        }];
        
        //图片
        [self addSubview:self.imageView_Left];
        [self.imageView_Left mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(kHeaderHeight);
            make.left.equalTo(self).offset(kMyPadding);
            make.height.mas_equalTo(kImageWidth);
            make.width.mas_equalTo(kImageWidth);
        }];
        [self addSubview:self.titleLabel_Left];
        [self.titleLabel_Left mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imageView_Left);
            make.top.mas_equalTo(self.imageView_Left.mas_bottom);
            make.right.equalTo(self.imageView_Left);
            make.height.mas_equalTo(50);
        }];
        
        
        [self addSubview:self.imageView_Center];
        [self.imageView_Center mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(kHeaderHeight);
            make.left.mas_equalTo(self.imageView_Left.mas_right).offset(kMyPadding);
            make.height.mas_equalTo(kImageWidth);
            make.width.mas_equalTo(kImageWidth);
        }];
        [self addSubview:self.titleLabel_Center];
        [self.titleLabel_Center mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imageView_Center);
            make.top.mas_equalTo(self.imageView_Center.mas_bottom);
            make.right.equalTo(self.imageView_Center);
            make.height.mas_equalTo(50);
        }];
        
        
        [self addSubview:self.imageView_Right];
        [self.imageView_Right mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(kHeaderHeight);
            make.left.mas_equalTo(self.imageView_Center.mas_right).offset(kMyPadding);
            make.height.mas_equalTo(kImageWidth);
            make.width.mas_equalTo(kImageWidth);
        }];
        [self addSubview:self.titleLabel_Right];
        [self.titleLabel_Right mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imageView_Right);
            make.top.mas_equalTo(self.imageView_Right.mas_bottom);
            make.right.equalTo(self.imageView_Right);
            make.height.mas_equalTo(50);
        }];
        //price
        [self addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(kHeaderHeight+kImageSectionHeight);
            make.left.mas_equalTo(self).offset(kMyPadding);
            make.right.equalTo(self).offset(-kMyPadding);
            make.height.mas_equalTo(50);
//            make.centerY.equalTo(self);
        }];
    }return self;
}
-(void)setBiddingM:(BiddingModel *)biddingM{
    self.titleLabel.text = @"2018年京城矿业首批闲置物资";
    self.detailLabel.text = @"专场开始时间：2018-03-03- 18：00";
//    self.priceLabel.text = @"保证金：¥99.00-¥99.00";
    NSString *aheadStr = @"保证金：";
    NSString *moneyStr1 = @"99.00";
    NSString *moneyStr2 = @"99.00";
    
    NSMutableAttributedString * moneyAttrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@-%@",aheadStr,[NSObject moneyStyle:moneyStr1],[NSObject moneyStyle:moneyStr2]]];
    [moneyAttrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0f] range:NSMakeRange(0, aheadStr.length)];
    [moneyAttrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17.0f] range:NSMakeRange(aheadStr.length, moneyAttrStr.length - aheadStr.length)];
    [moneyAttrStr addAttribute:NSForegroundColorAttributeName value:UIColor.redColor range:NSMakeRange(aheadStr.length, moneyAttrStr.length - aheadStr.length)];

    self.priceLabel.attributedText = moneyAttrStr;
    
    [self.rightTopImgView setImage:[UIImage imageNamed:@"isComing"]];
    [self.rightTopImgView setImage:[UIImage imageNamed:@"onGoing"]];
    {//左图
        [self.imageView_Left sd_setImageWithURL:[NSURL URLWithString:kImgUrl_Light] placeholderImage:[UIImage imageNamed:@"placeholderImg"]];
        NSString *aheadStr = @"起拍价：";
        NSString *moneyStr1 = @"99.00";
        
        NSMutableAttributedString * moneyAttrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",aheadStr,[NSObject moneyStyle:moneyStr1]]];
        [moneyAttrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0f] range:NSMakeRange(0, aheadStr.length)];
        [moneyAttrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17.0f] range:NSMakeRange(aheadStr.length, moneyAttrStr.length - aheadStr.length)];
        [moneyAttrStr addAttribute:NSForegroundColorAttributeName value:UIColor.redColor range:NSMakeRange(aheadStr.length, moneyAttrStr.length - aheadStr.length)];
        self.titleLabel_Left.attributedText = moneyAttrStr;
    }
    {//中间
        [self.imageView_Center sd_setImageWithURL:[NSURL URLWithString:kImgUrl_Dark] placeholderImage:[UIImage imageNamed:@"placeholderImg"]];
        NSString *aheadStr = @"起拍价：";
        NSString *moneyStr1 = @"99.00";
        
        NSMutableAttributedString * moneyAttrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",aheadStr,[NSObject moneyStyle:moneyStr1]]];
        [moneyAttrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0f] range:NSMakeRange(0, aheadStr.length)];
        [moneyAttrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17.0f] range:NSMakeRange(aheadStr.length, moneyAttrStr.length - aheadStr.length)];
        [moneyAttrStr addAttribute:NSForegroundColorAttributeName value:UIColor.redColor range:NSMakeRange(aheadStr.length, moneyAttrStr.length - aheadStr.length)];
        self.titleLabel_Center.attributedText = moneyAttrStr;
    }
    {//右图
        [self.imageView_Right sd_setImageWithURL:[NSURL URLWithString:kImgUrl_Light] placeholderImage:[UIImage imageNamed:@"placeholderImg"]];
        NSString *aheadStr = @"起拍价：";
        NSString *moneyStr1 = @"99.00";
        
        NSMutableAttributedString * moneyAttrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",aheadStr,[NSObject moneyStyle:moneyStr1]]];
        [moneyAttrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0f] range:NSMakeRange(0, aheadStr.length)];
        [moneyAttrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17.0f] range:NSMakeRange(aheadStr.length, moneyAttrStr.length - aheadStr.length)];
        [moneyAttrStr addAttribute:NSForegroundColorAttributeName value:UIColor.redColor range:NSMakeRange(aheadStr.length, moneyAttrStr.length - aheadStr.length)];
        self.titleLabel_Right.attributedText = moneyAttrStr;
    }
}
+(CGFloat)cellHeight{
    return kHeaderHeight+kImageSectionHeight+kPriceHeight +kMyPadding;
}
@end
