//
//  MyTradeSiteListTCell.m
//  XYGPWuZi
//
//  Created by Lzy on 2018/1/8.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//
#define kIconHeight 70
#define kTopLabelHeight 20
#define kBottomViewHeight 30
#define kBottomGrayViewHeight 10
#define kBtnWidth 70
#import "MyTradeSiteListTCell.h"


@interface MyTradeSiteListTCell ()
@property(nonatomic, strong)UILabel *serialNumberLabel, *createTimeLabel, *titleLabel, *biddingTimeLabel, *biddingTypeLabel, *typeLabel, *limitYearLabel;
@property(nonatomic, strong)UIView *bottomView;
@property(nonatomic, strong)UIButton *editBtn, *leftBtn, *rightBtn, *delBtn;

@end

@implementation MyTradeSiteListTCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
        
        {//serialNumberLabel
            UILabel *label = [UILabel new];
            label.font = [UIFont systemFontOfSize:13];
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = [UIColor grayColor];
            label.numberOfLines = 1;
            [self.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(kMyPadding);
                make.top.equalTo(self.contentView);
                make.width.mas_equalTo(kScreen_Width/2);
                make.height.mas_equalTo(kTopLabelHeight);
            }];
            self.serialNumberLabel = label;
        }
        {//createTimeLabel
            UILabel *label = [UILabel new];
            label.font = [UIFont systemFontOfSize:13];
            label.textAlignment = NSTextAlignmentRight;
            label.textColor = [UIColor grayColor];
            label.numberOfLines = 1;
            [self.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.contentView).offset(-kMyPadding);
                make.top.equalTo(self.contentView);
                make.width.mas_equalTo(kScreen_Width/2);
                make.height.mas_equalTo(kTopLabelHeight);
            }];
            self.createTimeLabel = label;
        }
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:[UIImage imageNamed:@"icon_del"] forState:UIControlStateNormal];
            btn.tag = 101230;
            [btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.contentView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView);
                make.size.mas_equalTo(CGSizeMake(kBtnWidth/3, 20));
                make.right.equalTo(self.contentView).offset(-kMyPadding);
            }];
            self.delBtn = btn;
            
        }
        UIView *backView = [UIView new];
        backView.backgroundColor = [UIColor whiteColor];
        {//linViewTop
            UIView * linView = [UIView new];
            linView.backgroundColor = [UIColor lightGrayColor];
            [backView addSubview:linView];
            [linView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.right.equalTo(backView);
                make.height.mas_equalTo(0.5);
            }];
        }
        {//linViewBottom
            UIView * linView = [UIView new];
            linView.backgroundColor = [UIColor lightGrayColor];
            [backView addSubview:linView];
            [linView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.bottom.right.equalTo(backView);
                make.height.mas_equalTo(0.5);
            }];
        }
        [self.contentView addSubview:backView];
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(kMyPadding);
            make.right.equalTo(self.contentView).offset(-kMyPadding);
            make.top.equalTo(self.contentView).offset(20);
            make.height.mas_equalTo(kIconHeight + kMyPadding);
            //            make.bottom.equalTo(self.contentView).offset(-30);
        }];
        {//titleLabel
            UILabel *label = [UILabel new];
            label.font = [UIFont systemFontOfSize:16];
            label.textAlignment = NSTextAlignmentLeft;
            label.numberOfLines = 1;
            [self.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(backView.mas_left);
                make.top.equalTo(backView).offset(kMyPadding/2);
                make.width.mas_equalTo(kScreen_Width - kIconHeight - kMyPadding *2);
                make.height.mas_equalTo(20);
            }];
            self.titleLabel = label;
        }
        {//biddingTimeLabel
            UILabel *label = [UILabel new];
            label.font = [UIFont systemFontOfSize:13];
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = [UIColor grayColor];
            label.numberOfLines = 1;
            [self.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(backView.mas_left);
                make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(kMyPadding/2);
                make.width.mas_equalTo((kScreen_Width - kMyPadding *2));
                make.height.mas_equalTo(20);
            }];
            self.biddingTimeLabel = label;
        }
        {//biddingTypeLabel
            UILabel *label = [UILabel new];
            label.font = [UIFont systemFontOfSize:13];
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = [UIColor grayColor];
            label.numberOfLines = 1;
            [self.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(backView.mas_left);
                make.top.mas_equalTo(self.biddingTimeLabel.mas_bottom).offset(kMyPadding/4);
                make.width.mas_equalTo((kScreen_Width - kIconHeight - kMyPadding *2)/2);
                make.height.mas_equalTo(20);
            }];
            self.biddingTypeLabel = label;
        }
        
        //BottomView
        UIView *bottomView = [UIView new];
        bottomView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(backView.mas_bottom);
            make.left.right.equalTo(backView);
            make.height.mas_equalTo(kBottomViewHeight);
        }];
        self.bottomView = bottomView;
        {
            UIButton *btn = [UIButton buttonWithMyStyleTitle:@"编辑"];
            btn.tag = 101232;
            [btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            [bottomView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(bottomView.mas_centerY);
                make.size.mas_equalTo(CGSizeMake(kBtnWidth, 20));
                make.right.mas_equalTo(bottomView.mas_right);
            }];
            self.editBtn = btn;
            
        }
        {
            UIButton *btn = [UIButton buttonWithMyStyleTitle:@"查看出价"];
            btn.tag = 101233;
            [btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            [bottomView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(bottomView.mas_centerY);
                make.size.mas_equalTo(CGSizeMake(kBtnWidth, 20));
                make.right.mas_equalTo(bottomView.mas_right).offset( - kBtnWidth - kMyPadding);
            }];
            self.leftBtn = btn;
        }
        {
            UIButton *btn = [UIButton buttonWithMyStyleTitle:@"成交结果"];
            btn.tag = 101234;
            [btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            [bottomView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(bottomView.mas_centerY);
                make.size.mas_equalTo(CGSizeMake(kBtnWidth, 20));
                make.right.mas_equalTo(bottomView.mas_right);
            }];
            self.rightBtn = btn;
        }
        UIView *grayView = [UIView new];
        grayView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:grayView];
        [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self.contentView);
            make.height.mas_equalTo(kBottomGrayViewHeight);
        }];
        
    }return self;
}

