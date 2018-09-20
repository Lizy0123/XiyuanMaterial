//
//  X_JJDetailTwoTableViewCell.m
//  XYGPWuZi
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 xiaoRan. All rights reserved.
//

#import "X_JJDetailTwoTableViewCell.h"
#import "X_JJDetailTwoCellModel.h"

@interface X_JJDetailTwoTableViewCell ()


@property(nonatomic,strong)UILabel *bhLabel;
@property(nonatomic,strong)UILabel *mjhyLabel;
@property(nonatomic,strong)UILabel *cjmcLabel;
@property(nonatomic,strong)UILabel *jjDateLabel;
@property(nonatomic,strong)UILabel *cyfsLabel;
@property(nonatomic,strong)UILabel *jjTimeLabel;


@end


@implementation X_JJDetailTwoTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView *lineBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, S_W, 30)];
        lineBarView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:lineBarView];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 80, 30)];
        titleLabel.text = @"场次信息";
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont systemFontOfSize:14];
        [lineBarView addSubview:titleLabel];
        
        
     
        
        self.bhLabel = [[UILabel alloc]initWithFrame:CGRectMake(15+80+10, 0, S_W-95-15-10, 30)];
        self.bhLabel.textAlignment = NSTextAlignmentRight;
        self.bhLabel.textColor = [UIColor blackColor];
        self.bhLabel.font = [UIFont systemFontOfSize:14];
        
        [lineBarView addSubview:self.bhLabel];
        
        UILabel *bianhaoLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 30+10, 75, 20)];
        bianhaoLabel.textColor = [UIColor blackColor];
        bianhaoLabel.font = [UIFont systemFontOfSize:14];
        bianhaoLabel.text = @"卖家会员";
        [self.contentView addSubview:bianhaoLabel];

        self.mjhyLabel = [[UILabel alloc]initWithFrame:CGRectMake(15+75, 30+10, S_W-30-75, 20)];
        self.mjhyLabel.textColor = [UIColor blackColor];
        self.mjhyLabel.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:self.mjhyLabel];
        
        UILabel *ccNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 30+10+20+10, 75, 20)];
        ccNameLabel.textColor = [UIColor grayColor];
        ccNameLabel.font = [UIFont systemFontOfSize:14];
        ccNameLabel.text = @"场次名称";
        [self.contentView addSubview:ccNameLabel];
        
        
        self.cjmcLabel = [[UILabel alloc]initWithFrame:CGRectMake(15+75, 30+10+20+10, S_W-30-75, 20)];
        self.cjmcLabel.textColor = [UIColor blackColor];
        self.cjmcLabel.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:self.cjmcLabel];
        
        UILabel *jjrqLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 30+10+20+10+20+10, 75, 20)];
        jjrqLabel.textColor = [UIColor grayColor];
        jjrqLabel.font = [UIFont systemFontOfSize:14];
        jjrqLabel.text = @"竞价日期";
        [self.contentView addSubview:jjrqLabel];
        
        self.jjDateLabel = [[UILabel alloc]initWithFrame:CGRectMake(15+75, 30+10+20+10+20+10, S_W-30-75, 20)];
        self.jjDateLabel.textColor = [UIColor blackColor];
        self.jjDateLabel.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:self.jjDateLabel];
        
        UILabel *canyuLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 30+10+20+10+20+10+20+10, 75, 20)];
        canyuLabel.textColor = [UIColor grayColor];
        canyuLabel.font = [UIFont systemFontOfSize:14];
        canyuLabel.text = @"参与方式";
        [self.contentView addSubview:canyuLabel];
        
        self.cyfsLabel = [[UILabel alloc]initWithFrame:CGRectMake(15+75, 30+10+20+10+20+10+20+10, S_W-30-75, 20)];
        self.cyfsLabel.textColor = [UIColor blackColor];
        self.cyfsLabel.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:self.cyfsLabel];
        
        UILabel *jjtimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 30+10+20+10+20+10+20+10+20+10, 75, 20)];
        jjtimeLabel.textColor = [UIColor grayColor];
        jjtimeLabel.font = [UIFont systemFontOfSize:14];
        jjtimeLabel.text = @"竞价时间";
        [self.contentView addSubview:jjtimeLabel];
        
        self.jjTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(15+75, 30+10+20+10+20+10+20+10+20+10, S_W-30-75, 20)];
        self.jjTimeLabel.textColor = [UIColor blackColor];
        self.jjTimeLabel.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:self.jjTimeLabel];
        
        
                
    
    }
    
    return self;
}

-(void)setModel:(X_JJDetailTwoCellModel *)model{
    
  /*
   //拼盘&场次编号
   @property(nonatomic,copy)NSString *tsTradeNo;
   //卖家会员
   @property(nonatomic,copy)NSString *tnOwnerName;
   //场次名称
   @property(nonatomic,copy)NSString *tsName;
   //竞价日期
   @property(nonatomic,copy)NSString *tsTradeDate;
   //参与方式
   @property(nonatomic,copy)NSString *tsJoinType;
   //竞价开始时间
   @property(nonatomic,copy)NSString *tsStartTime;
   //竞价结束时间
   @property(nonatomic,copy)NSString *tsEndTime;
*/
    if (model.tsTradeNo == nil) {
        self.bhLabel.text = @"";
    }
    else{
        self.bhLabel.text = model.tsTradeNo;
    }
    if (model.tnOwnerName == nil) {
        self.mjhyLabel.text = @"暂无";
    }
    else{
        self.mjhyLabel.text = model.tnOwnerName;
    }
    if (model.tsName==nil) {
        
        self.cjmcLabel.text = @"暂无";
    }
    else{
        self.cjmcLabel.text = model.tsName;
    }
    if (model.tsTradeDate == nil) {
        
       self.jjDateLabel.text = @"暂无";
    }
    else{
        
        NSString *time = [model.tsTradeDate substringToIndex:10];
        
        self.jjDateLabel.text = time;
    }
    if (model.tsJoinType == nil) {
        
        self.cyfsLabel.text = @"暂无";
    }
    else{
        //0、不定向竞价 1、定向竞价
        if ([model.tsJoinType isEqualToString:@"0"]) {
            
            self.cyfsLabel.text = @"不定向竞价";
        }if ([model.tsJoinType isEqualToString:@"1"]) {
            
            self.cyfsLabel.text = @"定向竞价";
        }
        
    }
    if (model.tsStartTime == nil || model.tsEndTime == nil) {
        
        self.jjTimeLabel.text = @"暂无";
    }
    else{
        
        NSString *startTime = [model.tsStartTime substringFromIndex:11];
        NSString *endTime = [model.tsEndTime substringFromIndex:11];
        
        NSLog(@"------%@------%@",startTime,endTime);
        
        self.jjTimeLabel.text = [NSString stringWithFormat:@"%@-%@",startTime,endTime];
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
