//
//  ChhuJiaJiLuTCell.m
//  XYGPWuZi
//
//  Created by Lzy on 2018/1/10.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//
#define kCellHeight 50
#import "ChhuJiaJiLuTCell.h"

@interface ChhuJiaJiLuTCell ()
@property (strong, nonatomic) UILabel *titleLabel, *valueLabel, *timeLabel;
@property (strong, nonatomic) NSString *title, *value;
@end

@implementation ChhuJiaJiLuTCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        if (!_titleLabel) {
            _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMyPadding, 0, (kScreen_Width - kMyPadding*2)/2 , 35)];
            _titleLabel.backgroundColor = [UIColor clearColor];
            _titleLabel.font = [UIFont systemFontOfSize:17];
            _titleLabel.textColor = [UIColor blackColor];
            _titleLabel.textAlignment = NSTextAlignmentCenter;

            [self.contentView addSubview:_titleLabel];
        }
        UIView *linView = [[UIView alloc] initWithFrame:CGRectMake((kScreen_Width - kMyPadding *2)/2, kMyPadding/2, 0.5, kCellHeight - kMyPadding)];
        linView.backgroundColor = [UIColor lightGrayColor];
        [_titleLabel addSubview:linView];
        
        if (!_timeLabel) {
            _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMyPadding, 35, (kScreen_Width -kMyPadding *2)/2 , 15)];
            _timeLabel.backgroundColor = [UIColor clearColor];
            _timeLabel.font = [UIFont systemFontOfSize:13];
            _timeLabel.textColor = kColorValueStr;
            _timeLabel.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:_timeLabel];
        }
        
        if (!_valueLabel) {
            _valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreen_Width/2 , 0, (kScreen_Width - kMyPadding *2)/2 + 30, kCellHeight)];
            _valueLabel.backgroundColor = [UIColor clearColor];
            _valueLabel.font = [UIFont systemFontOfSize:17];
            _valueLabel.textColor = [UIColor blackColor];
            _valueLabel.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:_valueLabel];
        }
    }
    return self;
}

-(void)setRecordM:(ChuJiaJiLuModel *)recordM{
    _recordM = recordM;
    
    
}
-(void)setRecordDetailM:(RecordDetailModel *)recordDetailM{
    _recordDetailM = recordDetailM;

    if ([NSObject isString:recordDetailM.bidNo]) {
        self.titleLabel.text = recordDetailM.bidNo;
        if ([recordDetailM.bidNo isEqualToString:@"自己"]) {
            self.titleLabel.textColor = [UIColor redColor];
            self.timeLabel.textColor = [UIColor redColor];
            self.valueLabel.textColor = [UIColor redColor];
        }
    }
    if ([NSObject isString:recordDetailM.tspBuyTime]) {
        self.timeLabel.text = recordDetailM.tspBuyTime;
    }
    if ([NSObject isString:recordDetailM.tspMoney]) {
        self.valueLabel.text = [NSObject moneyStyle:recordDetailM.tspMoney];
    }
}
-(void)setRecordJiaoyiM:(RecordJiaoyiModel *)recordJiaoyiM{
    _recordJiaoyiM = recordJiaoyiM;
    if ([NSObject isString:recordJiaoyiM.bidNo]) {
        self.titleLabel.text = recordJiaoyiM.bidNo;

    }
    if ([NSObject isString:recordJiaoyiM.tspBuyTime]) {
        self.timeLabel.text = recordJiaoyiM.tspBuyTime;
    }
    if ([NSObject isString:recordJiaoyiM.tspMoney]) {
        if (recordJiaoyiM.tspMoney.integerValue <0) {
            self.valueLabel.textColor = [UIColor redColor];
        }else{
            self.valueLabel.textColor = [UIColor blueColor];
        }
        self.valueLabel.text = [NSObject moneyStyle:recordJiaoyiM.tspMoney];
    }else{
        self.valueLabel.text = @"";
    }
    
    
    
}
+(CGFloat)cellHeight{
    return kCellHeight;
}
@end
