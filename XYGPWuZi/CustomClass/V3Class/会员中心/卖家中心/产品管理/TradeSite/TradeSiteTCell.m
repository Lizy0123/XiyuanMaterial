//
//  TradeSiteTCell.m
//  XYGPWuZi
//
//  Created by Lzy on 2017/12/22.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "TradeSiteTCell.h"

@interface TradeSiteTCell ()
@property(strong, nonatomic) UILabel *titleLabel, *brandLabel, *versionLabel;
@property(strong, nonatomic) UIButton *delBtn;
@end

@implementation TradeSiteTCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        {
            UILabel *label = [UILabel new];
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:13];
            [self.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(self);
                make.left.equalTo(self).offset(16);
                make.width.mas_equalTo((kScreen_Width-32)/2);
            }];
            self.titleLabel = label;
        }
        {
            UILabel *label = [UILabel new];
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:13];
            [self.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self);
                make.height.mas_equalTo(self.height/2);
                make.left.equalTo(self.titleLabel.mas_right);
                make.width.mas_equalTo((kScreen_Width-32 - 30)/2);
            }];
            self.brandLabel = label;
        }
        {
            UILabel *label = [UILabel new];
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:13];
            [self.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.brandLabel.mas_bottom);
                make.bottom.equalTo(self);
                make.left.equalTo(self.titleLabel.mas_right);
                make.width.mas_equalTo((kScreen_Width-32 - 30)/2);
            }];
            self.versionLabel = label;
        }
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [btn setTitle:@"X" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"delButton"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(actionDel:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.right.equalTo(self.contentView.mas_right).offset(-16);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        self.delBtn = btn;
    }
    return self;
}
-(void)setModel:(MyProductModel *)model{
    _model = model;
    
    self.titleLabel.text = model.piName;
    self.brandLabel.text = model.piCpcd;
    self.versionLabel.text = model.piCpxh;
    
}
-(void)actionDel:(id)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(delProductWithCell:)]) {
        [self.delegate delProductWithCell:self];
    }
}

@end
