//
//  ChaKanFanKuiViewController.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/9/25.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "ChaKanFanKuiViewController.h"

@interface ChaKanFanKuiViewController (){
    UIView *_backView;
    UILabel *_nameLabel;
    UILabel *_timeLabel;
    UILabel *_statusLabel;
    UILabel *_reasonLabel;
    
}
@end

@implementation ChaKanFanKuiViewController
-(id)init{
    if (self= [super init]) {
        [self createUI];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"查看反馈";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
}
#pragma mark - UI
-(void)createUI{
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, S_W, 160)];
    _backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_backView];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 80, 20)];
    label1.textColor = [UIColor blackColor];
    label1.textAlignment = NSTextAlignmentLeft;
    label1.font = [UIFont systemFontOfSize:14];
    label1.text = @"产品名称";
    [_backView addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(15, 10+40, 80, 20)];
    label2.textColor = [UIColor blackColor];
    label2.textAlignment = NSTextAlignmentLeft;
    label2.font = [UIFont systemFontOfSize:14];
    label2.text = @"提交时间";
    [_backView addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(15, 10+80, 80, 20)];
    label3.textColor = [UIColor blackColor];
    label3.textAlignment = NSTextAlignmentLeft;
    label3.font = [UIFont systemFontOfSize:14];
    label3.text = @"审核状态";
    [_backView addSubview:label3];
    
    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(15, 10+120, 80, 20)];
    label4.textColor = [UIColor blackColor];
    label4.textAlignment = NSTextAlignmentLeft;
    label4.font = [UIFont systemFontOfSize:14];
    label4.text = @"审核原因";
    [_backView addSubview:label4];
    
    for (int i = 1; i<4; i++) {
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 40*i, S_W, 0.3)];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_backView addSubview:line];
    }
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(S_W-165, 10, 150, 20)];
    _nameLabel.textColor = [UIColor grayColor];
    _nameLabel.textAlignment = NSTextAlignmentRight;
    _nameLabel.font = [UIFont systemFontOfSize:13];
    [_backView addSubview:_nameLabel];
    
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(S_W-165, 10+40, 150, 20)];
    _timeLabel.textColor = [UIColor grayColor];
    _timeLabel.textAlignment = NSTextAlignmentRight;
    _timeLabel.font = [UIFont systemFontOfSize:13];
    [_backView addSubview:_timeLabel];
    
    
    _statusLabel = [[UILabel alloc]initWithFrame:CGRectMake(S_W-165, 10+80, 150, 20)];
    _statusLabel.textColor = [UIColor grayColor];
    _statusLabel.textAlignment = NSTextAlignmentRight;
    _statusLabel.font = [UIFont systemFontOfSize:13];
    [_backView addSubview:_statusLabel];
    
    
    _reasonLabel = [[UILabel alloc]initWithFrame:CGRectMake(S_W-165, 10+120, 150, 20)];
    _reasonLabel.textColor = [UIColor grayColor];
    _reasonLabel.textAlignment = NSTextAlignmentRight;
    _reasonLabel.font = [UIFont systemFontOfSize:13];
    [_backView addSubview:_reasonLabel];
}
-(void)setProductName:(NSString *)productName{
    _productName = productName;
    _nameLabel.text = productName;
}
-(void)setAddTime:(NSString *)addTime{
    _addTime = addTime;
    _timeLabel.text = [_addTime substringToIndex:_addTime.length-9];
}
-(void)setStatus:(NSString *)status{
    
    _status = status;
    //0、待审核 1、已审核 2、未通过
    if ([_status isEqualToString:@"0"]) {
        _statusLabel.text = @"待审核";
    }
    if ([_status isEqualToString:@"1"]) {
        _statusLabel.text = @"已审核";
    }
    if ([_status isEqualToString:@"2"]) {
        _statusLabel.text = @"未通过";
    }
}
-(void)setReason:(NSString *)reason{
    _reason = reason;
    _reasonLabel.text = reason;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
