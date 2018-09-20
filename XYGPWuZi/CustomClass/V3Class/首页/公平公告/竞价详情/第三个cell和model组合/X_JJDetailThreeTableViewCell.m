//
//  X_JJDetailThreeTableViewCell.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/6/22.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "X_JJDetailThreeTableViewCell.h"
#import "X_JJDetailThreeCellModel.h"

@interface X_JJDetailThreeTableViewCell ()

@property(nonatomic,strong)UILabel *bhLabel;
@property(nonatomic,strong)UILabel *jjmsLabel;
@property(nonatomic,strong)UILabel *bpfsLabel;
@property(nonatomic,strong)UILabel *jjfsLabel;
@property(nonatomic,strong)UILabel *zlLabel;
@property(nonatomic,strong)UILabel *jjztLabel;

@property(nonatomic,strong)UILabel *qpjLabel;
@property(nonatomic,strong)UILabel *jjtdLabel;
@property(nonatomic,strong)UILabel *xsdjLabel;
@property(nonatomic,strong)UILabel *cjjgLabel;

@end

@implementation X_JJDetailThreeTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        UIView *lineBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, S_W, 30)];
        lineBarView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:lineBarView];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 80, 30)];
        titleLabel.text = @"拼盘信息";
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont systemFontOfSize:14];
        [lineBarView addSubview:titleLabel];
        
        self.bhLabel = [[UILabel alloc]initWithFrame:CGRectMake(15+80+10, 0, S_W-95-15-10, 30)];
        self.bhLabel.textAlignment = NSTextAlignmentRight;
        self.bhLabel.textColor = [UIColor blackColor];
        self.bhLabel.font = [UIFont systemFontOfSize:14];
        
        [lineBarView addSubview:self.bhLabel];
        
        
        UILabel *jingjiamsLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 30+10, 75, 20)];
        jingjiamsLabel.textColor = [UIColor grayColor];
        jingjiamsLabel.font = [UIFont systemFontOfSize:14];
        jingjiamsLabel.text = @"竞价模式";
        [self.contentView addSubview:jingjiamsLabel];
        
        self.jjmsLabel = [[UILabel alloc]initWithFrame:CGRectMake(15+75, 30+10, S_W-30-75, 20)];
        self.jjmsLabel.textColor = [UIColor blackColor];
        self.jjmsLabel.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:self.jjmsLabel];
        
        UILabel *baopanfsLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 30+10+20+10, 75, 20)];
        baopanfsLabel.textColor = [UIColor grayColor];
        baopanfsLabel.font = [UIFont systemFontOfSize:14];
        baopanfsLabel.text = @"报盘方式";
        [self.contentView addSubview:baopanfsLabel];
        
        self.bpfsLabel = [[UILabel alloc]initWithFrame:CGRectMake(15+75, 30+10+20+10, S_W-30-75, 20)];
        self.bpfsLabel.textColor = [UIColor blackColor];
        self.bpfsLabel.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:self.bpfsLabel];

        UILabel *jijiafsLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 30+10+20+10+20+10, 75, 20)];
        jijiafsLabel.textColor = [UIColor grayColor];
        jijiafsLabel.font = [UIFont systemFontOfSize:14];
        jijiafsLabel.text = @"计价方式";
        [self.contentView addSubview:jijiafsLabel];
        
        self.jjfsLabel = [[UILabel alloc]initWithFrame:CGRectMake(15+75, 30+10+20+10+20+10, S_W-30-75, 20)];
        self.jjfsLabel.textColor = [UIColor blackColor];
        self.jjfsLabel.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:self.jjfsLabel];
        
        UILabel *zongliangLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 30+10+20+10+20+10+20+10, 75, 20)];
        zongliangLabel.textColor = [UIColor grayColor];
        zongliangLabel.font = [UIFont systemFontOfSize:14];
        zongliangLabel.text = @"        总量";
        [self.contentView addSubview:zongliangLabel];
        
        self.zlLabel = [[UILabel alloc]initWithFrame:CGRectMake(15+75, 30+10+20+10+20+10+20+10, S_W-30-75, 20)];
        self.zlLabel.textColor = [UIColor blackColor];
        self.zlLabel.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:self.zlLabel];
        
        UILabel *label1 =  [[UILabel alloc]initWithFrame:CGRectMake(15, 30+10+20+10+20+10+20+10+20+10, 75, 20)];
        label1.textColor = [UIColor grayColor];
        label1.font = [UIFont systemFontOfSize:14];
        label1.text = @"    起拍价";
        [self.contentView addSubview:label1];

        self.qpjLabel = [[UILabel alloc]initWithFrame:CGRectMake(15+75, 30+10+20+10+20+10+20+10+20+10, S_W-30-75, 20)];
        self.qpjLabel.textColor = [UIColor blackColor];
        self.qpjLabel.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:self.qpjLabel];
        
        
 
        UILabel *label2 =  [[UILabel alloc]initWithFrame:CGRectMake(15, 30+10+20+10+20+10+20+10+20+10+20+10,75, 20)];
        label2.textColor = [UIColor grayColor];
        label2.font = [UIFont systemFontOfSize:14];
        label2.text = @"竞价梯度";
        [self.contentView addSubview:label2];

        self.jjtdLabel = [[UILabel alloc]initWithFrame:CGRectMake(15+75, 30+10+20+10+20+10+20+10+20+10+20+10, S_W-30-75, 20)];
        self.jjtdLabel.textColor = [UIColor blackColor];
        self.jjtdLabel.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:self.jjtdLabel];
        
        
        
        
        
        UILabel *label3 =  [[UILabel alloc]initWithFrame:CGRectMake(15, 30+10+20+10+20+10+20+10+20+10+20+10+20+10, 75, 20)];
        label3.textColor = [UIColor grayColor];
        label3.font = [UIFont systemFontOfSize:14];
        label3.text = @"保留价";
        [self.contentView addSubview:label3];

        self.xsdjLabel = [[UILabel alloc]initWithFrame:CGRectMake(15+75, 30+10+20+10+20+10+20+10+20+10+20+10+20+10, S_W-30-75, 20)];
        self.xsdjLabel.textColor = [UIColor blackColor];
        self.xsdjLabel.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:self.xsdjLabel];
        
        
        UILabel *label4 =  [[UILabel alloc]initWithFrame:CGRectMake(15, 30+10+20+10+20+10+20+10+20+10+20+10+20+10+20+10, 75, 20)];
        label4.textColor = [UIColor grayColor];
        label4.font = [UIFont systemFontOfSize:14];
        label4.text = @"成交价格";
        [self.contentView addSubview:label4];
        
        
        self.cjjgLabel = [[UILabel alloc]initWithFrame:CGRectMake(15+75, 30+10+20+10+20+10+20+10+20+10+20+10+20+10+20+10, S_W-30-75, 20)];
        self.cjjgLabel.textColor = [UIColor blackColor];
        self.cjjgLabel.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:self.cjjgLabel];
        
        
        
        
        
        
        
        
    }
    return self;
}