-(void)setBiddingProductM:(AddBiddingModel *)biddingProductM{
    _biddingProductM = biddingProductM;
    
    //场次编号
    self.serialNumberLabel.text = biddingProductM.tsTradeNo;
    //创建日期
    NSString *str = [NSString stringWithFormat:@"%@",biddingProductM.tsCreTime];
    self.createTimeLabel.text = ![NSObject isString:biddingProductM.tsCreTime]?@"创建日期:  暂无" : str;
    
    //标题
    self.titleLabel.text = biddingProductM.tsName;
    //竞价时间
    self.biddingTimeLabel.text = ![NSObject isString:biddingProductM.tsStartTime]? @"竞价时间:  暂无": [NSString stringWithFormat:@"竞价时间:  %@",biddingProductM.tsStartTime];
    //场次类型
    if ([biddingProductM.tsSiteType isEqualToString:@"0"]) {
        self.biddingTypeLabel.text = @"场次类型：单品";
    }else{
        self.biddingTypeLabel.text = @"场次类型：拼盘";
    }
    self.delBtn.hidden = YES;
    self.editBtn.hidden = YES;
    self.leftBtn.hidden = YES;
    self.rightBtn.hidden = YES;
    self.bottomView.hidden = NO;
    switch (self.myTradeSiteStatus) {
        case kMyTradeSiteStatus_WaitPublic:
        {
            self.delBtn.hidden = NO;

            [self.createTimeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.contentView).offset(-kMyPadding - kBtnWidth/3);
                make.top.equalTo(self.contentView);
                make.width.mas_equalTo(kScreen_Width/2);
                make.height.mas_equalTo(kTopLabelHeight);
            }];
            self.editBtn.hidden = NO;
            self.leftBtn.hidden = YES;
            self.rightBtn.hidden = YES;
//            [self.rightBtn setTitle:@"增加协议" forState:UIControlStateNormal];
        }
            break;
        case kMyTradeSiteStatus_PublicSuccess:
        {
            self.bottomView.hidden = YES;
        }
            break;
        case kMyTradeSiteStatus_BiddingNow:
        {
            self.editBtn.hidden = YES;
            self.leftBtn.hidden = YES;
            self.rightBtn.hidden = NO;
            [self.rightBtn setTitle:@"查看出价" forState:UIControlStateNormal];
        }
            break;
        case kMyTradeSiteStatus_WaitReciveMoney:
        {
            self.editBtn.hidden = YES;
            self.leftBtn.hidden = NO;
            self.rightBtn.hidden = NO;
            [self.leftBtn setTitle:@"查看出价" forState:UIControlStateNormal];
            [self.rightBtn setTitle:@"成交结果" forState:UIControlStateNormal];
        }
            break;
        case kMyTradeSiteStatus_WaitReciveProduct:
        {
            self.editBtn.hidden = YES;
            self.leftBtn.hidden = NO;
            self.rightBtn.hidden = NO;
            [self.leftBtn setTitle:@"查看出价" forState:UIControlStateNormal];
            [self.rightBtn setTitle:@"成交结果" forState:UIControlStateNormal];
        }
            break;
        case kMyTradeSiteStatus_BiddingSuccess:
        {
            self.editBtn.hidden = YES;
            self.leftBtn.hidden = YES;
            self.rightBtn.hidden = NO;
            [self.rightBtn setTitle:@"成交结果" forState:UIControlStateNormal];
        }
            break;
        case kMyTradeSiteStatus_Failure:
        {
            self.bottomView.hidden = YES;
            self.editBtn.hidden = YES;
            self.leftBtn.hidden = YES;
            self.rightBtn.hidden = YES;
        }
            break;
            
        default:
            break;
    }

}
-(void)actionBtn:(UIButton *)sender{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(btnOnCell:tag:)]) {
        [self.delegate btnOnCell:self tag:sender.tag];
    }
}
+(CGFloat)cellHeight{
    return (kIconHeight + kMyPadding + kTopLabelHeight + kBottomViewHeight + kBottomGrayViewHeight);
}

@end
