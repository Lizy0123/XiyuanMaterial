//
//  X_JJDetailOneTableViewCell.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/6/14.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "X_JJDetailOneTableViewCell.h"
#import "X_JJDetailOneCellModel.h"


@interface X_JJDetailOneTableViewCell ()


@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *fBTimeLabel;
@property(nonatomic,strong)UILabel *cCbhLabel;
@property(nonatomic,strong)UILabel *numberLabel;
@property(nonatomic,strong)UILabel *weightLabel;
@property(nonatomic,strong)UILabel *jjTimeLabel;
@property(nonatomic,strong)UILabel *jjTypeLabel;
@property(nonatomic,strong)UILabel *yanShiLabel;
@property(nonatomic,strong)UILabel *huiYuanTypeLabel;
@property(nonatomic,strong)UILabel *bljLabel;
@property(nonatomic,strong)UILabel *jjLiuChengLabel;
@property(nonatomic,strong)UIImageView *lcImageView;
//成交结果按钮
@property(nonatomic,strong)UIButton *chuJiaRecordBtn;
//资源详情label
@property(nonatomic,strong)UILabel *detailInfoLabel;

@end


@implementation X_JJDetailOneTableViewCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
   
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, S_W-20, 20)];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        //self.titleLabel.font = [UIFont fontWithName:@ "Arial Rounded MT Bold"  size:(15.0)];
        [self.contentView addSubview:self.titleLabel];
        
        self.fBTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10+20+10, S_W-20, 20)];
        self.fBTimeLabel.font = [UIFont systemFontOfSize:14];
        self.fBTimeLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.fBTimeLabel];
        
        self.cCbhLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10+20+10+20+5, S_W-20, 20)];
        self.cCbhLabel.font = [UIFont systemFontOfSize:14];
        self.cCbhLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.cCbhLabel];
        
        UILabel *lineLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(5, 10+20+10+20+5+40, S_W-10, 0.1)];
        lineLabel1.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:lineLabel1];
        
        UILabel *numLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10+20+10+20+5+40+10, 30, 20)];
        numLabel.font = [UIFont systemFontOfSize:14];
        numLabel.textColor = [UIColor grayColor];
        numLabel.text = @"数量";
        [self.contentView addSubview:numLabel];
        
        
        self.numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(15+30, 10+20+10+20+5+40+10, (S_W-30-60)/2, 20)];
        self.numberLabel.font = [UIFont systemFontOfSize:14];
        self.numberLabel.textColor = [UIColor blackColor];
        self.numberLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.numberLabel];
        
        
        UILabel *wtLabel = [[UILabel alloc]initWithFrame:CGRectMake(15+30+(S_W-30-60)/2, 10+20+10+20+5+40+10, 30, 20)];
        wtLabel.font = [UIFont systemFontOfSize:14];
        wtLabel.textColor = [UIColor grayColor];
        wtLabel.text = @"重量";
        [self.contentView addSubview:wtLabel];
        
        self.weightLabel = [[UILabel alloc]initWithFrame:CGRectMake(15+60+(S_W-30-60)/2, 10+20+10+20+5+40+10, (S_W-30-60)/2, 20)];
        self.weightLabel.font = [UIFont systemFontOfSize:14];
        self.weightLabel.textColor = [UIColor blackColor];
        self.weightLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.weightLabel];
        
        UILabel *lineLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(5, 10+20+10+20+5+40+40, S_W-10, 0.1)];
        lineLabel2.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:lineLabel2];
        
        
        self.jjTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10+20+10+20+5+40+40+10, S_W-20, 20)];
        self.jjTimeLabel.font = [UIFont systemFontOfSize:14];
        self.jjTimeLabel.textColor = [UIColor blackColor];
        
        [self.contentView addSubview:self.jjTimeLabel];
        
        UILabel *msLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10+20+10+20+5+40+40+10+20+10, 75, 20)];
        msLabel.font = [UIFont systemFontOfSize:14];
        msLabel.textColor = [UIColor grayColor];
        msLabel.text = @"竞价模式";
        [self.contentView addSubview:msLabel];
        
        self.jjTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(15+75, 10+20+10+20+5+40+40+10+20+10, S_W-30-75, 20)];
        self.jjTypeLabel.font = [UIFont systemFontOfSize:14];
        self.jjTypeLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.jjTypeLabel];
        
        UILabel *hytypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10+20+10+20+5+40+40+10+20+10+20+10, 75, 20)];
        hytypeLabel.font = [UIFont systemFontOfSize:14];
        hytypeLabel.textColor = [UIColor grayColor];
        hytypeLabel.text = @"会员属性";
        [self.contentView addSubview:hytypeLabel];
        
        self.huiYuanTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(15+75, 10+20+10+20+5+40+40+10+20+10+20+10, S_W-30-75, 20)];
        self.huiYuanTypeLabel.font = [UIFont systemFontOfSize:14];
        self.huiYuanTypeLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.huiYuanTypeLabel];
        
        UILabel *ysLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10+20+10+20+5+40+40+10+20+10+20+10+20+10, 75, 20)];
        ysLabel.font = [UIFont systemFontOfSize:14];
        ysLabel.textColor = [UIColor grayColor];
        ysLabel.text = @"延时机制";
        [self.contentView addSubview:ysLabel];
        
        self.yanShiLabel = [[UILabel alloc]initWithFrame:CGRectMake(15+75, 10+20+10+20+5+40+40+10+20+10+20+10+20+10, S_W-15-75-60-60-15, 20)];
        self.yanShiLabel.font = [UIFont systemFontOfSize:14];
        self.yanShiLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.yanShiLabel];
        
        
        UILabel *lineLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(5, 10+20+10+20+5+40+40+10+20+10+20+10+20+10+30, S_W-10, 0.1)];
        lineLabel3.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:lineLabel3];
        
        self.jjLiuChengLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10+20+10+20+5+40+40+10+20+10+20+10+20+10+20+20, S_W-30, 20)];
        self.jjLiuChengLabel.font = [UIFont boldSystemFontOfSize:15];
        self.jjLiuChengLabel.text = @"竞价流程";
        [self.contentView addSubview:self.jjLiuChengLabel];

        
        self.lcImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10+20+10+20+5+40+40+10+20+10+20+10+20+10+20+20+20+10, S_W-30, S_W/5)];
        self.lcImageView.image = [UIImage imageNamed:@"jjlcImage"];
        [self.contentView addSubview:self.lcImageView];
        
        UILabel *lineLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(5, 10+20+10+20+5+40+40+10+20+10+20+10+20+10+20+20+20+10+(S_W/5)+10, S_W-10, 0.1)];
        lineLabel4.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:lineLabel4];
        
 
        UILabel *lineLabel5 = [[UILabel alloc]initWithFrame:CGRectMake(5, 10+20+10+20+5+40+40+10+20+10+20+10+20+10+20+20+20+10+(S_W/5)+10+40, S_W-10, 0.1)];
        lineLabel5.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:lineLabel5];
        
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame = CGRectMake(5, 10+20+10+20+5+40+40+10+20+10+20+10+20+10+20+20+20+10+(S_W/5)+10+1, S_W-10, 38);
        [btn2 setTitle:@"竞价服务协议" forState:UIControlStateNormal];
        btn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn2.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        btn2.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn2 addTarget:self action:@selector(jumpToNextVC:) forControlEvents:UIControlEventTouchUpInside];
        btn2.tag = 0;
        [self.contentView addSubview:btn2];
        
        UIImageView *image2 = [[UIImageView alloc]initWithFrame:CGRectMake(btn2.frame.size.width-20, 9, 10, 20)];
        image2.image = [UIImage imageNamed:@"icon_rightImg"];
        [btn2 addSubview:image2];
        
        UILabel *lineLabel6 = [[UILabel alloc]initWithFrame:CGRectMake(5, 10+20+10+20+5+40+40+10+20+10+20+10+20+10+20+20+20+10+(S_W/5)+10+80, S_W-10, 0.1)];
        lineLabel6.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:lineLabel6];
       
        
        UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn3.frame = CGRectMake(5, 10+20+10+20+5+40+40+10+20+10+20+10+20+10+20+20+20+10+(S_W/5)+10+40+1, S_W-10, 38);
        [btn3 setTitle:@"竞价公告" forState:UIControlStateNormal];
        btn3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn3.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        btn3.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn3 addTarget:self action:@selector(jumpToNextVC:) forControlEvents:UIControlEventTouchUpInside];
        btn3.tag = 1;
        [self.contentView addSubview:btn3];
        
        UIImageView *image3 = [[UIImageView alloc]initWithFrame:CGRectMake(btn3.frame.size.width-20, 9, 10, 20)];
        image3.image = [UIImage imageNamed:@"icon_rightImg"];
        
        [btn3 addSubview:image3];
        {
        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 10+20+10+20+5+40+40+10+20+10+20+10+20+10+20+20+20+10+(S_W/5)+10+80+40, S_W-10, 0.1)];
        lineLabel.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:lineLabel];
        
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(5, 10+20+10+20+5+40+40+10+20+10+20+10+20+10+20+20+20+10+(S_W/5)+10+40+40+1, S_W-10, 38);
        [btn setTitle:@"瑕疵免责声明" forState:UIControlStateNormal];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(jumpToNextVC:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 2;
        [self.contentView addSubview:btn];
        
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(btn3.frame.size.width-20, 9, 10, 20)];
        image.image = [UIImage imageNamed:@"icon_rightImg"];
        [btn addSubview:image];
        }
        {
            UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 10+20+10+20+5+40+40+10+20+10+20+10+20+10+20+20+20+10+(S_W/5)+10+80+40+40, S_W-10, 0.1)];
            lineLabel.backgroundColor = [UIColor blackColor];
            [self.contentView addSubview:lineLabel];
            
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(5, 10+20+10+20+5+40+40+10+20+10+20+10+20+10+20+20+20+10+(S_W/5)+10+40+40+40+1, S_W-10, 38);
            [btn setTitle:@"拍卖规则" forState:UIControlStateNormal];
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            btn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(jumpToNextVC:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 3;
            [self.contentView addSubview:btn];
            
            UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(btn3.frame.size.width-20, 9, 10, 20)];
            image.image = [UIImage imageNamed:@"icon_rightImg"];
            [btn addSubview:image];
        }
        
        {
            _chuJiaRecordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _chuJiaRecordBtn.frame = CGRectMake(5, 10+20+10+20+5+40+40+10+20+10+20+10+20+10+20+20+20+10+(S_W/5)+10+40+40+40+1+40, S_W-10, 38);
            [_chuJiaRecordBtn setTitle:@"出价记录" forState:UIControlStateNormal];
            _chuJiaRecordBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            _chuJiaRecordBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            _chuJiaRecordBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
            [_chuJiaRecordBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_chuJiaRecordBtn addTarget:self action:@selector(jumpToNextVC:) forControlEvents:UIControlEventTouchUpInside];
            _chuJiaRecordBtn.tag = 4;
            [self.contentView addSubview:_chuJiaRecordBtn];
            
            UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(btn3.frame.size.width-20, 9, 10, 20)];
            image.image = [UIImage imageNamed:@"icon_rightImg"];
            [_chuJiaRecordBtn addSubview:image];
            
            UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,39,S_W-10, 0.1)];
            lineLabel.backgroundColor = [UIColor blackColor];
            [_chuJiaRecordBtn addSubview:lineLabel];
            
            
            
        }
        _detailInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10+20+10+20+5+40+40+10+20+10+20+10+20+10+20+20+20+10+(S_W/5)+10+80+40+40+40, S_W-30, 40)];
        _detailInfoLabel.text = @"资源详情";
        _detailInfoLabel.font = [UIFont boldSystemFontOfSize:15];
        [self.contentView addSubview:_detailInfoLabel];
        
        
        
        
    }
    
    return self;
    
    
}

