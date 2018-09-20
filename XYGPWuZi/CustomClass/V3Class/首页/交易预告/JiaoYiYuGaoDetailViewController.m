//
//  JiaoYiYuGaoDetailViewController.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/10/11.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#define kTitleHeight 50
#define kDetailHeight 120
#define kliuchengHeight 80

#import "JiaoYiYuGaoDetailViewController.h"
#import "Api_JiaoYiYuGao.h"

@interface JiaoYiYuGaoDetailViewController ()<UIWebViewDelegate>
@property(strong, nonatomic)UIWebView *webView;
@property(strong, nonatomic)UILabel *titleLabel, *detailLabel;
@property(strong, nonatomic)UIButton *bottomBtn;
@end

@implementation JiaoYiYuGaoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.edges.mas_equalTo(self.view.safeAreaInsets);
        }else{
            make.edges.mas_equalTo(self.view);
        }
    }];
    
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(kTitleHeight+kDetailHeight+10+kliuchengHeight+10+20, 0, 50, 0);
    [self.webView.scrollView addSubview:self.headerView];
    self.webView.scrollView.backgroundColor = UIColor.whiteColor;
    
    [self.view addSubview:self.bottomBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreen_Width - 32, 50));
        make.bottom.equalTo(self.view).offset(-kSafeBottomOffset);
        make.centerX.equalTo(self.view);
    }];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [NSObject ToastActivityHide];
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
    [NSObject ToastActivityShow];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // Disable user selection
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    // Disable callout
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    [NSObject ToastActivityHide];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [NSObject ToastActivityHide];
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     [NSObject ToastActivityHide];
}
#pragma mark - UI
-(UIButton *)bottomBtn{
    if (!_bottomBtn) {
        CGFloat btnHeight = 44;
        CGFloat btnWidth = [UIScreen mainScreen].bounds.size.width - kMyPadding*2;
        
        _bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomBtn setSize:CGSizeMake(btnWidth, btnHeight)];
        [_bottomBtn setTitle:@"线下报名看货" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_bottomBtn setCornerRadius:btnHeight/2];
        [_bottomBtn setBackgroundColor:kColorMain];
        [_bottomBtn setBackgroundImage:[UIImage imageWithColor:UIColor.groupTableViewBackgroundColor] forState:UIControlStateDisabled];
        [_bottomBtn setBackgroundImage:[UIImage imageWithColor:kColorMain] forState:UIControlStateNormal];
        [_bottomBtn addTarget:self action:@selector(actionBottomBtn) forControlEvents:UIControlEventTouchUpInside];
    }return _bottomBtn;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.textColor = [UIColor blackColor];
            label.font = [UIFont boldSystemFontOfSize:17];
            label.numberOfLines = 2;
            label;
        });
    }return _titleLabel;
}
-(UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.textColor = [UIColor blackColor];
            label.font = [UIFont boldSystemFontOfSize:15];
            label.numberOfLines = 0;
            label;
        });
    }return _detailLabel;
}
-(UIView *)headerView{
    UIView *view = [[UIView alloc] initWithFrame:(CGRect){0,-(kTitleHeight+kDetailHeight+10+20+kliuchengHeight),kScreen_Width,kTitleHeight+kDetailHeight+10+20+kliuchengHeight}];
    [view addSubview:self.titleLabel];
    [self.titleLabel setFrame:(CGRect){kMyPadding,0,kScreen_Width-kMyPadding *2,kTitleHeight}];

    [view addSubview:self.detailLabel];
    [self.detailLabel setFrame:(CGRect){kMyPadding,kTitleHeight,kScreen_Width-kMyPadding *2,kDetailHeight}];
    
    UIView *lineView = [[UIView alloc] initWithFrame:(CGRect){0,kTitleHeight+kDetailHeight,kScreen_Width,10}];
    lineView.backgroundColor = UIColor.groupTableViewBackgroundColor;
    [view addSubview:lineView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:(CGRect){kMyPadding,kTitleHeight+kDetailHeight+10,kScreen_Width -kMyPadding *2,20}];
    label.text = @"竞价流程";
    [view addSubview:label];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:(CGRect){0,kTitleHeight+kDetailHeight+10+20,kScreen_Width,kliuchengHeight}];
    imageView.image = [UIImage imageNamed:@"LzyJingjialiucheng"];
    [view addSubview:imageView];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:(CGRect){0,kTitleHeight+kDetailHeight+10+20+kliuchengHeight,kScreen_Width,10}];
    lineView1.backgroundColor = UIColor.groupTableViewBackgroundColor;
    [view addSubview:lineView1];
    
    return view;
}


