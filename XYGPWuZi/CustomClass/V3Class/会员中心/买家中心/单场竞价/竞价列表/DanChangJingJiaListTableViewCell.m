//
//  DanChangJingJiaListTableViewCell.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/1/4.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "DanChangJingJiaListTableViewCell.h"
#import "DanChangJingJiaListModel.h"
@interface DanChangJingJiaListTableViewCell ()
{
    //白色背景view
    UIView *_backgroundView;
    //编号label
    UILabel *_bianHaoLabel;
    //标题label
    UILabel *_titleLabel;
    //时间label
    UILabel *_timeLabel;
    //场次类型label
    UILabel *_typeLabel;
    //保证金文字label
    UILabel *_baozhengjinLabel;
    //保证金数字label
    UILabel *_bzjLabel;
    //竞拍编号label
    UILabel *_jingPaiBianHaoLabel;
    //流拍失败还是成功
    UILabel *_statusLabel;
    //底部按钮最多有两个,用两个代替全部,用tag区分
    UIButton *_bottomLeftBtn;
    UIButton *_bottomRightBtn;
    //两根分割线
    UIView *_topLine;
    UIView *_bottomLine;
}

@end


@implementation DanChangJingJiaListTableViewCell

+(CGFloat)cellHightWithListStatus:(kMyJingJingListStatus)kMyJingJingListStatus{
    
    if (kMyJingJingListStatus == kMyJingJingListStatusYiBaoMing) {
        return 160;
    }
    else{
        return 180;
    }
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self layoutCell];
    }
    return self;
}
-(void)layoutCell{
    
    _backgroundView = [[UIView alloc]init];
    _backgroundView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_backgroundView];
    
    _bianHaoLabel = [[UILabel alloc]init];
    _bianHaoLabel.textColor = [UIColor blackColor];
    _bianHaoLabel.font = [UIFont systemFontOfSize:13];
    [_backgroundView addSubview:_bianHaoLabel];
    
    _statusLabel = [[UILabel alloc]init];
    _statusLabel.font = [UIFont systemFontOfSize:13];
    _statusLabel.textAlignment = NSTextAlignmentCenter;
    [_backgroundView addSubview:_statusLabel];
    
    _topLine = [[UIView alloc]init];
    _topLine.backgroundColor = [UIColor grayColor];
    _topLine.alpha = 0.5;
    [_backgroundView addSubview:_topLine];
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [_backgroundView addSubview:_titleLabel];
    
    _jingPaiBianHaoLabel = [[UILabel alloc]init];
    _jingPaiBianHaoLabel.textColor = [UIColor blackColor];
    _jingPaiBianHaoLabel.font = [UIFont systemFontOfSize:13];
    [_backgroundView addSubview:_jingPaiBianHaoLabel];
    
    _timeLabel = [[UILabel alloc]init];
    _timeLabel.textColor = [UIColor blackColor];
    _timeLabel.font = [UIFont systemFontOfSize:13];
    [_backgroundView addSubview:_timeLabel];
    
    _typeLabel = [[UILabel alloc]init];
    _typeLabel.textColor = [UIColor blackColor];
    _typeLabel.font = [UIFont systemFontOfSize:13];
    [_backgroundView addSubview:_typeLabel];
    
    _bottomLine = [[UIView alloc]init];
    _bottomLine.backgroundColor = [UIColor grayColor];
    _bottomLine.alpha = 0.5;
    [_backgroundView addSubview:_bottomLine];
    
    _baozhengjinLabel = [[UILabel alloc]init];
    _baozhengjinLabel.textColor = [UIColor blackColor];
    _baozhengjinLabel.font = [UIFont systemFontOfSize:13];
    _baozhengjinLabel.text = @"保证金:  ";
    [_backgroundView addSubview:_baozhengjinLabel];
    
    _bzjLabel = [[UILabel alloc]init];
    _bzjLabel.textColor = [UIColor blackColor];
    _bzjLabel.font = [UIFont systemFontOfSize:13];
    [_backgroundView addSubview:_bzjLabel];
    
    
    _bottomLeftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _bottomLeftBtn.tag = 1;
    [_bottomLeftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _bottomLeftBtn.layer.masksToBounds = YES;
    _bottomLeftBtn.layer.cornerRadius = 5.0f;
    _bottomLeftBtn.backgroundColor = kColorNav;
    _bottomLeftBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_bottomLeftBtn setBackgroundImage:[UIImage imageWithColor:[UIColor grayColor]] forState:UIControlStateDisabled];
    [_bottomLeftBtn addTarget:self action:@selector(btnclicked:) forControlEvents:UIControlEventTouchUpInside];
    [_backgroundView addSubview:_bottomLeftBtn];
    
    _bottomRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _bottomRightBtn.tag = 2;
    [_bottomRightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _bottomRightBtn.layer.masksToBounds = YES;
    _bottomRightBtn.layer.cornerRadius = 5.0f;
    _bottomRightBtn.backgroundColor = kColorNav;
    _bottomRightBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_bottomRightBtn addTarget:self action:@selector(btnclicked:) forControlEvents:UIControlEventTouchUpInside];
    [_backgroundView addSubview:_bottomRightBtn];
    
    
}
-(void)setMyJingJiaListStatus:(kMyJingJingListStatus)myJingJiaListStatus{
    
    _myJingJiaListStatus = myJingJiaListStatus;
    
    if (myJingJiaListStatus == kMyJingJingListStatusYiBaoMing) {
        
        [_jingPaiBianHaoLabel setHidden:YES];
        _backgroundView.frame = CGRectMake(0, 0, S_W, 150);
        _bianHaoLabel.frame = CGRectMake(10, 5, S_W-20, 20);
        _topLine.frame = CGRectMake(10, 25, S_W-20, 0.3);
        _titleLabel.frame = CGRectMake(10, 35, S_W-20, 20);
        _timeLabel.frame = CGRectMake(10, 65, S_W-20, 20);
        _typeLabel.frame = CGRectMake(10, 90, S_W-20, 20);
        _bottomLine.frame = CGRectMake(10, 115, S_W-20, 0.3);
        _baozhengjinLabel.frame = CGRectMake(10, 120, 50, 20);
        _bzjLabel.frame = CGRectMake(60, 120, S_W-130-70-30, 20);
    }else{
        
        _backgroundView.frame = CGRectMake(0, 0, S_W, 170);
        _bianHaoLabel.frame = CGRectMake(10, 5, S_W-20, 20);
        _topLine.frame = CGRectMake(10, 25, S_W-20, 0.3);
        _titleLabel.frame = CGRectMake(10, 35, S_W-20, 20);
        _jingPaiBianHaoLabel.frame = CGRectMake(10, 65, S_W-20, 20);
        _timeLabel.frame = CGRectMake(10, 65+25, S_W-20, 20);
        _typeLabel.frame = CGRectMake(10, 90+25, S_W-20, 20);
        _bottomLine.frame = CGRectMake(10, 115+25, S_W-20, 0.3);
        _baozhengjinLabel.frame = CGRectMake(10, 120+25, 50, 20);
        _bzjLabel.frame = CGRectMake(60, 120+25, S_W-130-70-30, 20);
 
    }
    //设置按钮
    if (myJingJiaListStatus == kMyJingJingListStatusYiBaoMing) {
        [_bottomLeftBtn setHidden:NO];
        _bottomLeftBtn.frame = CGRectMake(S_W-160, 125, 70, 20);
        [_bottomLeftBtn setTitle:@"缴纳保证金" forState:UIControlStateNormal];
        _bottomRightBtn.frame = CGRectMake(S_W-80, 125, 70, 20);
        [_bottomRightBtn setTitle:@"申请看货" forState:UIControlStateNormal];
    }else if (myJingJiaListStatus == kMyJingJingListStatusYiCanJia){
        
    }else if (myJingJiaListStatus == kMyJingJingListStatusStarted){
        _bottomLeftBtn.frame = CGRectMake(S_W-130, 145, 70, 20);
        _bottomRightBtn.frame = CGRectMake(S_W-50, 145, 40, 20);
        [_bottomLeftBtn setTitle:@"出价记录" forState:UIControlStateNormal];
        [_bottomRightBtn setTitle:@"出价" forState:UIControlStateNormal];
    }else if (myJingJiaListStatus == kMyJingJingListStatusWaitingTopay){
        [_bottomLeftBtn setHidden:NO];
        _bottomLeftBtn.frame = CGRectMake(S_W-160, 145, 70, 20);
        [_bottomLeftBtn setTitle:@"支付货款" forState:UIControlStateNormal];
        _bottomRightBtn.frame = CGRectMake(S_W-80, 145, 70, 20);
        [_bottomRightBtn setTitle:@"成交结果" forState:UIControlStateNormal];
    }else if (myJingJiaListStatus == kMyJingJingListStatusAlreadyPay){
        [_bottomLeftBtn setHidden:NO];
        _bottomLeftBtn.frame = CGRectMake(S_W-160, 145, 70, 20);
        [_bottomLeftBtn setTitle:@"确认提货" forState:UIControlStateNormal];
        _bottomRightBtn.frame = CGRectMake(S_W-80, 145, 70, 20);
        [_bottomRightBtn setTitle:@"成交结果" forState:UIControlStateNormal];
    }else if (myJingJiaListStatus == kMyJingJingListStatusSuccess){
        [_bottomLeftBtn setHidden:YES];
        _bottomRightBtn.frame = CGRectMake(S_W-80, 145, 70, 20);
        [_bottomRightBtn setTitle:@"成交结果" forState:UIControlStateNormal];
    }else if (myJingJiaListStatus == kMyJingJingListStatusFaild){
        _bianHaoLabel.frame = CGRectMake(10, 5, S_W-20-50, 20);
        _statusLabel.frame = CGRectMake(S_W - 55, 4, 45, 18);
        [_bottomLeftBtn setHidden:YES];
        _bottomRightBtn.frame = CGRectMake(S_W-80, 145, 70, 20);
        [_bottomRightBtn setTitle:@"成交结果" forState:UIControlStateNormal];
    }
}

