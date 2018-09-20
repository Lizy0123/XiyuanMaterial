//
//  CengJiaoRecordTableViewCell.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/12/27.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "ChengJiaoRecordTableViewCell.h"
@interface ChengJiaoRecordTableViewCell ()
{
    UILabel *_priceLabel;
    UILabel *_titleLabel;
    UILabel *_timeLabel;
}
@end
@implementation ChengJiaoRecordTableViewCell


+(CGFloat)cellHeight{
    return 55;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kMyPadding, 5, (S_W-(kMyPadding *3))/2, 20)];
        [self.contentView addSubview:_titleLabel];
        
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(kMyPadding*2 + (S_W-(kMyPadding *3))/2, 5, (S_W-(kMyPadding *3))/2, 20)];
        [self.contentView addSubview:_priceLabel];
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(kMyPadding, 30, S_W-2 * kMyPadding, 20)];
        [self.contentView addSubview:_timeLabel];

        
    }
    return self;
}
-(void)showDataWithDic:(NSMutableDictionary *)dic{
    
    if (dic[@"bidNo"]) {
        _titleLabel.text = dic[@"bidNo"];
        
    }
    if (dic[@"tspMoney"]) {
        _priceLabel.text = [NSString stringWithFormat:@"%@元",[NSObject moneyStyle:dic[@"tspMoney"]]];
    }
    if (dic[@"tspBuyTime"]) {
        _timeLabel.text = dic[@"tspBuyTime"];
    }
 
    /*{
     tspMoney = "2500",
     tspBuyTime = "2017-12-26 15:26:20",
     bidNo = "10000256",
     }*/
}

@end
