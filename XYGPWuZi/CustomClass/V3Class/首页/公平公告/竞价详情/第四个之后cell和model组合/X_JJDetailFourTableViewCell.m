//
//  X_JJDetailFourTableViewCell.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/6/27.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "X_JJDetailFourTableViewCell.h"
#import "X_JJDetailFourCellModel.h"


@interface X_JJDetailFourTableViewCell ()

@property(nonatomic,strong)UILabel *bhLabel;

@property(nonatomic,strong)UILabel *pmLabel;
@property(nonatomic,strong)UILabel *xhLabel;
@property(nonatomic,strong)UILabel *ggLabel;
@property(nonatomic,strong)UILabel *slLabel;
@property(nonatomic,strong)UILabel *zlLabel;
@property(nonatomic,strong)UILabel *cdLabel;
@property(nonatomic,strong)UILabel *xjcdLabel;
@property(nonatomic,strong)UILabel *kbhLabel;
@property(nonatomic,strong)UILabel *ckLabel;
@property(nonatomic,strong)UILabel *zyhLabel;

@end

@implementation X_JJDetailFourTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView *lineBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, S_W, 30)];
        lineBarView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:lineBarView];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 80, 30)];
        titleLabel.text = @"产品信息";
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont systemFontOfSize:14];
        [lineBarView addSubview:titleLabel];
        
        self.bhLabel = [[UILabel alloc]initWithFrame:CGRectMake(15+80+10, 0, S_W-15-80-10-15, 30)];
        self.bhLabel.textAlignment = NSTextAlignmentRight;
        self.bhLabel.textColor = [UIColor blackColor];
        self.bhLabel.font = [UIFont systemFontOfSize:14];
        
        [lineBarView addSubview:self.bhLabel];
        
        UILabel *pimingLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 30+10, 75, 20)];
        pimingLabel.textColor = [UIColor grayColor];
        pimingLabel.font = [UIFont systemFontOfSize:14];
        pimingLabel.text = @"        品名";
        [self.contentView addSubview:pimingLabel];
        
        self.pmLabel = [[UILabel alloc]initWithFrame:CGRectMake(15+75, 30+10, S_W-30-75, 20)];
        self.pmLabel.textColor = [UIColor blackColor];
        self.pmLabel.font = [UIFont systemFontOfSize:14];
        
        
        UILabel *xinghaoLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 30+10+20+10, 75, 20)];
        xinghaoLabel.textColor = [UIColor grayColor];
        xinghaoLabel.font = [UIFont systemFontOfSize:14];
        xinghaoLabel.text = @"        型号";
        [self.contentView addSubview:xinghaoLabel];
        
        [self.contentView addSubview:self.pmLabel];

        self.xhLabel = [[UILabel alloc]initWithFrame:CGRectMake(15+75, 30+10+20+10, S_W-30-75, 20)];
        self.xhLabel.textColor = [UIColor blackColor];
        self.xhLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.xhLabel];
        
        UILabel *guigeLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 30+10+20+10+20+10, 75, 20)];
        guigeLabel.textColor = [UIColor grayColor];
        guigeLabel.font = [UIFont systemFontOfSize:14];
        guigeLabel.text = @"        规格";
        [self.contentView addSubview:guigeLabel];
        
        self.ggLabel = [[UILabel alloc]initWithFrame:CGRectMake(15+75, 30+10+20+10+20+10, S_W-30-75, 20)];
        self.ggLabel.textColor = [UIColor blackColor];
        self.ggLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.ggLabel];
        
        
        UILabel *shuliangLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 30+10+20+10+20+10+20+10, 75, 20)];
        shuliangLabel.textColor = [UIColor grayColor];
        shuliangLabel.font = [UIFont systemFontOfSize:14];
        shuliangLabel.text = @"        数量";
        [self.contentView addSubview:shuliangLabel];
        
        self.slLabel = [[UILabel alloc]initWithFrame:CGRectMake(15+75, 30+10+20+10+20+10+20+10, S_W-30-75, 20)];
        self.slLabel.textColor = [UIColor blackColor];
        self.slLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.slLabel];

        
        UILabel *zhongliangLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 30+10+20+10+20+10+20+10+20+10, 75, 20)];
        zhongliangLabel.textColor = [UIColor grayColor];
        zhongliangLabel.font = [UIFont systemFontOfSize:14];
        zhongliangLabel.text = @"        重量";
        [self.contentView addSubview:zhongliangLabel];
        
        self.zlLabel = [[UILabel alloc]initWithFrame:CGRectMake(15+75, 30+10+20+10+20+10+20+10+20+10, S_W-30-75, 20)];
        self.zlLabel.textColor = [UIColor blackColor];
        self.zlLabel.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:self.zlLabel];
        
        
        UILabel *chandiLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 30+10+20+10+20+10+20+10+20+10+20+10, 75, 20)];
        chandiLabel.textColor = [UIColor grayColor];
        chandiLabel.font = [UIFont systemFontOfSize:14];
        chandiLabel.text = @"        产地";
        [self.contentView addSubview:chandiLabel];
        
        self.cdLabel = [[UILabel alloc]initWithFrame:CGRectMake(15+75, 30+10+20+10+20+10+20+10+20+10+20+10, S_W-30-75, 20)];
        self.cdLabel.textColor = [UIColor blackColor];
        self.cdLabel.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:self.cdLabel];
        
        
        UILabel *xinjiucdLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 30+10+20+10+20+10+20+10+20+10+20+10+20+10, 75, 20)];
        xinjiucdLabel.textColor = [UIColor grayColor];
        xinjiucdLabel.font = [UIFont systemFontOfSize:14];
        xinjiucdLabel.text = @"新旧程度";
        [self.contentView addSubview:xinjiucdLabel];
        
        self.xjcdLabel = [[UILabel alloc]initWithFrame:CGRectMake(15+75, 30+10+20+10+20+10+20+10+20+10+20+10+20+10, S_W-30-75, 20)];
        self.xjcdLabel.textColor = [UIColor blackColor];
        self.xjcdLabel.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:self.xjcdLabel];
        
        UILabel *kunbaohaoLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 30+10+20+10+20+10+20+10+20+10+20+10+20+10+20+10, 75, 20)];
        kunbaohaoLabel.textColor = [UIColor grayColor];
        kunbaohaoLabel.font = [UIFont systemFontOfSize:14];
        kunbaohaoLabel.text = @"    捆包号";
        [self.contentView addSubview:kunbaohaoLabel];
        
        self.kbhLabel = [[UILabel alloc]initWithFrame:CGRectMake(15+75, 30+10+20+10+20+10+20+10+20+10+20+10+20+10+20+10, S_W-30-75, 20)];
        self.kbhLabel.textColor = [UIColor blackColor];
        self.kbhLabel.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:self.kbhLabel];

        
        UILabel *cangkuLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 30+10+20+10+20+10+20+10+20+10+20+10+20+10+20+10+20+10, 75, 20)];
        cangkuLabel.textColor = [UIColor grayColor];
        cangkuLabel.font = [UIFont systemFontOfSize:14];
        cangkuLabel.text = @"        仓库";
        [self.contentView addSubview:cangkuLabel];
        
        self.ckLabel = [[UILabel alloc]initWithFrame:CGRectMake(15+75, 30+10+20+10+20+10+20+10+20+10+20+10+20+10+20+10+20+10, S_W-30-75, 20)];
        self.ckLabel.textColor = [UIColor blackColor];
        self.ckLabel.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:self.ckLabel];
        
        UILabel *ziyuanhaoLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 30+10+20+10+20+10+20+10+20+10+20+10+20+10+20+10+20+10+20+10, 75, 20)];
        ziyuanhaoLabel.textColor = [UIColor grayColor];
        ziyuanhaoLabel.font = [UIFont systemFontOfSize:14];
        ziyuanhaoLabel.text = @"    资源号";
        [self.contentView addSubview:ziyuanhaoLabel];
        
        self.zyhLabel = [[UILabel alloc]initWithFrame:CGRectMake(15+75, 30+10+20+10+20+10+20+10+20+10+20+10+20+10+20+10+20+10+20+10, S_W-30-75, 20)];
        self.zyhLabel.textColor = [UIColor blackColor];
        self.zyhLabel.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:self.zyhLabel];
        
        
        
        
    }
    
    
    
    return self;
    
    
}