-(void)setModel:(X_JJDetailThreeCellModel *)model{
    
    if (model.tsTradeNo == nil) {
        
        self.bhLabel.text = @"";
    }else{
        self.bhLabel.text = model.tsTradeNo;
    }
    if (model.tnType == nil) {
        
        self.jjmsLabel.text = @"暂无";
    }else{
        //0、公开增价 1、 加权竞价 2、自由出价
        if ([model.tnType isEqualToString:@"0"]) {
            self.jjmsLabel.text = @"公开增价";
        }
        if ([model.tnType isEqualToString:@"1"]) {
            self.jjmsLabel.text = @"加权竞价";
        }
        if ([model.tnType isEqualToString:@"2"]) {
            self.jjmsLabel.text = @"自由出价";
        }
    
    }
    if (model.tsTradeType == nil) {
        
        self.bpfsLabel.text = @"暂无";
    }else{
        
        //0、单价报盘1、总价报盘
        if ([model.tsTradeType isEqualToString:@"0"]) {
            
            self.bpfsLabel.text = @"单价报盘";
        }
        if ([model.tsTradeType isEqualToString:@"1"]) {
            
            self.bpfsLabel.text = @"总价报盘";
        }
        
    }
    if (model.tsJjfs == nil) {
        
       self.jjfsLabel.text = @"暂无";
    }else{
        //0、重量计价1、数量计价
        if ([model.tsJjfs isEqualToString:@"0"]) {
            
            self.jjfsLabel.text = @"重量计价";
        }
        if ([model.tsJjfs isEqualToString:@"1"]) {
            
            self.jjfsLabel.text = @"数量计价";
        }
    }
    if (model.tsNum ==nil) {
        
       self.zlLabel.text = @"暂无";
    }else{
        self.zlLabel.text = model.tsNum;
    }
//    //0、否 1、是
//    if ([model.isEnd isEqualToString:@"0"]) {
//        if ([model.toBegin integerValue]>0) {
//
//           self.jjztLabel.text = @"即将开始";
//
//        }
//        if ([model.toBegin integerValue]<=0 && [model.onGoing integerValue]>0) {
//
//            self.jjztLabel.text = @"正在进行";
//        }
//
//
//        self.jjztLabel.text = @"竞价结束";
//    }
//    if ([model.isEnd isEqualToString:@"1"]) {
//
//        self.jjztLabel.text = @"竞价结束";
//    }
    
    if (model.tsMinPrice == nil) {
        //起拍价
        self.qpjLabel.text = @"暂无";
    }
    else{
        self.qpjLabel.text = [NSString stringWithFormat:@"%@ 元",[NSObject moneyStyle:model.tsMinPrice]];
        // 创建Attributed
        NSMutableAttributedString *noteStr1 = [[NSMutableAttributedString alloc] initWithString:self.qpjLabel.text];
        // 需要改变的区间
        NSRange range1 = NSMakeRange(0, noteStr1.length-1);
        // 改变颜色
        [noteStr1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range1];
        // 改变字体大小及类型
        [noteStr1 addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15 ] range:range1];
        // 为label添加Attributed
        [self.qpjLabel setAttributedText:noteStr1];

    }
    
    if (model.tsAddPrice == nil) {
        //竞价梯度
        self.jjtdLabel.text = @"暂无";
    }else{
        
        self.jjtdLabel.text = [NSString stringWithFormat:@"%@ 元",[NSObject moneyStyle:model.tsAddPrice]];
        // 创建Attributed
        NSMutableAttributedString *noteStr2 = [[NSMutableAttributedString alloc] initWithString:self.jjtdLabel.text];
        // 需要改变的区间
        NSRange range2 = NSMakeRange(0, noteStr2.length-1);
        // 改变颜色
        [noteStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range2];
        // 改变字体大小及类型
        [noteStr2 addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15 ] range:range2];
        // 为label添加Attributed
        [self.jjtdLabel setAttributedText:noteStr2];
        
    }
    
    if (model.tsProtectPrice == nil) {
        
        //销售底价
        self.xsdjLabel.text = @"无";
        
    }else{
        
        /*
        self.xsdjLabel.text = [NSString stringWithFormat:@"%@ 元",[NSObject moneyStyle:model.tsProtectPrice]];
        // 创建Attributed
        NSMutableAttributedString *noteStr3 = [[NSMutableAttributedString alloc] initWithString:self.xsdjLabel.text];
        // 需要改变的区间
        NSRange range3 = NSMakeRange(0, noteStr3.length-1);
        // 改变颜色
        [noteStr3 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range3];
        // 改变字体大小及类型
        [noteStr3 addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15 ] range:range3];
        // 为label添加Attributed
        [self.xsdjLabel setAttributedText:noteStr3];
        */
        self.xsdjLabel.text = @"有";
    }
    
    if (model.tsEndPrice == nil) {
        //成交价格
        self.cjjgLabel.text = @"暂无";
        
    }else{
        
        self.cjjgLabel.text =  [NSString stringWithFormat:@"%@ 元",[NSObject moneyStyle:model.tsEndPrice]];
        // 创建Attributed
        NSMutableAttributedString *noteStr4 = [[NSMutableAttributedString alloc] initWithString:self.cjjgLabel.text];
        // 需要改变的区间
        NSRange range4 = NSMakeRange(0, noteStr4.length-1);
        // 改变颜色
        [noteStr4 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range4];
        // 改变字体大小及类型
        [noteStr4 addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15 ] range:range4];
        // 为label添加Attributed
        [self.cjjgLabel setAttributedText:noteStr4];

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
