//
//  XianZhiGongYingTCell.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/10/12.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "XianZhiGongYingTCell.h"
#import "UIImageView+WebCache.h"
#import "XianZhiGongYingModel.h"
@interface XianZhiGongYingTCell ()
@property(strong, nonatomic)UIView *myBackgroundView;
@property(strong, nonatomic)UIImageView *imageV;
@property(strong, nonatomic)UILabel *titleLabel, *numberLabel, *xingHaoLabel, *pinPaiLabel, *useYearLabel;
@end

@implementation XianZhiGongYingTCell

+(CGFloat)cellHeight{
    return 130.0;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        _myBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, S_W, 125)];
        _myBackgroundView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_myBackgroundView];
        
        _imageV = [[UIImageView alloc]initWithFrame:CGRectMake(kMyPadding, kMyPadding/2, 125, [XianZhiGongYingTCell cellHeight] - kMyPadding -5)];
        _imageV.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _imageV.contentMode = UIViewContentModeScaleAspectFill;
        _imageV.clipsToBounds = YES;
        [self.contentView addSubview:_imageV];
        
        {
            UILabel *label = [UILabel new];
            label.textColor = [UIColor blackColor];
            label.font = [UIFont boldSystemFontOfSize:16];
            label.numberOfLines = 2;
            [self.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.imageV.mas_right).offset(kMyPadding/2);
                make.right.mas_equalTo(self.contentView.mas_right).offset(-kMyPadding);
                make.height.mas_equalTo(40);
                make.top.mas_equalTo(self.contentView.mas_top).offset(kMyPadding/2);
            }];
            self.titleLabel = label;
        }
        {
            UILabel *label = [UILabel new];
            label.textColor = [UIColor grayColor];
            label.font = [UIFont systemFontOfSize:13];
            [self.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.imageV.mas_right).offset(kMyPadding/2);
                make.right.mas_equalTo(self.contentView.mas_right).offset(-kMyPadding);
                make.height.mas_equalTo(20);
                make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(3);
            }];
            self.xingHaoLabel = label;
        }
        {
            UILabel *label = [UILabel new];
            label.textColor = [UIColor grayColor];
            label.font = [UIFont systemFontOfSize:13];
            [self.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.imageV.mas_right).offset(kMyPadding/2);
                make.right.mas_equalTo(self.contentView.mas_right).offset(-kMyPadding);
                make.height.mas_equalTo(20);
                make.top.mas_equalTo(self.xingHaoLabel.mas_bottom).offset(3);
            }];
            self.pinPaiLabel = label;
        }
        {
            UILabel *label = [UILabel new];
            label.textColor = [UIColor grayColor];
            label.font = [UIFont systemFontOfSize:13];
            [self.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.imageV.mas_right).offset(kMyPadding/2);
                make.right.mas_equalTo(self.contentView.mas_right).offset(-kMyPadding);
                make.height.mas_equalTo(20);
                make.top.mas_equalTo(self.pinPaiLabel.mas_bottom).offset(3);
            }];
            self.useYearLabel = label;
        }
        {//数量
            UILabel *label = [UILabel new];
            label.textColor = [UIColor grayColor];
            label.font = [UIFont systemFontOfSize:13];
            label.textAlignment = NSTextAlignmentRight;
            [self.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.useYearLabel);
            }];
            self.numberLabel = label;
        }
    }
    return self;
}
-(void)setIdleModel:(XianZhiGongYingModel *)idleModel{
    _idleModel = idleModel;
    if (idleModel.picUrl) {
        NSString *picUrl = [myCDNUrl stringByAppendingString:idleModel.picUrl];
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:picUrl] placeholderImage:[UIImage imageNamed:@"icon_defaultPic"]];
    }
    else{
        self.imageV.image = [UIImage imageNamed:@"icon_defaultPic"];
    }
    
    if (idleModel.piName) {
        _titleLabel.text = idleModel.piName;
    }

    if (idleModel.piCpxh) {
        _xingHaoLabel.text = [NSString stringWithFormat:@"型号:  %@",idleModel.piCpxh];
    }else{
        _xingHaoLabel.text = @"型号:  暂无";
    }
    
    if (idleModel.piCpcd) {
        _pinPaiLabel.text = [NSString stringWithFormat:@"品牌:  %@",idleModel.piCpcd];
    }else{
        _pinPaiLabel.text = @"品牌:  暂无";
    }
    
    if (idleModel.piGzxs) {
        _useYearLabel.text = [NSString stringWithFormat:@"使用年限:  %@",idleModel.piGzxs];
    }else{
        _useYearLabel.text = @"使用年限:  暂无";
    }
    if ([NSObject isString:idleModel.piNumber]) {
        self.numberLabel.text = [NSString stringWithFormat:@"x%@%@",idleModel.piNumber,idleModel.piUnit];
    }else{
        self.numberLabel.text = @"";
    }
}
-(void)setProductModel:(MyProductModel *)productModel{
    _productModel = productModel;
    if (productModel.pic) {
        NSString *picUrl = [myCDNUrl stringByAppendingString:productModel.pic];
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:picUrl] placeholderImage:[UIImage imageNamed:@"icon_defaultPic"]];
    }
    else{
        self.imageV.image = [UIImage imageNamed:@"icon_defaultPic"];
    }
    
    if (productModel.piName) {
        _titleLabel.text = productModel.piName;
    }
    
    if (productModel.piCpxh) {
        _xingHaoLabel.text = [NSString stringWithFormat:@"型号:  %@",productModel.piCpxh];
    }else{
        _xingHaoLabel.text = @"型号:  暂无";
    }
    
    if (productModel.piCpcd) {
        _pinPaiLabel.text = [NSString stringWithFormat:@"品牌:  %@",productModel.piCpcd];
    }else{
        _pinPaiLabel.text = @"品牌:  暂无";
    }
    
    if (productModel.price) {
        _useYearLabel.text = [NSString stringWithFormat:@"价格:  %@",productModel.price];
        _useYearLabel.attributedText = [NSObject attributedStr:[NSString stringWithFormat:@"价格:%@", [NSObject moneyStyle:productModel.price]] color:[UIColor redColor] length:3];
        
    }else{
        _useYearLabel.text = @"价格:  暂无";
    }
    if ([NSObject isString:productModel.piNumber]) {
        self.numberLabel.text = [NSString stringWithFormat:@"x%@",productModel.piNumber];
    }else{
        self.numberLabel.text = @"";
    }
}
@end
