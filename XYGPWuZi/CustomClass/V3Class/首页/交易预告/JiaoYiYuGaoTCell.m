//
//  JiaoYiYuGaoTCell.m
//  XYGPWuZi
//
//  Created by Lzy on 2017/12/28.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "JiaoYiYuGaoTCell.h"

@implementation CustomLabel
- (instancetype)init {
    if (self = [super init]) {
        _textInsets = UIEdgeInsetsZero;
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _textInsets = UIEdgeInsetsZero;
    }
    return self;
}
- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, _textInsets)];
}
@end


@interface JiaoYiYuGaoTCell ()
@property(strong, nonatomic)UIView *backGroundView;
@property(strong, nonatomic)UILabel *titleLabel, *bottomLabel, *contentLabel;
@property(strong, nonatomic)CustomLabel *firstLabel, *secondLabel, *thirdLabel;

@end
@implementation JiaoYiYuGaoTCell
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
-(UILabel *)bottomLabel{
    if (!_bottomLabel) {
        _bottomLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.textColor = UIColor.grayColor;
            label.font = [UIFont systemFontOfSize:15];
            label.numberOfLines = 2;
            label;
        });
    }return _bottomLabel;
}
-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.textColor = UIColor.grayColor;
            label.font = [UIFont systemFontOfSize:15];
            label.numberOfLines = 2;
            label;
        });
    }return _contentLabel;
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
        
        [self.contentView addSubview:self.bottomLabel];
        [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.firstLabel.mas_bottom).offset(kMyPadding);
            make.left.mas_equalTo(self.contentView.mas_left).offset(kMyPadding);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-kMyPadding);
//            make.height.mas_equalTo(20);
        }];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = UIColor.groupTableViewBackgroundColor;
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.bottomLabel.mas_bottom).offset(kMyPadding/2);
            make.left.mas_equalTo(self.contentView.mas_left).offset(10);
            make.right.mas_equalTo(self.contentView.right).offset(-10);
            make.height.mas_equalTo(1);
            
        }];
        
        [self.contentView addSubview:self.contentLabel];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.bottomLabel.mas_bottom).offset(kMyPadding);
            make.left.mas_equalTo(self.contentView.mas_left).offset(kMyPadding);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-kMyPadding);
            //            make.height.mas_equalTo(20);
        }];
    }return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.backGroundView.frame = (CGRect){self.contentView.frame.origin,self.contentView.frame.size.width,self.contentView.frame.size.height - 10};
}
-(void)setTransactionM:(JiaoYiYuGaoModel *)transactionM{
    _transactionM = transactionM;
    if ([NSObject isString:transactionM.tnTitle]) {
        _titleLabel.text = transactionM.tnTitle;
    }
    
    self.bottomLabel.text = [NSString stringWithFormat:@"卖方名称：%@\n看货时间：%@",@"河北熙元科技有限公司",@"2016-10-09"];
    self.contentLabel.text = @"高三的时候回家我爸妈就会搞出各种各样的夜宵给我，最多的还是面条，番茄鸡蛋面，晚饭剩菜拌面，肉酱面。再摆高三的时候回家我爸妈就会搞出各种各样的夜宵给我，最多的还是面条，番茄鸡蛋面，晚饭剩菜拌面，肉酱面。再摆高三的时候回家我爸妈就会搞出各种各样的夜宵给我，最多的还是面条，番茄鸡蛋面，晚饭剩菜拌面，肉酱面。再摆……";
    
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
}

+(CGFloat)cellHeight{
    return 200.0;
}

@end
