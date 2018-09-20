//
//  ConfirmAgreementViewController.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/4/16.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "ConfirmAgreementViewController.h"
#import "PayForBailViewController.h"
#import "Api_findDepositForUpdate.h"
#import "RxWebViewController.h"

@interface ConfirmAgreementViewController ()<UITextViewDelegate>
@property(strong, nonatomic)UIButton *btn1;
@property(strong, nonatomic)UIButton *btn2;

@property(strong, nonatomic)UITextView *myTextView1;
@property(strong, nonatomic)UITextView *myTextView2;

@property(assign, nonatomic)BOOL isAgree1;
@property(assign, nonatomic)BOOL isAgree2;

@property(strong, nonatomic)UIButton *bottomBtn;

@property(strong, nonatomic)Model_Trade *tradeM;
@end

@implementation ConfirmAgreementViewController
-(UIButton *)btn1{
    if (!_btn1) {
        CGFloat btnHeight = 25;
        CGFloat btnWidth = 25;
        _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn1.tag = 1;
        [_btn1 setSize:CGSizeMake(btnWidth, btnHeight)];
        [_btn1 setCornerRadius:btnHeight/2];
        [_btn1 setBackgroundImage:[UIImage imageNamed:@"ico_weigouxuan"] forState:UIControlStateNormal];
        [_btn1 setBackgroundImage:[UIImage imageNamed:@"ico_yigouxuan"] forState:UIControlStateSelected];
        [_btn1 addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    }return _btn1;
}
-(UIButton *)btn2{
    if (!_btn2) {
        CGFloat btnHeight = 25;
        CGFloat btnWidth = 25;
        _btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn2.tag = 2;
        [_btn2 setSize:CGSizeMake(btnWidth, btnHeight)];
        [_btn2 setCornerRadius:btnHeight/2];
        [_btn2 setBackgroundImage:[UIImage imageNamed:@"ico_weigouxuan"] forState:UIControlStateNormal];
        [_btn2 setBackgroundImage:[UIImage imageNamed:@"ico_yigouxuan"] forState:UIControlStateSelected];
        [_btn2 addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    }return _btn2;
}
-(void)actionBtn:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.tag == 1) {
        self.isAgree1 = !self.isAgree1;
        [self configProtocolIsAgree1:self.isAgree1];
        self.bottomBtn.enabled = self.isAgree1&&self.isAgree2;
    }else{
        self.isAgree2 = !self.isAgree2;
        [self configProtocolIsAgree2:self.isAgree2];
        self.bottomBtn.enabled = self.isAgree1&&self.isAgree2;
    }
}
-(UIButton *)bottomBtn{
    if (!_bottomBtn) {
        CGFloat btnHeight = 44;
        CGFloat btnWidth = [UIScreen mainScreen].bounds.size.width - kMyPadding*2;
        _bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomBtn setSize:CGSizeMake(btnWidth, btnHeight)];
        [_bottomBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
        [_bottomBtn setCornerRadius:btnHeight/2];
        [_bottomBtn setBackgroundImage:[UIImage imageWithColor:kColorNav] forState:UIControlStateNormal];
        [_bottomBtn setBackgroundImage:[UIImage imageWithColor:[UIColor groupTableViewBackgroundColor]] forState:UIControlStateDisabled];
        [_bottomBtn addTarget:self action:@selector(actionBottomBtn) forControlEvents:UIControlEventTouchUpInside];
        _bottomBtn.enabled = self.isAgree1&&self.isAgree2;

    }return _bottomBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"确认竞拍条件"];
    [self serveData];
    self.isAgree1 = NO;
    self.isAgree2 = NO;
    // Do any additional setup after loading the view.
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreen_Width - 32, 44));
        make.top.mas_equalTo(self.view.mas_top).offset(10);
        make.centerX.equalTo(self.view);
    }];
    self.myTextView1 = textView;
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 54, kScreen_Width, 1)];
    lineView1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:lineView1];
    
    UITextView *textView2 = [[UITextView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:textView2];
    [textView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreen_Width - 32, 44));
        make.top.mas_equalTo(lineView1.mas_bottom).offset(10);
        make.centerX.equalTo(self.view);
    }];
    self.myTextView2 = textView2;

    [self.myTextView1 addSubview:self.btn1];
    self.btn1.frame = CGRectMake(0, 7, 25, 25);
    
    [self.myTextView2 addSubview:self.btn2];
    self.btn2.frame = CGRectMake(0, 7, 25, 25);
    
    
    [self configProtocolIsAgree1:self.isAgree1];
    [self configProtocolIsAgree2:self.isAgree2];
    
    [self.view addSubview:self.bottomBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_bottom).offset(-kSafeBottomOffset-44);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-kSafeBottomOffset);
        make.left.equalTo(self.view).offset(kMyPadding);
        make.right.equalTo(self.view).offset(-kMyPadding);
        
    }];
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 108, kScreen_Width, 1)];
    lineView2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:lineView2];
}

-(void)configProtocolIsAgree1:(BOOL)select {
    CGFloat fontSize = 16;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"      我已阅读并同意《保证金协议》"];
    [attributedString addAttribute:NSLinkAttributeName
                             value:@"copyright1://"
                             range:[[attributedString string] rangeOfString:@"《保证金协议》"]];
//    UIImage *image = [UIImage imageNamed:select == YES ? @"ico_yigouxuan" : @"ico_weigouxuan"];
//    CGSize size = CGSizeMake(fontSize, fontSize);
//    UIGraphicsBeginImageContextWithOptions(size, false, 0);
//    [image drawInRect:CGRectMake(0, 1, size.width, size.height)];
    
