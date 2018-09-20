//
//  X_MProductTableViewCell.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/6/8.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "X_MProductTableViewCell.h"
#import "UIImageView+WebCache.h"
@interface X_MProductTableViewCell ()

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *timeLabel;


@end
@implementation X_MProductTableViewCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7.5, 85, 75)];
        [self.contentView addSubview:self.imageV];
 
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 7.5, S_W-100-20, 20)];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.titleLabel];
        
        self.addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 7.5+20+10, S_W-100-20, 20)];
        //self.addressLabel.textColor = [UIColor grayColor];
        self.addressLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.addressLabel];

        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 7.5+20+10+20+10, S_W-100-20, 15)];
        self.timeLabel.textColor = [UIColor grayColor];
        self.timeLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.timeLabel];
    }
    
    return self;
    
    
}

-(void)setModel:(ProductDetailModel *)model{
    if (model.picUrl) {
        NSString *picUrl = [myCDNUrl stringByAppendingString:model.picUrl];
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:picUrl] placeholderImage:[UIImage imageNamed:@"暂无图片"]];
    }
    self.titleLabel.text = model.piName;
//    if (model.piModtime) {
//        self.timeLabel.text = [model.piModtime substringToIndex:model.piModtime.length - 9];
//    }
    self.addressLabel.text = model.piAddress;
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