-(void)setModel:(DanChangJingJiaListModel *)model{
    _model = model;
    if (model.tsTradeNo) {
        _bianHaoLabel.text = model.tsTradeNo;
    }
    if (model.tsName) {
        _titleLabel.text = model.tsName;
    }
    if (model.bidNo) {
        _jingPaiBianHaoLabel.text = [NSString stringWithFormat:@"竞拍编号:  %@",model.bidNo];
    }else{
        _jingPaiBianHaoLabel.text = @"竞拍编号:  ";
    }
    if (model.beginTime&&model.tsEndTime) {
        _timeLabel.text = [NSString stringWithFormat:@"竞价时间:  %@-%@",model.beginTime,model.tsEndTime];
    }else{
        _timeLabel.text = @"竞价时间:  ";
    }
    if (self.myJingJiaListStatus == kMyJingJingListStatusYiBaoMing) {
        if (![model.diIsCheck isEqualToString:@"1"]) {
            [_bottomLeftBtn setHidden:NO];
                BOOL result = [self.serverTime compare:model.beginTime] == NSOrderedDescending;
            if (result==1) {
                [_bottomLeftBtn setEnabled:NO];
            }else{
                [_bottomLeftBtn setEnabled:YES];
            }
        }else{
            [_bottomLeftBtn setHidden:YES];
        }
    }
    if (model.tsSiteType) {
        //0单品1拼盘
        if ([model.tsSiteType isEqualToString:@"0"]) {
            _typeLabel.text = @"场次类型:  单品";
        }
        if ([model.tsSiteType isEqualToString:@"1"]) {
            _typeLabel.text = @"场次类型:  拼盘";
        }
    }else{
        _typeLabel.text = @"场次类型:  ";
    }
    if (model.diNeedPay) {
        // 创建Attributed
        NSMutableAttributedString *noteStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ 元",[NSObject moneyStyle:model.diNeedPay]]];
        // 需要改变的区间
        NSRange range1 = NSMakeRange(0, noteStr1.length-1);
        // 改变颜色
        [noteStr1 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range1];
        // 改变字体大小及类型
        [noteStr1 addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:20 ] range:range1];
        // 为label添加Attributed
        [_bzjLabel setAttributedText:noteStr1];
    }
    
    if (self.myJingJiaListStatus == kMyJingJingListStatusFaild) {
        if (model.tsIsSuccess) {
            if ([model.tsIsSuccess isEqualToString:@"1"]) {
                [_bottomRightBtn setHidden:YES];
                _statusLabel.text = @"未成功";
                _statusLabel.textColor = [UIColor grayColor];
                _statusLabel.layer.borderWidth = 0.5;
                _statusLabel.layer.borderColor = [UIColor blackColor].CGColor;
                
            }else{
                [_bottomRightBtn setHidden:YES];
                _statusLabel.text = @"流拍";
                _statusLabel.textColor = [UIColor blackColor];
                _statusLabel.layer.borderWidth = 0.5;
                _statusLabel.layer.borderColor = [UIColor blackColor].CGColor;
                
            }
        }
    }
}
//点击方法实现代理
-(void)btnclicked:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(clickBtn:onCell:)]) {
        [self.delegate clickBtn:sender onCell:self];
    }
}


@end