//    UIImage *resizeImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    
//    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
//    textAttachment.image = resizeImage;
//    NSMutableAttributedString *imageString = [[NSMutableAttributedString alloc] initWithAttributedString:[NSAttributedString attributedStringWithAttachment:textAttachment]];
//    [imageString addAttribute:NSLinkAttributeName
//                        value:@"checkbox://"
//                        range:NSMakeRange(0, imageString.length)];
//    [attributedString insertAttributedString:imageString atIndex:0];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:NSMakeRange(0, attributedString.length)];
    
    self.myTextView1.delegate = self;
    self.myTextView1.editable = NO;        //必须禁止输入，否则点击将弹出输入键盘
    self.myTextView1.scrollEnabled = NO;
    self.myTextView1.attributedText = attributedString;
    self.myTextView1.font = [UIFont systemFontOfSize:fontSize];
    self.myTextView1.linkTextAttributes = @{ NSForegroundColorAttributeName: kColorNav,
                                            NSUnderlineColorAttributeName: [UIColor lightGrayColor],
                                            NSUnderlineStyleAttributeName: @(NSUnderlinePatternSolid),
                                            NSUnderlineColorAttributeName: kColorNav
                                            };
    
}
-(void)configProtocolIsAgree2:(BOOL)select {
    CGFloat fontSize = 16;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"      我已阅读并同意 《工平闲置物资竞价服务协议》"];
    [attributedString addAttribute:NSLinkAttributeName
                             value:@"copyright2://"
                             range:[[attributedString string] rangeOfString:@"《工平闲置物资竞价服务协议》"]];
//    UIImage *image = [UIImage imageNamed:select == YES ? @"ico_yigouxuan" : @"ico_weigouxuan"];
//    CGSize size = CGSizeMake(fontSize, fontSize);
//    UIGraphicsBeginImageContextWithOptions(size, false, 0);
//    [image drawInRect:CGRectMake(0, 1, size.width, size.height)];
    
//    UIImage *resizeImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
//    textAttachment.image = resizeImage;
//    NSMutableAttributedString *imageString = [[NSMutableAttributedString alloc] initWithAttributedString:[NSAttributedString attributedStringWithAttachment:textAttachment]];
//    [imageString addAttribute:NSLinkAttributeName
//                        value:@"checkbox1://"
//                        range:NSMakeRange(0, imageString.length)];
//    [attributedString insertAttributedString:imageString atIndex:0];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:NSMakeRange(0, attributedString.length)];
    
    self.myTextView2.delegate = self;
    self.myTextView2.editable = NO;        //必须禁止输入，否则点击将弹出输入键盘
    self.myTextView2.scrollEnabled = NO;
    self.myTextView2.attributedText = attributedString;
    self.myTextView2.font = [UIFont systemFontOfSize:fontSize];
    self.myTextView2.linkTextAttributes = @{ NSForegroundColorAttributeName: kColorNav,
                                             NSUnderlineColorAttributeName: [UIColor lightGrayColor],
                                             NSUnderlineStyleAttributeName: @(NSUnderlinePatternSolid),
                                             NSUnderlineColorAttributeName: kColorNav
                                             };
    
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    if ([[URL scheme] isEqualToString:@"copyright1"]) {
        NSLog(@"版权声明、隐私保护");/*1、保证金协议 2、拍卖规则 3、竞价服务协议 4、免责声明 5、注册协议*/
        NSString* urlStr = [NSString stringWithFormat:@"%@%@",[YTKNetworkConfig sharedConfig].baseUrl,@"xy/ruleOrAgreement/showDoc?type=1"];
        RxWebViewController* webViewController = [[RxWebViewController alloc] initWithUrl:[NSURL URLWithString:urlStr]];
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        [self.navigationController pushViewController:webViewController animated:YES];
        return NO;
    }else if ([[URL scheme] isEqualToString:@"copyright2"]) {
        NSString* urlStr = [NSString stringWithFormat:@"%@%@",[YTKNetworkConfig sharedConfig].baseUrl,@"xy/ruleOrAgreement/showDoc?type=3"];
        RxWebViewController* webViewController = [[RxWebViewController alloc] initWithUrl:[NSURL URLWithString:urlStr]];
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        [self.navigationController pushViewController:webViewController animated:YES];
        return NO;
    }
    else if ([[URL scheme] isEqualToString:@"checkbox"]) {
        self.isAgree1 = !self.isAgree1;
        [self configProtocolIsAgree1:self.isAgree1];
        self.bottomBtn.enabled = self.isAgree1&&self.isAgree2;
        return NO;
    }else{
        self.isAgree2 = !self.isAgree2;
        [self configProtocolIsAgree2:self.isAgree2];
        self.bottomBtn.enabled = self.isAgree1&&self.isAgree2;
        return NO;
    }
    return YES;
}

-(void)serveData{
    Api_findDepositForUpdate *api = [[Api_findDepositForUpdate alloc] initWithtsId:self.tsId];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        if ([request.responseJSONObject[@"success"] integerValue] == 1) {
            self.tradeM = [[Model_Trade alloc] initWithDictionary:request.responseJSONObject[@"object"] error:nil];
        }

        NSLog(@"succeed");
        
        NSLog(@"requestArgument:%@",request.requestArgument);
        NSLog(@"response:%@",request.response);
        NSLog(@"responseJSONObject:%@",request.responseJSONObject);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"failed");
        
        NSLog(@"requestArgument:%@",request.requestArgument);
        NSLog(@"response:%@",request.response);
        NSLog(@"responseJSONObject:%@",request.responseJSONObject);
    }];
}
-(void)actionBottomBtn{
    if (self.isAgree1&&self.isAgree2) {
        PayForBailViewController *vc = [PayForBailViewController new];
        vc.tradeM = self.tradeM;
        vc.isSingle = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [NSObject ToastShowStr:@"请勾选协议"];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
