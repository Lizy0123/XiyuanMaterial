//
//  Bidding_TitleValueTowTCell.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/3/21.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "Bidding_TitleValueTowTCell.h"
#import "TitleValueView_Tow.h"

@interface Bidding_TitleValueTowTCell ()

@end

@implementation Bidding_TitleValueTowTCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        NSMutableArray *titleArray = [NSMutableArray arrayWithObjects:@"保证金", @"延时机制", @"起拍价", @"数量", @"加价幅度", @"报盘模式", @"保留价", @"计价方式", @"成交提示", nil];
        NSMutableArray *ValueArray = [NSMutableArray arrayWithObjects:@"￥6000.00", @"3分钟/次", @"￥100.00", @"30吨", @"￥200.00", @"总价报盘", @"有", @"数量计价", @"成交价含税、含吊装、含运费", nil];
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, [TitleValueView_Tow viewHeight]*(int)ceil(titleArray.count / 2.0))];
        for (int i = 0; i<(int)ceil(titleArray.count / 2.0); i++ ) {
            TitleValueView_Tow *view = [[TitleValueView_Tow alloc] initWithFrame:CGRectMake(0, [TitleValueView_Tow viewHeight]*i, kScreen_Width, 44)];
            NSString *leftTitle = @"";
            NSString *leftValue = @"";
            NSString *rightTitle = @"";
            NSString *rightValue = @"";
            int intLeft = i*2;
            leftTitle = [titleArray objectAtIndex:intLeft];
            leftValue = [ValueArray objectAtIndex:intLeft];
            int intRight = i*2+1;
            if (!(intRight>=titleArray.count)) {
                rightTitle = [titleArray objectAtIndex:intRight];
                rightValue = [ValueArray objectAtIndex:intRight];
            }
            [view configTitleStrLeft:leftTitle ValueStrLeft:leftValue titleStrRight:rightTitle ValueStrRight:rightValue];
            [backView addSubview:view];
        }
        [self.contentView addSubview:backView];
        
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
