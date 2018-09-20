//
//  GongPingGongGaoDetailViewController.m
//  XYGPWuZi
//
//  Created by apple on 2018/9/13.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//
#define kTitleHeight 50
#define kDetailHeight 30

#import "GongPingGongGaoDetailViewController.h"
#import "Api_JiaoYiYuGao.h"

@interface GongPingGongGaoDetailViewController ()<UIWebViewDelegate>
@property(strong, nonatomic)UIWebView *webView;
@property(strong, nonatomic)UILabel *titleLabel, *detailLabel;
@end

@implementation GongPingGongGaoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [NSObject ToastShowStr:@"ToDo:0123暂时显示交易预告内容" during:10];
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
    
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(kTitleHeight+kDetailHeight+10+10, 0, 50, 0);
    [self.webView.scrollView addSubview:self.headerView];
    self.webView.scrollView.backgroundColor = UIColor.whiteColor;
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
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.textColor = UIColor.blackColor;
            label.font = [UIFont boldSystemFontOfSize:20];
            label.numberOfLines = 2;
            label.textAlignment = NSTextAlignmentCenter;
            label;
        });
    }return _titleLabel;
}
-(UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.textColor = UIColor.grayColor;
            label.font = [UIFont boldSystemFontOfSize:15];
            label.numberOfLines = 1;
            label.textAlignment = NSTextAlignmentCenter;
            label;
        });
    }return _detailLabel;
}
-(UIView *)headerView{
    UIView *view = [[UIView alloc] initWithFrame:(CGRect){0,-(kTitleHeight+kDetailHeight+10),kScreen_Width,kTitleHeight+kDetailHeight+10}];
    [view addSubview:self.titleLabel];
    [self.titleLabel setFrame:(CGRect){kMyPadding,0,kScreen_Width-kMyPadding *2,kTitleHeight}];
    
    [view addSubview:self.detailLabel];
    [self.detailLabel setFrame:(CGRect){kMyPadding,kTitleHeight,kScreen_Width-kMyPadding *2,kDetailHeight}];
    
    UIView *lineView = [[UIView alloc] initWithFrame:(CGRect){0,kTitleHeight+kDetailHeight+10,kScreen_Width,1}];
    lineView.backgroundColor = UIColor.groupTableViewBackgroundColor;
    [view addSubview:lineView];

    return view;
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
            NSString *strr = [NSString stringWithFormat:@"%@ 关键词：%@",fabuTimeStr,kanhuoAddressStr];

            self.detailLabel.text = strr;
        }else{
            [NSObject ToastShowStr:@"获取数据失败了..."];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [NSObject ToastShowStr:@"获取数据失败..."];
    }];
}

@end
