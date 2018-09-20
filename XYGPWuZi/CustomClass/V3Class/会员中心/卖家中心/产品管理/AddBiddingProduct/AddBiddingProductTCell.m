//
//  AddBiddingProductTCell.m
//  XYGPWuZi
//
//  Created by Lzy on 2018/1/5.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//
#define kCellHeight 100.0f

#import "AddBiddingProductTCell.h"

@interface AddBiddingProductTCell ()
@property(nonatomic, strong)UILabel *titleLabel, *brandLabel, *numberLabel, *typeLabel, *limitYearLabel;
@end
@implementation AddBiddingProductTCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UIView *backView = [UIView new];
        backView.backgroundColor = [UIColor whiteColor];
        
        
        [self.contentView addSubview:backView];
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(kMyPadding);
            make.right.equalTo(self.contentView);
            make.top.equalTo(self.contentView).offset(kMyPadding/2);
            make.height.mas_equalTo(kCellHeight - kMyPadding);
        }];
        
        {//titleLabel
            UILabel *label = [UILabel new];
            label.font = [UIFont systemFontOfSize:16];
            label.textAlignment = NSTextAlignmentLeft;
            label.numberOfLines = 1;
            [self.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(backView);
                make.top.equalTo(backView);
                make.width.mas_equalTo((self.contentView.width - kMyPadding));
                make.height.mas_equalTo(20);
            }];
            self.titleLabel = label;
        }
        {//brandLabel
            UILabel *label = [UILabel new];
            label.font = [UIFont systemFontOfSize:13];
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = [UIColor grayColor];
            label.numberOfLines = 1;
            [self.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(backView);
                make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(kMyPadding/2);
                make.width.mas_equalTo((self.contentView.width - kMyPadding)/2);
                make.height.mas_equalTo(20);
            }];
            self.brandLabel = label;
        }
        {//numberLabel
            UILabel *label = [UILabel new];
            label.font = [UIFont systemFontOfSize:13];
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = [UIColor grayColor];
            label.numberOfLines = 1;
            [self.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(backView);
                make.top.mas_equalTo(self.brandLabel.mas_bottom).offset(kMyPadding/2);
                make.width.mas_equalTo((self.contentView.width - kMyPadding)/2);
                make.height.mas_equalTo(20);
            }];
            self.numberLabel = label;
        }
        {//typeLabel
            UILabel *label = [UILabel new];
            label.font = [UIFont systemFontOfSize:13];
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = [UIColor grayColor];
            label.numberOfLines = 1;
            [self.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.brandLabel.mas_right).offset(kMyPadding/2);
                make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(kMyPadding/2);
                make.width.mas_equalTo((self.contentView.width - kMyPadding)/2);
                make.height.mas_equalTo(20);
            }];
            self.typeLabel = label;
        }
        {//limitYearLabel
            UILabel *label = [UILabel new];
            label.font = [UIFont systemFontOfSize:13];
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = [UIColor grayColor];
            label.numberOfLines = 1;
            [self.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.numberLabel.mas_right).offset(kMyPadding/2);
                make.top.mas_equalTo(self.brandLabel.mas_bottom).offset(kMyPadding/2);
                make.width.mas_equalTo((self.contentView.width - kMyPadding)/2);
                make.height.mas_equalTo(20);
            }];
            self.limitYearLabel = label;
        }
    }return self;
}
-(void)setProductM:(MyProductModel *)productM{
    _productM = productM;
    //标题
    self.titleLabel.text = productM.piName;
    
    //品牌
    self.brandLabel.text = ![NSObject isString:productM.piGzxs]? @"品牌:  暂无": [NSString stringWithFormat:@"品牌:  %@",productM.piCpcd];
    //数量
    self.numberLabel.text = ![NSObject isString:productM.piNumber]? @"数量:  暂无": [NSString stringWithFormat:@"数量:  %@",productM.piNumber];
    //型号
    self.typeLabel.text = ![NSObject isString:productM.piCpxh]? @"型号:  暂无": [NSString stringWithFormat:@"型号:  %@",productM.piCpxh];
    //使用年限
    self.limitYearLabel.text = ![NSObject isString:productM.piGzxs]? @"使用年限:  暂无": [NSString stringWithFormat:@"使用年限:  %@",productM.piGzxs];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+(CGFloat)cellHeight{
    return kCellHeight;
}
@end
