//
//  X_ShaiXuanTableViewCell.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/6/8.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "X_ShaiXuanTableViewCell.h"
#import "X_ShaiXuanModel.h"
@interface X_ShaiXuanTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic,strong)UIView *x_backView;

@property (nonatomic,strong)UIImageView *x_rightImage;

@end

@implementation X_ShaiXuanTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        self.x_backView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, S_W, 50)];
        self.x_backView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.x_backView];
        
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 10, S_W-100, 30)];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.x_backView addSubview:self.titleLabel];
        
        self.x_rightImage = [[UIImageView alloc]initWithFrame:CGRectMake(S_W-30, 16, 10, 16)];
        self.x_rightImage.image = [UIImage imageNamed:@"icon_rightImg"];
        [self.x_backView addSubview:self.x_rightImage];
        
    }
    
    return self;
    
    
}
-(void)setModel:(X_ShaiXuanModel *)model
{
    
    self.titleLabel.text = model.name;
   
    
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
