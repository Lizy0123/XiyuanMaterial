//
//  Record_JiaoyiliushuiTCell.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/4/16.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "Record_JiaoyiliushuiTCell.h"

@interface Record_JiaoyiliushuiTCell()
@property(strong, nonatomic)UILabel *titleLabel, *moneyLabel, *timeLabel;
@end

@implementation Record_JiaoyiliushuiTCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }return self;
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
