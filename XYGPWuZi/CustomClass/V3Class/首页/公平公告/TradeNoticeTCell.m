//
//  TradeNoticeTCell.m
//  XYGPWuZi
//
//  Created by Lzy on 2018/1/2.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "TradeNoticeTCell.h"
#import "UIImageView+WebCache.h"

@interface TradeNoticeTCell ()

@property (nonatomic, strong) UIImageView *titleImgV;
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UIImageView *rightImageV;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *moshiLabel;
@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *bzjLabel;
@property (nonatomic, strong) UILabel *baozhengjinLabel;

@end


@implementation TradeNoticeTCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        //self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        //  V2.0
        self.titleImgV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7.5, 15, 15)];
        [self.contentView addSubview:self.titleImgV];
        
        self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 30, 85, 85)];
        [self.contentView addSubview:self.imageV];
        
        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 5, S_W-85, 20)];
        self.timeLabel.font = [UIFont systemFontOfSize:13];
        self.timeLabel.textColor = [UIColor colorWithWhite:0 alpha:0.7];
        [self.contentView addSubview:self.timeLabel];
        
        self.rightImageV = [[UIImageView alloc] initWithFrame:CGRectMake(S_W-35, 5, 25, 35)];
        [self.contentView addSubview:self.rightImageV];
        
        
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(115, 30, S_W-115-35, 35)];
        self.titleLabel.numberOfLines = 0;
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [self.contentView addSubview:self.titleLabel];
        
        
        _moshiLabel = [[UILabel alloc]initWithFrame:CGRectMake(115, 30+35+5, (S_W-115-20)/2, 20)];
        _moshiLabel.font = [UIFont systemFontOfSize:13];
        _moshiLabel.textColor = [UIColor grayColor];
        
        [self.contentView addSubview:_moshiLabel];
        
        
        _numLabel = [[UILabel alloc]initWithFrame:CGRectMake(S_W-10-((S_W-115-20)/2), 30+35+5, (S_W-115-20)/2, 20)];
        _numLabel.font = [UIFont systemFontOfSize:13];
        _numLabel.textColor = [UIColor grayColor];
        
        [self.contentView addSubview:_numLabel];
        
        _bzjLabel = [[UILabel alloc]initWithFrame:CGRectMake(115, 30+35+5+25, 60, 20)];
        _bzjLabel.font = [UIFont boldSystemFontOfSize:14];
        _bzjLabel.textColor = [UIColor blackColor];
        
        [self.contentView addSubview:_bzjLabel];
        
        _baozhengjinLabel = [[UILabel alloc]initWithFrame:CGRectMake(115+60, 30+35+5+25, S_W-115-10-60, 20)];
        _baozhengjinLabel.font = [UIFont systemFontOfSize:13];
        _baozhengjinLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_baozhengjinLabel];
        
        
        /*V 1.0 */
        
        //        self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 85, 85)];
        //        [self.contentView addSubview:self.imageV];
        //
        //        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 5, S_W-110-20, 40)];
        //        self.titleLabel.numberOfLines = 0;
        //        _timeLabel.textAlignment = NSTextAlignmentLeft;
        //        self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        //        [self.contentView addSubview:self.titleLabel];
        //
        //        _baozhengjinLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 60, S_W-110-20, 20)];
        //        _baozhengjinLabel.font = [UIFont systemFontOfSize:13];
        //        _baozhengjinLabel.textColor = [UIColor blackColor];
        //        [self.contentView addSubview:_baozhengjinLabel];
        
        
    }
    
    return self;
    
    
}
+(CGFloat)cellHeight{
    
    
    return 125;
    //return 95;
}

-(void)setModel:(TradeNoticeModel *)model
{
    
    // 2.0
    
    self.titleImgV.image = [UIImage imageNamed:@"titleImage"];
    
    
    if (model.tnPic) {
        
        NSString *picUrl = [myCDNUrl stringByAppendingString:model.tnPic];
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:picUrl] placeholderImage:[UIImage imageNamed:@"icon_defaultPic"]];
    }
    else{
        
        self.imageV.image = [UIImage imageNamed:@"icon_defaultPic"];
    }
    
    self.timeLabel.text = [NSString stringWithFormat:@"时间:%@",model.tsStartTime];
    
    
    NSString *startTime = [model.tsStartTime substringToIndex:16];
    NSString *endTime = [model.tsEndTime substringToIndex:16];
    
    if (startTime && endTime) {
        
        self.timeLabel.text = [NSString stringWithFormat:@"%@--%@",startTime,endTime];
        
    }
    
    if ([model.tsStatus isEqualToString:@"0"]==YES) {
        
        self.rightImageV.image = [UIImage imageNamed:@"onGoing"];
        
    }else{
        
        self.rightImageV.image = [UIImage imageNamed:@"isComing"];
        
    }
    
    self.titleLabel.text = model.tnTitle;
    
    self.moshiLabel.text = @"模式：公开增价";
    
    if (model.tnNum && model.tnUnits) {
        
        self.numLabel.text = [NSString stringWithFormat:@"数量：%@%@",model.tnNum,model.tnUnits];
        
    }
    
    _bzjLabel.text = @"保证金：";
    
    if (model.tnDeposit) {
        
        
        // 创建Attributed
        NSMutableAttributedString *noteStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ 元",[NSObject moneyStyle:model.tnDeposit]]];
        // 需要改变的区间
        NSRange range1 = NSMakeRange(0, noteStr1.length-1);
        // 改变颜色
        [noteStr1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range1];
        // 改变字体大小及类型
        [noteStr1 addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:20 ] range:range1];
        // 为label添加Attributed
        [self.baozhengjinLabel setAttributedText:noteStr1];
        
        
        
        
    }
    //
    //    if (model.picUrl) {
    //
    //        NSString *picUrl = [myCDNUrl stringByAppendingString:model.picUrl];
    //        [self.imageV sd_setImageWithURL:[NSURL URLWithString:picUrl] placeholderImage:[UIImage imageNamed:@"icon_defaultPic"]];
    //    }
    //    else{
    //
    //        self.imageV.image = [UIImage imageNamed:@"icon_defaultPic"];
    //    }
    //    self.titleLabel.text = model.tnTitle;
    //
    //    if (model.tnTradeDate) {
    //
    //        _baozhengjinLabel.text = model.tnTradeDate;
    //
    //    }
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
