//
//  XianZhiQiuGouCell.m
//  XYGPWuZi
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "XianZhiQiuGouCell.h"
#import "JiaoYiYuGaoTCell.h"

@interface XianZhiQiuGouCell ()
@property(strong, nonatomic)UIView *backGroundView;
@property(strong, nonatomic)UILabel *titleLabel, *timeLabel;
@property(strong, nonatomic)CustomLabel *firstLabel, *secondLabel, *thirdLabel;

@end

@implementation XianZhiQiuGouCell

-(UIView *)backGroundView{
    if (!_backGroundView) {
        _backGroundView = ({
            UIView *view = [[UIView alloc] initWithFrame:(CGRect){self.contentView.frame.origin,self.contentView.frame.size.width,self.contentView.frame.size.height - 10}];
            view.backgroundColor = UIColor.whiteColor;
            view;
        });
    }return _backGroundView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.textColor = [UIColor blackColor];
            label.font = [UIFont boldSystemFontOfSize:17];
            label.numberOfLines = 2;
            label;
        });
    }return _titleLabel;
}
- (CustomLabel *)firstLabel{
    if (!_firstLabel) {
        _firstLabel = ({
            CustomLabel *label = [[CustomLabel alloc] init];
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:17];
            label.numberOfLines = 1;
            label.backgroundColor = UIColor.groupTableViewBackgroundColor;
            label.cornerRadius = 3;
            label.layer.borderWidth = 1;
            label.layer.borderColor = UIColor.grayColor.CGColor;
            label.textInsets = UIEdgeInsetsMake(3.f, 3.f, 3.f, 3.f); // 设置左内边距
            label;
        });
    }return _firstLabel;
}
- (CustomLabel *)secondLabel{
    if (!_secondLabel) {
        _secondLabel =  ({
            CustomLabel *label = [[CustomLabel alloc] init];
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:17];
            label.numberOfLines = 1;
            label.backgroundColor = UIColor.groupTableViewBackgroundColor;
            label.cornerRadius = 3;
            label.layer.borderWidth = 1;
            label.layer.borderColor = UIColor.grayColor.CGColor;
            label.textInsets = UIEdgeInsetsMake(3.f, 3.f, 3.f, 3.f); // 设置左内边距
            label;
        });
    }return _secondLabel;
}
-(CustomLabel *)thirdLabel{
    if (!_thirdLabel) {
        _thirdLabel =  ({
            CustomLabel *label = [[CustomLabel alloc] init];
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:17];
            label.numberOfLines = 1;
            label.backgroundColor = UIColor.groupTableViewBackgroundColor;
            label.cornerRadius = 3;
            label.layer.borderWidth = 1;
            label.textInsets = UIEdgeInsetsMake(3.f, 3.f, 3.f, 3.f); // 设置左内边距
            label.layer.borderColor = UIColor.grayColor.CGColor;
            label;
        });
    }return _thirdLabel;
}
-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.textColor = UIColor.grayColor;
            label.font = [UIFont systemFontOfSize:17];
            label.numberOfLines = 1;
            label.textAlignment = NSTextAlignmentRight;
            label;
        });
    }return _timeLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:self.backGroundView];
        
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(kMyPadding);
            make.right.equalTo(self.contentView).offset(-kMyPadding);
            make.height.mas_equalTo(50);
        }];
        
        [self.contentView addSubview:self.firstLabel];
        [self.firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(3);
            make.left.mas_equalTo(self.contentView.mas_left).offset(kMyPadding);
            make.height.mas_equalTo(20);
        }];
        
        [self.contentView addSubview:self.secondLabel];
        [self.secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(3);
            make.left.mas_equalTo(self.firstLabel.mas_right).offset(kMyPadding);
            make.height.mas_equalTo(20);
        }];
        
        [self.contentView addSubview:self.thirdLabel];
        [self.thirdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(3);
            make.left.mas_equalTo(self.secondLabel.mas_right).offset(kMyPadding);
            make.height.mas_equalTo(20);
        }];
        
        [self.contentView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(3);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-kMyPadding);
            make.width.mas_equalTo(kScreen_Width-kMyPadding*2);
        }];
    }return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.backGroundView.frame = (CGRect){self.contentView.frame.origin,self.contentView.frame.size.width,self.contentView.frame.size.height - 10};
}
-(void)setTransactionM:(JiaoYiYuGaoModel *)transactionM{
    
    if ([NSObject isString:transactionM.tnTitle]) {
        _titleLabel.text = transactionM.tnTitle;
    }
    
    if ([NSObject isString:transactionM.tnAddress]) {
        NSString *address = transactionM.tnAddress;
        NSArray *temp = [address componentsSeparatedByString:@","];
        if (temp.count == 1) {
            self.firstLabel.text = temp[0];
            self.firstLabel.adjustsFontSizeToFitWidth = YES;
        }else if (temp.count == 2){
            self.firstLabel.text = temp[0];
            self.firstLabel.adjustsFontSizeToFitWidth = YES;
            self.secondLabel.text = temp[1];
            [self.secondLabel setAdjustsFontSizeToFitWidth:YES];
        }else if (temp.count == 3){
            self.firstLabel.text = temp[0];
            self.firstLabel.adjustsFontSizeToFitWidth = YES;
            self.secondLabel.text = temp[1];
            [self.secondLabel setAdjustsFontSizeToFitWidth:YES];
            self.thirdLabel.text = temp[2];
            [self.thirdLabel setAdjustsFontSizeToFitWidth:YES];
        }else{
            if (temp.count>3) {
                self.firstLabel.text = temp[0];
                self.firstLabel.adjustsFontSizeToFitWidth = YES;
                self.secondLabel.text = temp[1];
                [self.secondLabel setAdjustsFontSizeToFitWidth:YES];
                self.thirdLabel.text = temp[2];
                [self.thirdLabel setAdjustsFontSizeToFitWidth:YES];
            }else{
                self.firstLabel.text = transactionM.tnAddress;
                self.firstLabel.adjustsFontSizeToFitWidth = YES;
            }
        }
        
    }
    if ([NSObject isString:transactionM.tnCretime]) {
        NSString *time = [transactionM.tnCretime substringToIndex:10];
        self.timeLabel.text = time;
    }
}
-(void)setWantToBuyM:(XianZhiQiuGouModel *)wantToBuyM{
    _wantToBuyM = wantToBuyM;
    
    if ([NSObject isString:wantToBuyM.riTitle]) {
        _titleLabel.text = wantToBuyM.riTitle;
    }
    
    if ([NSObject isString:wantToBuyM.riAddress]) {
        NSString *address = wantToBuyM.riAddress;
        NSArray *temp = [address componentsSeparatedByString:@","];
        if (temp.count == 1) {
            self.firstLabel.text = temp[0];
            self.firstLabel.adjustsFontSizeToFitWidth = YES;
        }else if (temp.count == 2){
            self.firstLabel.text = temp[0];
            self.firstLabel.adjustsFontSizeToFitWidth = YES;
            self.secondLabel.text = temp[1];
            [self.secondLabel setAdjustsFontSizeToFitWidth:YES];
        }else if (temp.count == 3){
            self.firstLabel.text = temp[0];
            self.firstLabel.adjustsFontSizeToFitWidth = YES;
            self.secondLabel.text = temp[1];
            [self.secondLabel setAdjustsFontSizeToFitWidth:YES];
            self.thirdLabel.text = temp[2];
            [self.thirdLabel setAdjustsFontSizeToFitWidth:YES];
        }else{
            if (temp.count>3) {
                self.firstLabel.text = temp[0];
                self.firstLabel.adjustsFontSizeToFitWidth = YES;
                self.secondLabel.text = temp[1];
                [self.secondLabel setAdjustsFontSizeToFitWidth:YES];
                self.thirdLabel.text = temp[2];
                [self.thirdLabel setAdjustsFontSizeToFitWidth:YES];
            }else{
                self.firstLabel.text = wantToBuyM.riAddress;
                self.firstLabel.adjustsFontSizeToFitWidth = YES;
            }
        }
    }
    
    if ([NSObject isString:wantToBuyM.riModtime]) {
        self.timeLabel.text = [wantToBuyM.riModtime substringToIndex:10];
    }else{
        self.timeLabel.text = @"暂无时间";
    }
}
+(CGFloat)cellHeight{
    return 95.0;
}
@end
