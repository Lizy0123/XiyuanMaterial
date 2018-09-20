//
//  GongPingGongGaoTCell.m
//  XYGPWuZi
//
//  Created by apple on 2018/9/13.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "GongPingGongGaoTCell.h"

@interface GongPingGongGaoTCell ()

@end

@implementation GongPingGongGaoTCell
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.textColor = [UIColor blackColor];
            label.font = [UIFont boldSystemFontOfSize:17];
            label.numberOfLines = 1;
            label;
        });
    }return _titleLabel;
}
-(UILabel *)descLabel{
    if (!_descLabel) {
        _descLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.textColor = [UIColor grayColor];
            label.font = [UIFont boldSystemFontOfSize:15];
            label.numberOfLines = 2;
            label;
        });
    }return _descLabel;
}
-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.textColor = [UIColor grayColor];
            label.font = [UIFont boldSystemFontOfSize:13];
            label.numberOfLines = 1;
            label;
        });
    }return _timeLabel;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(10);
            make.left.equalTo(self.contentView).offset(kMyPadding);
            make.right.equalTo(self.contentView).offset(-kMyPadding);
            make.height.mas_equalTo(30);
        }];
        
        [self.contentView addSubview:self.descLabel];
        [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom);
            make.left.equalTo(self.contentView).offset(kMyPadding);
            make.right.equalTo(self.contentView).offset(-kMyPadding);
            make.height.mas_equalTo(60);
        }];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = UIColor.groupTableViewBackgroundColor;
        [self.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.descLabel.mas_bottom).offset(-1);
            make.left.right.equalTo(self.contentView);
            make.height.mas_equalTo(1);
        }];
        [self.contentView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.descLabel.mas_bottom);
            make.left.equalTo(self.contentView).offset(kMyPadding);
            make.right.equalTo(self.contentView).offset(-kMyPadding);
            make.height.mas_equalTo(30);
        }];
        
    }return self;
}
+(CGFloat)cellHeight{
    return 130;
}
@end
