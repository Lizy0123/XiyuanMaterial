//
//  XRChengJiaoTableViewCell.m
//  XYGPWuZi
//
//  Created by apple on 2017/10/19.
//  Copyright © 2017年 xiaoRan. All rights reserved.
//

#import "XRChengJiaoTableViewCell.h"
#import "XRChengJiaoModel.h"
#import "UIImageView+WebCache.h"

@interface XRChengJiaoTableViewCell ()


@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UIImageView *dealImageV;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *bianhaoLabel;
@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *dealPriceLabel;


@end

@implementation XRChengJiaoTableViewCell

+(CGFloat)cellHeight{
    
    return 125;
}


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        _imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 30, 85, 85)];
        [self.contentView addSubview:_imageV];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, S_W-20, 20)];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_titleLabel];
        
        _bianhaoLabel = [[UILabel alloc]initWithFrame:CGRectMake(115, 30, S_W-10-115, 15)];
        _bianhaoLabel.textColor = [UIColor grayColor];
        _bianhaoLabel.font = [UIFont systemFontOfSize:12];
        _bianhaoLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_bianhaoLabel];
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(115, 30+15+5, S_W-10-115, 15)];
        _timeLabel.textColor = [UIColor grayColor];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_timeLabel];
        
        _numLabel = [[UILabel alloc]initWithFrame:CGRectMake(115, 30+15+5+15+5, S_W-10-115, 15)];
        _numLabel.textColor = [UIColor grayColor];
        _numLabel.font = [UIFont systemFontOfSize:12];
        _numLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_numLabel];

        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(115, 30+15+5+15+5+15+10, 50, 20)];
        label1.text = @"成交价:";
        label1.textColor = [UIColor blackColor];
        label1.font = [UIFont boldSystemFontOfSize:14];
        [self.contentView addSubview:label1];
        
        
        _dealPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(115+50, 30+15+5+15+5+15+10, S_W-10-115-50, 20)];
        _dealPriceLabel.font = [UIFont boldSystemFontOfSize:14];
        _dealPriceLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_dealPriceLabel];
        
        
        
        _dealImageV = [[UIImageView alloc]initWithFrame:CGRectMake(S_W-15-95, 20, 95, 95)];
        _dealImageV.backgroundColor = [UIColor clearColor];
        _dealImageV.image = [UIImage imageNamed:@"dealImage"];
        [self.contentView addSubview:_dealImageV];
        
        
        
    }
    
    return self;
}



-(void)setModel:(XRChengJiaoModel *)model{
    
    if (model.tnPic) {
        
        NSString *picUrl = [picUrlHeader stringByAppendingString:model.tnPic];
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:picUrl] placeholderImage:[UIImage imageNamed:@"icon_defaultPic"]];
    }
    else{
        
        self.imageV.image = [UIImage imageNamed:@"icon_defaultPic"];
    }
    
    self.titleLabel.text = model.tsName;
    
    if (model.tsTradeNo) {
        
        _bianhaoLabel.text = [NSString stringWithFormat:@"场次编号: %@",model.tsTradeNo];
    }else{
        
        _bianhaoLabel.text = @"场次编号:";
    
    }
    if (model.tsEndTime) {
        _timeLabel.text = [NSString stringWithFormat:@"成交时间:  %@",model.tsEndTime];
    }else{
        
        _timeLabel.text = @"成交时间:";
    }
    
    if (model.tnNum) {
        
        _numLabel.text = [NSString stringWithFormat:@"数量:  %@",model.tnNum];
        if (model.tnUnits) {
            
            _numLabel.text = [NSString stringWithFormat:@"数量:  %@%@",model.tnNum,model.tnUnits];
        }
        
    }else{
        
        _numLabel.text = @"数量:";
    }
    
    
    if (model.tsEndPrice) {
        
        
        // 创建Attributed
        NSMutableAttributedString *noteStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ 元",[MyHelper moneyStyle:model.tsEndPrice]]];
        // 需要改变的区间
        NSRange range1 = NSMakeRange(0, noteStr1.length-1);
        // 改变颜色
        [noteStr1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:153/255.0 blue:102/255.0 alpha:1] range:range1];
        // 改变字体大小及类型
        [noteStr1 addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:20 ] range:range1];
        // 为label添加Attributed
        [self.dealPriceLabel setAttributedText:noteStr1];
        
        
        
        
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