-(void)setCellType:(detailOneCellType)cellType{
    _cellType = cellType;
    switch (cellType) {
        case detailOneCellTypeDefault:
            {
                _chuJiaRecordBtn.hidden = YES;
                _detailInfoLabel.frame = CGRectMake(15, 10+20+10+20+5+40+40+10+20+10+20+10+20+10+20+20+20+10+(S_W/5)+10+80+40+40, S_W-30, 40);
            }
            break;
        case detailOneCellTypeChengJiaoAnLiCell:
            {
                _chuJiaRecordBtn.hidden = NO;
            }
            break;
        default:
            break;
    }
}
-(void)setModel:(X_JJDetailOneCellModel *)model{
    
    self.titleLabel.text = model.tnTitle;
    
    if (model.tnCreTime == nil) {
       self.fBTimeLabel.text = @"发布时间    暂无";
        
    }else{
        self.fBTimeLabel.text = [NSString stringWithFormat:@"发布时间    %@",model.tnCreTime];
    }
    if (model.tsTradeNo == nil) {
        self.cCbhLabel.text = @"场次编号    暂无";
    }else{
        self.cCbhLabel.text = [NSString stringWithFormat:@"场次编号    %@",model.tsTradeNo];
    }
    if (model.tnNum == nil) {
        
        self.numberLabel.text = @"暂无";
    }
    else{
        self.numberLabel.text = model.tnNum;
        
    }
    if (model.tnWeigth == nil) {
        self.weightLabel.text = @"暂无";
    }
    else
    {
        self.weightLabel.text = model.tnWeigth;
    }
    if (model.tnTradeDate == nil) {
        self.jjTimeLabel.text = @"竞价时间     暂无";
    }
    else{
        self.jjTimeLabel.text = [NSString stringWithFormat:@"竞价时间    %@",model.tnTradeDate];
    }
    if (model.tnType == nil) {
        self.jjTypeLabel.text = @"暂无";
    }
    else{
        //0、公开增价 1、 加权竞价 2、自由出价
        if ([model.tnType isEqualToString:@"0"]) {
            self.jjTypeLabel.text = @"公开增价";
        }
        if ([model.tnType isEqualToString:@"1"]) {
            self.jjTypeLabel.text = @"加权竞价";
        }
        if ([model.tnType isEqualToString:@"2"]) {
            self.jjTypeLabel.text = @"自由出价";
        }
        
        
    }
    if (model.tnUserType == nil) {
        
       self.huiYuanTypeLabel.text = @"暂无";
    }
    else{
        //0、只限企业 1、只限个人 2、都可以
        if ([model.tnUserType isEqualToString:@"0"]) {
            
           self.huiYuanTypeLabel.text = @"只限企业";
        }
        if ([model.tnUserType isEqualToString:@"1"]) {
            
            self.huiYuanTypeLabel.text = @"只限个人";
        }
        if ([model.tnUserType isEqualToString:@"2"]) {
            
            self.huiYuanTypeLabel.text = @"企业个人均可";
        }
    }
    if (model.tnYyjz == nil) {
         self.yanShiLabel.text = @"暂无";
    }
    else{
        self.yanShiLabel.text = model.tnYyjz;
    }
   
    
    
}


-(void)jumpToNextVC:(UIButton *)button{
    
    
    if ([self.delegatee respondsToSelector:@selector(pushVcWithBtnTag:)]) {
    
        
        [self.delegatee pushVcWithBtnTag:button.tag];
        
    }
   
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