-(void)setModel:(X_JJDetailFourCellModel *)model{
    
    if (model.piCode == nil) {
        self.bhLabel.text = @"";
    }else{
        self.bhLabel.text = model.piCode;
    }
    if (model.piName == nil) {
        self.pmLabel.text = @"暂无";
    }else{
        self.pmLabel.text = model.piName;
    }
    if (model.piCpxh == nil) {
        self.xhLabel.text = @"暂无";
    }else{
        self.xhLabel.text = model.piCpxh;
    }
    if (model.piCcgg == nil) {
        self.ggLabel.text = @"暂无";
    }else{
        self.ggLabel.text = model.piCcgg;
    }
    if (model.pNum == nil) {
        self.slLabel.text = @"暂无";
    }else{
        self.slLabel.text = model.pNum;
    }
    if (model.pWeight == nil) {
        self.zlLabel.text = @"暂无";
    }else{
        self.zlLabel.text = model.pWeight;
    }
    if (model.piCpcd == nil) {
        self.cdLabel.text = @"暂无";
    }else{
        self.cdLabel.text = model.piCpcd;
    }
    if (model.piXjcd == nil) {
        self.xjcdLabel.text = @"暂无";
        
    }else{
        self.xjcdLabel.text = model.piXjcd;
    }
    if (model.piKbh == nil) {
        self.kbhLabel.text = @"暂无";
    
    }else{
        self.kbhLabel.text = model.piKbh;
    }
    if (model.piWarehouse == nil) {
        self.ckLabel.text = @"暂无";
    }else{
        self.ckLabel.text = model.piWarehouse;
    }
    if (model.piZyh == nil) {
        
        self.zyhLabel.text = @"暂无";
    }else{
        self.zyhLabel.text = model.piZyh;
    }
    
    
    /*
     
     piName：品名 |
     piWarehouse：仓库|
     piXjcd：新旧程度 |
     piCpxh：产品型号 |
     piCpcd：产品产地 |
     piCode：产品编号 |
     pNum：产品数量 |
     pWeight：产品重量 |
     piKbh：捆包号 |
     piCcgg：产品规格 |
     piZyh：资源号
     
     */

    
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