#pragma mark - Action
-(void)actionBottomBtn{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"看货申请"message:@"请致电客服热线 0315-3859900申请看货，平台通过审核后将第一时间以电话或短信通知您看货时间及看货地址，请耐心等待！"preferredStyle:UIAlertControllerStyleAlert ];
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:OKAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


-(void)setTitleText:(NSString *)titleText{
    _titleText = titleText;
    self.title = self.titleText;
}
-(void)setTnID:(NSString *)tnID{
    _tnID = tnID;
    
    Api_JiaoYiYuGao *api = [[Api_JiaoYiYuGao alloc] initWithTnID:self.tnID];
    api.animatingText = @"正在加载数据";
    api.animatingView = self.view;
    
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if ([request.responseJSONObject[@"code"] intValue] == 200) {
            //webView
            NSString *str = request.responseJSONObject[@"object"][@"tnContent"];
            NSString *str1 = [NSString stringWithFormat:@"<head><style>img{width:%f !important;height:auto}</style></head>%@",self.webView.width,str];
            NSString *CSS= @"<style type=\"text/css\">img{ width:100%;}</style>";
            NSString *htmlString = [NSString stringWithFormat:@"<html><meta charset=\"UTF-8\"><header>%@</header><body>%@</body></html>",CSS,str1];
            [self.webView loadHTMLString:htmlString baseURL:nil];
            
            //头视图
            NSString *titleStr = request.responseJSONObject[@"object"][@"tnTitle"];
            NSString *maifangNameStr = @"ToDo卖方名称";
            NSString *fabuTimeStr = request.responseJSONObject[@"object"][@"tnCretime"];
            NSString *kanhuoTimeStr = request.responseJSONObject[@"object"][@"tnSeeTime"];
            NSString *kanhuoAddressStr = request.responseJSONObject[@"object"][@"tnAddress"];
            NSString *baozhengjinStr = request.responseJSONObject[@"object"][@"tnMark"];
            
            //标题
            self.titleLabel.text = titleStr;
            
            //详情
            NSString *strr = [NSString stringWithFormat:@"卖方名称：%@\n发布时间：%@\n看货时间：%@\n看货地点：%@",maifangNameStr,fabuTimeStr,kanhuoTimeStr,kanhuoAddressStr];
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            //调整行间距
            paragraphStyle.lineSpacing = 5;
            NSDictionary *attriDict = @{NSParagraphStyleAttributeName:paragraphStyle,NSKernAttributeName:@(0/*字间距*/),
                                        NSFontAttributeName:[UIFont systemFontOfSize:15]};
            NSMutableAttributedString * attrStrP = [[NSMutableAttributedString alloc] initWithString:strr attributes:attriDict];
            [attrStrP addAttribute: NSForegroundColorAttributeName value: UIColor.grayColor range: NSMakeRange(0, strr.length)];
            
            [attrStrP addAttribute: NSForegroundColorAttributeName value: UIColor.blackColor range: NSMakeRange(5, maifangNameStr.length)];
            [attrStrP addAttribute: NSForegroundColorAttributeName value: UIColor.blackColor range: NSMakeRange(5+6+maifangNameStr.length, fabuTimeStr.length)];
            [attrStrP addAttribute: NSForegroundColorAttributeName value: UIColor.blackColor range: NSMakeRange(5+6+maifangNameStr.length+6+fabuTimeStr.length, kanhuoTimeStr.length)];
            [attrStrP addAttribute: NSForegroundColorAttributeName value: UIColor.blackColor range: NSMakeRange(5+6+maifangNameStr.length+6+fabuTimeStr.length+6+kanhuoTimeStr.length, kanhuoAddressStr.length)];
            self.detailLabel.attributedText = attrStrP;
        }else{
            [NSObject ToastShowStr:@"获取数据失败了..."];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [NSObject ToastShowStr:@"获取数据失败..."];
    }];
}

@end
