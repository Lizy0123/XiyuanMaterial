//
//  AuditTCell.m
//  XYGPWuZi
//
//  Created by Lzy on 2017/12/15.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//
#define kIconHeight 90
#define kTopLabelHeight 20
#define kBottomViewHeight 30
#define kBottomGrayViewHeight 10
#define kBtnWidth 70


#import "MyProductTCell.h"
#import "UIImageView+WebCache.h"

@interface MyProductTCell ()
@property(nonatomic, strong)UILabel *statusLabel, *timeLabel, *titleLabel, *brandLabel, *numberLabel, *typeLabel, *limitYearLabel;
@property(nonatomic, strong)UIView *bottomView;
@property(nonatomic, strong)UIImageView *icon;
@property(nonatomic, strong)UIButton *offShelBtn, *onShelBtn, *editBtn, *singleBiddingBtn, *multyBiddingBtn;

@end


@implementation MyProductTCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
        
        {//statusLabel
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
            self.statusLabel = label;
        }
        {//timeLabel
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
            self.timeLabel = label;
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
        {//iconImageView
            UIImageView *imageView = [[UIImageView alloc] init];
            [backView addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(kIconHeight, kIconHeight));
                make.top.equalTo(backView).offset(kMyPadding/2);
                make.left.equalTo(backView);
            }];
            self.icon = imageView;
        }
        {//titleLabel
            UILabel *label = [UILabel new];
            label.font = [UIFont systemFontOfSize:16];
            label.textAlignment = NSTextAlignmentLeft;
            label.numberOfLines = 1;
            [self.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.icon.mas_right).offset(kMyPadding/2);
                make.top.equalTo(backView).offset(kMyPadding/2);
                make.width.mas_equalTo(kScreen_Width - kIconHeight - kMyPadding *2);
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
                make.left.mas_equalTo(self.icon.mas_right).offset(kMyPadding/2);
                make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(kMyPadding/2);
                make.width.mas_equalTo((kScreen_Width - kIconHeight - kMyPadding *2)/2);
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
                make.left.mas_equalTo(self.icon.mas_right).offset(kMyPadding/2);
                make.top.mas_equalTo(self.brandLabel.mas_bottom).offset(kMyPadding/2);
                make.width.mas_equalTo((kScreen_Width - kIconHeight - kMyPadding *2)/2);
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
                make.width.mas_equalTo((kScreen_Width - kIconHeight - kMyPadding *2)/2);
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
                make.width.mas_equalTo((kScreen_Width - kIconHeight - kMyPadding *2)/2);
                make.height.mas_equalTo(20);
            }];
            self.limitYearLabel = label;
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
            UIButton *btn = [UIButton buttonWithMyStyleTitle:@"下架"];
            btn.tag = 101230;
            [btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            [bottomView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(bottomView.mas_centerY);
                make.size.mas_equalTo(CGSizeMake(kBtnWidth, 20));
                make.right.mas_equalTo(bottomView.mas_right);
            }];
            self.offShelBtn = btn;
        }
        {
            UIButton *btn = [UIButton buttonWithMyStyleTitle:@"寄售"];
            btn.tag = 101231;
            [btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            [bottomView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(bottomView.mas_centerY);
                make.size.mas_equalTo(CGSizeMake(kBtnWidth/2, 20));
                make.right.mas_equalTo(bottomView.mas_right).offset( - kBtnWidth *2 - kBtnWidth/2 - kMyPadding/2 *3 );
            }];
            self.onShelBtn = btn;
        }
        {
            UIButton *btn = [UIButton buttonWithMyStyleTitle:@"编辑"];
            btn.tag = 101232;
            [btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            [bottomView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(bottomView.mas_centerY);
                make.size.mas_equalTo(CGSizeMake(kBtnWidth/2, 20));
                make.right.mas_equalTo(bottomView.mas_right).offset( - kBtnWidth *2 - kMyPadding/2 *2 );
            }];
            self.editBtn = btn;

        }
        {
            UIButton *btn = [UIButton buttonWithMyStyleTitle:@""];
            btn.tag = 101233;
            [btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            [bottomView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(bottomView.mas_centerY);
                make.size.mas_equalTo(CGSizeMake(kBtnWidth, 20));
                make.right.mas_equalTo(bottomView.mas_right).offset( - kBtnWidth - kMyPadding/2 );
            }];
            self.singleBiddingBtn = btn;
        }
        {
            UIButton *btn = [UIButton buttonWithMyStyleTitle:@"加入拼盘"];
            btn.tag = 101234;
            [btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            [bottomView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(bottomView.mas_centerY);
                make.size.mas_equalTo(CGSizeMake(kBtnWidth, 20));
                make.right.mas_equalTo(bottomView.mas_right);
            }];
            self.multyBiddingBtn = btn;
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

-(void)setProductM:(MyProductModel *)productM{
    _productM = productM;
    self.onShelBtn.hidden = YES;
    self.editBtn.hidden = YES;
    self.singleBiddingBtn.hidden = YES;
    self.multyBiddingBtn.hidden = YES;
    self.offShelBtn.hidden = YES;
    
    //更新时间
    NSString *str = [NSString stringWithFormat:@"更新时间:  %@",productM.piModtime];
    self.timeLabel.text = ![NSObject isString:productM.piModtime]?@"更新时间:  暂无" : [str substringToIndex:[str length]-3];
    //商品图标
    NSString *url = [myCDNUrl stringByAppendingString:[NSString stringWithFormat:@"%@",productM.picUrl]];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:url]];
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
    if (self.myProductAuditStatus == kMyProductAuditStatus_ToDo) {
        self.bottomView.hidden = YES;
    }else{
        self.bottomView.hidden = NO;
        //状态
        if (self.myProductAuditStatus == kMyProductAuditStatus_Success) {
            if ([productM.piSj isEqualToString:@"0"]) {
                self.statusLabel.text = @"产品状态：已下架";
            }else{
                self.statusLabel.text = @"产品状态：已寄售";
            }
        }
        if (self.myProductAuditStatus == kMyProductAuditStatus_Success) {
            //底部按钮显隐
            if (!([productM.piNumber integerValue] >0)) {//产品数量为0
                self.onShelBtn.hidden = YES;
                self.singleBiddingBtn.hidden = YES;
                self.multyBiddingBtn.hidden = YES;
                self.offShelBtn.hidden = YES;
                
                self.editBtn.hidden = NO;
                [self.editBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(self.contentView.mas_right).offset(-kMyPadding);
                    make.size.mas_equalTo(CGSizeMake(kBtnWidth, 20));
                }];
            }
            else{//产品数量不为0
                //产品状态：已下架
                if ([productM.piSj isEqualToString:@"0"]) {
                    [self.editBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.right.mas_equalTo(self.contentView.mas_right).offset( - kMyPadding- kBtnWidth *2 - kMyPadding/2 *2 );
                        make.size.mas_equalTo(CGSizeMake(kBtnWidth/2, 20));
                    }];
                    self.editBtn.hidden = NO;
                    self.onShelBtn.hidden = NO;
                    self.singleBiddingBtn.hidden = NO;
                    [self.singleBiddingBtn setTitle:@"单品竞价" forState:UIControlStateNormal];
                    self.multyBiddingBtn.hidden = NO;
                    self.offShelBtn.hidden = YES;
                }
                //产品状态：已寄售
                else if([productM.piSj isEqualToString:@"1"]){
                    self.onShelBtn.hidden = YES;
                    self.editBtn.hidden = YES;
                    self.singleBiddingBtn.hidden = YES;
                    self.multyBiddingBtn.hidden = YES;
                    self.offShelBtn.hidden = NO;
                }
//                else{
//                    self.editBtn.hidden = NO;
//                    [self.editBtn mas_updateConstraints:^(MASConstraintMaker *make) {
//                        make.right.mas_equalTo(self.contentView.mas_right).offset(-kMyPadding);
//                        make.size.mas_equalTo(CGSizeMake(kBtnWidth, 20));
//                    }];
//                }
            }
        }else if (self.myProductAuditStatus == kMyProductAuditStatus_Reject){
            [self.editBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(self.contentView.mas_right).offset(-kMyPadding);
                make.size.mas_equalTo(CGSizeMake(kBtnWidth, 20));
            }];
            self.editBtn.hidden = NO;
            self.onShelBtn.hidden = YES;
            self.singleBiddingBtn.hidden = NO;
            [self.singleBiddingBtn setTitle:@"查看反馈" forState:UIControlStateNormal];
            self.multyBiddingBtn.hidden = YES;
            self.offShelBtn.hidden = YES;
        }
    }
}
-(void)actionBtn:(UIButton *)sender{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(btnOnCell:tag:)]) {
        [self.delegate btnOnCell:self tag:sender.tag];
        if (sender.tag == 101234) {
            if (_animationBtnClicked) {
                CGPoint point = [self convertPoint:_multyBiddingBtn.center toView:self.superview];
                _animationBtnClicked(_icon, point);
            }
        }
    }

}
+(CGFloat)cellHeight{
    return (kIconHeight + kMyPadding + kTopLabelHeight + kBottomViewHeight + kBottomGrayViewHeight);
}

@end
