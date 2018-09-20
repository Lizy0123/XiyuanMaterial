//
//  Message_LiuyanTCell.m
//  XYGPWuZi
//
//  Created by apple on 2018/9/17.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "Message_LiuyanTCell.h"

@implementation Message_LiuyanTCell
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = ({
            UILabel *label = [UILabel new];
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = UIColor.blackColor;
            label.font = [UIFont systemFontOfSize:17];
            label;
        });
    }return _titleLabel;
}
-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = ({
            UILabel *label = [UILabel new];
            label.textAlignment = NSTextAlignmentRight;
            label.textColor = UIColor.grayColor;
            label.font = [UIFont systemFontOfSize:15];
            label;
        });
    }return _timeLabel;
}
-(UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = ({
            UILabel *label = [UILabel new];
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = UIColor.grayColor;
            label.font = [UIFont systemFontOfSize:13];
            label;
        });
    }return _detailLabel;
}

-(void)layoutSubviews{
    [super layoutSubviews];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        [self .contentView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(kMyPadding);
            make.right.equalTo(self.contentView).offset(-4);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(kMyPadding*5.5);
        }];
        
        [self .contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(kMyPadding);
            make.left.equalTo(self.contentView).offset(kMyPadding);
            make.height.mas_equalTo(30);
            make.right.mas_equalTo(self.timeLabel.mas_left);
        }];
        
        
        [self .contentView addSubview:self.detailLabel];
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(3);
            make.right.equalTo(self.contentView).offset(-4);
            make.left.equalTo(self.contentView).offset(kMyPadding);
            make.height.mas_equalTo(50);
        }];
        
    }return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
