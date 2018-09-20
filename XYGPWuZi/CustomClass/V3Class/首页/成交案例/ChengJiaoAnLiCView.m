//
//  ChengJiaoAnLiCView.m
//  XYGPWuZi
//
//  Created by apple on 2018/9/10.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//
#define kBtnHeight 50
#define kBottomHeight 65
#define kShopIconHeight 20

#import "ChengJiaoAnLiCView.h"

@interface ChengJiaoAnLiCView ()
@property(strong, nonatomic)UIImageView *imageView;
@property(strong, nonatomic)UILabel *titleLabel, *priceOrShopLabel;
@property(strong, nonatomic)UILabel *countTimeOrCollectNumLabel;
@property(strong, nonatomic)UIButton *collectBtn;

@end

@implementation ChengJiaoAnLiCView

-(UIButton *)collectBtn{
    if (!_collectBtn) {
        _collectBtn = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button.layer setCornerRadius:kBtnHeight/2];
            [button setClipsToBounds:YES];
            [button setBackgroundColor:[UIColor lightGrayColor]];
            [button.titleLabel setFont:[UIFont systemFontOfSize:13]];
            [button setTitle:@"收藏" forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"dealImage"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageWithColor:UIColor.clearColor] forState:UIControlStateSelected];
            [button setBackgroundImage:[UIImage imageWithColor:UIColor.clearColor] forState:UIControlStateNormal];
            [button setBackgroundColor:UIColor.clearColor];
//            [button addTarget:self action:@selector(actionCollectBtn:) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }return _collectBtn;
}
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = ({
            UIImageView *imageView = [UIImageView new];
            imageView.userInteractionEnabled = YES;
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            imageView.backgroundColor = [UIColor whiteColor];
            imageView;
        });
    }return _imageView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = UIColor.redColor;
            label.font = [UIFont systemFontOfSize:20];
            label.backgroundColor = [UIColor whiteColor];
            label;
        });
    }return _titleLabel;
}
-(UILabel *)priceOrShopLabel{
    if (!_priceOrShopLabel) {
        _priceOrShopLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = UIColor.blackColor;
            label.font = [UIFont systemFontOfSize:12];
            label.backgroundColor = [UIColor whiteColor];
            UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionShopBtn:)];
            [label addGestureRecognizer:tapGestureRecognizer];
            label;
        });
    }return _priceOrShopLabel;
}
//-(UIImageView *)shopIcon{
//    if (!_shopIcon) {
//        _shopIcon = ({
//            UIImageView *imageView = [[UIImageView alloc] initWithFrame:(CGRect){0,0,30,30}];
//            imageView.userInteractionEnabled = YES;
//            imageView.clipsToBounds = YES;
//            imageView.hidden = YES;
//            //        imageView.layer.cornerRadius = 5;
//            imageView.backgroundColor = [UIColor whiteColor];
//            UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionShopBtn:)];
//            [imageView addGestureRecognizer:tapGestureRecognizer];
//            imageView;
//        });
//    }return _shopIcon;
//}
-(UILabel *)countTimeOrCollectNumLabel{
    if (!_countTimeOrCollectNumLabel) {
        _countTimeOrCollectNumLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = UIColor.grayColor;
            label.font = [UIFont systemFontOfSize:11];
            label.backgroundColor = [UIColor whiteColor];
            label;
        });
    }return _countTimeOrCollectNumLabel;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //商品图片
        [self addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(30);
            make.left.equalTo(self).offset(30);
            make.bottom.equalTo(self).offset(-kBottomHeight-30);
            make.right.equalTo(self).offset(-30);
        }];
        
        //图片上的收藏按钮
        [self addSubview:self.collectBtn];
        [self.collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(kMyPadding);
            make.right.equalTo(self).offset(-kMyPadding);
            make.size.mas_equalTo(CGSizeMake(kBtnHeight, kBtnHeight));
        }];
        
        //商品名称
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(kMyPadding/2);
            make.top.mas_equalTo(self.imageView.mas_bottom);
            make.right.equalTo(self).offset(-kMyPadding/2);
            make.height.mas_equalTo(30);
        }];
        
        //价格或者店铺名称
        [self addSubview:self.priceOrShopLabel];
        [self.priceOrShopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom);
            make.left.equalTo(self).offset(kMyPadding/2);
            make.right.equalTo(self).offset(-kMyPadding/2);
            make.height.mas_equalTo(20);
        }];
        
        //倒计时或收藏量文字
        [self addSubview:self.countTimeOrCollectNumLabel];
        [self.countTimeOrCollectNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imageView).offset(kMyPadding/2);
            make.top.mas_equalTo(self.priceOrShopLabel.mas_bottom).offset(kMyPadding/2);
            make.right.equalTo(self.imageView).offset(-kMyPadding/2);
            make.height.mas_equalTo(15);
        }];
    }return self;
}
-(void)setSuccessM:(Model_ChengJiaoAnLi *)successM{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[myCDNUrl stringByAppendingString:successM.tnPic]] placeholderImage:[UIImage imageNamed:@"placeholderImg"]];
    self.titleLabel.text = [NSString stringWithFormat: @"成交价 %@",[NSObject moneyStyle:successM.tsEndPrice]];
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.priceOrShopLabel.text = successM.tnTitle;
    if (successM.tnUnits&&successM.tnNum) {
        self.countTimeOrCollectNumLabel.text = [NSString stringWithFormat:@"成交数量：%@%@",successM.tnNum,successM.tnUnits];
    }else if (successM.tnNum) {
        self.countTimeOrCollectNumLabel.text = [NSString stringWithFormat:@"成交数量：%@",successM.tnNum];
    }else{
        self.countTimeOrCollectNumLabel.text = @"";
    }
    
    
    
    
    
//    self.shopIcon.hidden = YES;
}
-(void)actionShopBtn:(UIButton *)sender{
    
    NSLog(@"Lzy");
}
@end
