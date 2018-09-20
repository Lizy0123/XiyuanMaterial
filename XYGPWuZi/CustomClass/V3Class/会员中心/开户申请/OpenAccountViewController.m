//
//  OpenAccountViewController.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/3/24.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "OpenAccountViewController.h"
#import "TitleTextFieldTView.h"
#import "BRPickerView.h"
#import "OneImgOptView.h"
#import "Api_FindUserBankInfo.h"
#import "Model_FacUser.h"
#import "Model_FacInfo.h"
#import "Api_UploadImage.h"
#import "Api_SendSMSCode.h"
#import "Api_UpdateUserInfo.h"
#import "Api_userInfo.h"

@interface OpenAccountViewController ()<UITextFieldDelegate>
@property(strong, nonatomic)Model_FacUser *facUserM;
@property(strong, nonatomic)OneImgOptView *weituoshu;

@property(assign, nonatomic)NSInteger viewType;//1 已开户  2审核中  3被拒绝
@property(assign, nonatomic)BOOL isEnterprise;

@property(strong, nonatomic)UIScrollView *scrollView;
@property(strong, nonatomic)TitleTextFieldTView *view_i_0;
@property(strong, nonatomic)TitleTextFieldTView *view_i_1;
@property(strong, nonatomic)TitleTextFieldTView *view_i_2;
@property(strong, nonatomic)TitleTextFieldTView *view_i_3;
@property(strong, nonatomic)TitleTextFieldTView *view_i_4;
@property(strong, nonatomic)TitleTextFieldTView *view_i_5;


@property(strong, nonatomic)UIView *topTipsView;
@property(assign, nonatomic)NSInteger topTipsViewHeight;
@property(strong, nonatomic)UIView *enterpriseView;
@property(strong, nonatomic)UIView *personalView;
@property(strong, nonatomic)UIView *bottomView;
@property(strong, nonatomic)UIButton *mobileCodeBtn;
@property(strong, nonatomic)UITextField *mobileCodeField;

@property(strong, nonatomic)UIButton *bottomBtn;
@property(assign, nonatomic)NSInteger contentViewHeight;

@end

@implementation OpenAccountViewController
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        //ScrollView
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.userInteractionEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.bounces = YES;
        _scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    }return _scrollView;
}
-(UIView *)topTipsView{
    if (!_topTipsView) {
        //服务器数据 /*//0 未认证 1 已认证  2未通过  3请等待审核*/
        //本地数据 0 未认证  1已开户 2 审核中 3 未通过
        self.topTipsViewHeight = 50;
        UILabel *label = [[UILabel alloc] init];
        if (self.viewType == 0) {
            label.text = @"未认证（请尽快提交资质认证资料）";
            label.textColor = [UIColor greenColor];
            
        }else if (self.viewType == 1) {
            label.text = @"已开户（恭喜您开户认证成功，正式成为交易会员）";
            label.textColor = [UIColor greenColor];
            
        }else if (self.viewType == 2){
            label.text = @"审核中（您的开户资料正在审核，请耐心等待审核结果）";
            label.textColor = [UIColor orangeColor];
            
        }else if (self.viewType == 3){
            label.text = @"未通过（您的开户资料审核未通过，请重新提交，或致电客服热线0315-3859900 了解相关信息）";
            label.textColor = [UIColor redColor];
            self.topTipsViewHeight = 60;
        }
        
        _topTipsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, self.topTipsViewHeight)];
        label.frame = CGRectMake(kMyPadding, 0, kScreen_Width - kMyPadding *2, self.topTipsViewHeight);
        label.numberOfLines = 0;
        label.font = [UIFont boldSystemFontOfSize:15];
        
        [_topTipsView addSubview:label];
    }return _topTipsView;
}
-(UIView *)enterpriseView{
    if (!_enterpriseView) {
        _enterpriseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 500)];
        __weak typeof(self) weakSelf = self;
        //企业类型
        if (!self.view_i_0) {
            TitleTextFieldTView *cell = [[TitleTextFieldTView alloc] initWithFrame:CGRectMake(0, self.contentViewHeight, kScreen_Width, [TitleTextFieldTView cellHeight])];
            self.contentViewHeight += [TitleTextFieldTView cellHeight];
            [_enterpriseView addSubview:cell];
            self.view_i_0 = cell;
        }
        NSString *str = @"";
        if ([self.facUserM.facCountryType isEqualToString:@"0"]) {
            str = @"境内企业";
        }else{
            str = @"境外企业";
        }
        [self.view_i_0 setTitleStr:@"企业类型" valueStr:str placeHolder:@"必选"];

        if (!(self.viewType == 1 ||self.viewType == 2)) {
            self.view_i_0.tapAcitonBlock = ^{
                NSArray *dataSources = @[@"境内企业", @"境外企业"];
                [BRStringPickerView showStringPickerWithTitle:@"企业类型" dataSource:dataSources defaultSelValue:@"境内企业" isAutoSelect:YES resultBlock:^(id selectValue) {
                    [weakSelf.view_i_0 setTitleStr:@"企业类型" valueStr:selectValue placeHolder:@""];
                    if ([selectValue isEqualToString:@"境内企业"]) {
                        weakSelf.facUserM.facCountryType = @"0";
                    }
                    if ([selectValue isEqualToString:@"境外企业"]) {
                        weakSelf.facUserM.facCountryType = @"1";
                    }
                }];
            };
        }
        //公司全称
        if (!self.view_i_1) {
            TitleTextFieldTView *cell = [[TitleTextFieldTView alloc] initWithFrame:CGRectMake(0, self.contentViewHeight, kScreen_Width, [TitleTextFieldTView cellHeight])];
            self.contentViewHeight += [TitleTextFieldTView cellHeight];
            [_enterpriseView addSubview:cell];
            self.view_i_1 = cell;
        }
        [self.view_i_1 setTitleStr:@"公司全称" valueStr:self.facUserM.fi.unitsFull placeHolder:@"必填"];

        if (!(self.viewType == 1 ||self.viewType == 2)) {
            self.view_i_1.endEditBlock = ^(NSString *text) {
                weakSelf.facUserM.fi.unitsFull = text;
            };
        }
        //公司简称
        if (!self.view_i_2) {
            TitleTextFieldTView *cell = [[TitleTextFieldTView alloc] initWithFrame:CGRectMake(0, self.contentViewHeight, kScreen_Width, [TitleTextFieldTView cellHeight])];
            self.contentViewHeight += [TitleTextFieldTView cellHeight];
            [_enterpriseView addSubview:cell];
            self.view_i_2 = cell;
        }
        [self.view_i_2 setTitleStr:@"公司简称" valueStr:self.facUserM.fi.unitsAbd placeHolder:@"必填"];

        if (!(self.viewType == 1 ||self.viewType == 2)) {
            self.view_i_2.endEditBlock = ^(NSString *text) {
                weakSelf.facUserM.fi.unitsAbd = text;
            };
        }
        //证件类型
        if (!self.view_i_3) {
            TitleTextFieldTView *cell = [[TitleTextFieldTView alloc] initWithFrame:CGRectMake(0, self.contentViewHeight, kScreen_Width, [TitleTextFieldTView cellHeight])];
            self.contentViewHeight += [TitleTextFieldTView cellHeight];
            [_enterpriseView addSubview:cell];
            self.view_i_3 = cell;
        }
        NSString *str1 = @"";
        if ([self.facUserM.fi.infoSzhyStatus isEqualToString:@"0"]) {
            str1 = @"非三证合一";
        }else{
            str1 = @"三证合一";
        }
        [self.view_i_3 setTitleStr:@"证件类型" valueStr:str1 placeHolder:@"必选"];
        if (!(self.viewType == 1 ||self.viewType == 2)) {
            self.view_i_3.tapAcitonBlock = ^{
                NSArray *dataSources = @[@"非三证合一", @"三证合一"];
                [BRStringPickerView showStringPickerWithTitle:@"证件类型" dataSource:dataSources defaultSelValue:@"三证合一" isAutoSelect:YES resultBlock:^(id selectValue) {
                    [weakSelf.view_i_3 setTitleStr:@"证件类型" valueStr:selectValue placeHolder:@""];
                    if ([selectValue isEqualToString:@"非三证合一"]) {
                        weakSelf.facUserM.fi.infoSzhyStatus = @"0";
                    }
                    if ([selectValue isEqualToString:@"三证合一"]) {
                        weakSelf.facUserM.fi.infoSzhyStatus = @"1";
                    }
                }];
            };
        }

        
        
        //上传企业资料
        UILabel *sectionTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMyPadding, self.contentViewHeight, kScreen_Width - 2*kMyPadding, 50)];
        self.contentViewHeight += 50;
        sectionTitleLabel.text = @"上传企业资料";
        [_enterpriseView addSubview:sectionTitleLabel];
        
        
        CGFloat imgWidth = (kScreen_Width -kMyPadding *4)/3;
        {
            OneImgOptView *imageOptView = [[OneImgOptView alloc] initWithFrame:CGRectMake(kMyPadding, self.contentViewHeight, imgWidth, imgWidth+20+30)];
            OneImgOptViewModel *model = [[OneImgOptViewModel alloc] init];
            model.imageNameStr = @"营业执照";
            model.descStr = @"需原件或加盖公章的复印件";
            model.imageUrlStr = [NSString stringWithFormat:@"%@%@",[YTKNetworkConfig sharedConfig].cdnUrl,self.facUserM.fi.infoYyzzFile];
            imageOptView.oneImgViewM = model;
            imageOptView.parentVC = self;
            if (!(self.viewType == 1 ||self.viewType == 2)) {
                imageOptView.selectedBlock = ^(UIImage *selectImage) {
                    //上传图片
                    Api_UploadImage *api = [[Api_UploadImage alloc] initWithImage:selectImage];
                    api.animatingText = @"正在上传数据...";
                    api.animatingView = weakSelf.view;
                    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                        if ([request.responseJSONObject[@"code"] integerValue] == 200) {
                            weakSelf.facUserM.fi.infoYyzzFile = api.responseImageId;
                            
                        }else if ([request.responseJSONObject[@"code"] integerValue] == 500){
                            NSString *str = request.responseJSONObject[@"msg"];
                            [NSObject ToastShowStr:str];
                        }
                        NSLog(@"apiSaveOrUpdate succeed");
                        NSLog(@"apiSaveOrUpdate succeed");
                        NSLog(@"apiSaveOrUpdate:requestArgument:%@",request.requestArgument);
                        NSLog(@"apiSaveOrUpdate:response:%@",request.response);
                        NSLog(@"apiSaveOrUpdate:responseJSONObject:%@",request.responseJSONObject);
                    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                        NSString *str = request.responseJSONObject[@"msg"];
                        [NSObject ToastShowStr:str];
                        NSLog(@"apiSaveOrUpdate Failde");
                        NSLog(@"apiSaveOrUpdate failed");
                        NSLog(@"apiSaveOrUpdate:requestArgument:%@",request.requestArgument);
                        NSLog(@"apiSaveOrUpdate:response:%@",request.response);
                        NSLog(@"apiSaveOrUpdate:responseJSONObject:%@",request.responseJSONObject);
                    }];
                };
            }
            [_enterpriseView addSubview:imageOptView];
        }
        {
            OneImgOptView *imageOptView = [[OneImgOptView alloc] initWithFrame:CGRectMake(kMyPadding*2+imgWidth, self.contentViewHeight, imgWidth, imgWidth+20+30)];
            OneImgOptViewModel *model = [[OneImgOptViewModel alloc] init];
            model.imageNameStr = @"税务登记证";
            model.descStr = @"";
            model.imageUrlStr = [NSString stringWithFormat:@"%@%@",[YTKNetworkConfig sharedConfig].cdnUrl,self.facUserM.fi.infoSwdjzFile];

            imageOptView.oneImgViewM = model;
            imageOptView.parentVC = self;
            if (!(self.viewType == 1 ||self.viewType == 2)) {
                imageOptView.selectedBlock = ^(UIImage *selectImage) {
                    //上传图片
                    Api_UploadImage *api = [[Api_UploadImage alloc] initWithImage:selectImage];
                    api.animatingText = @"正在上传数据...";
                    api.animatingView = weakSelf.view;
                    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                        if ([request.responseJSONObject[@"code"] integerValue] == 200) {
                            weakSelf.facUserM.fi.infoYyzzFile = api.responseImageId;
                            
                        }else if ([request.responseJSONObject[@"code"] integerValue] == 500){
                            NSString *str = request.responseJSONObject[@"msg"];
                            [NSObject ToastShowStr:str];
                        }
                        NSLog(@"apiSaveOrUpdate succeed");
                        NSLog(@"apiSaveOrUpdate succeed");
                        NSLog(@"apiSaveOrUpdate:requestArgument:%@",request.requestArgument);
                        NSLog(@"apiSaveOrUpdate:response:%@",request.response);
                        NSLog(@"apiSaveOrUpdate:responseJSONObject:%@",request.responseJSONObject);
                    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                        NSString *str = request.responseJSONObject[@"msg"];
                        [NSObject ToastShowStr:str];
                        NSLog(@"apiSaveOrUpdate Failde");
                        NSLog(@"apiSaveOrUpdate failed");
                        NSLog(@"apiSaveOrUpdate:requestArgument:%@",request.requestArgument);
                        NSLog(@"apiSaveOrUpdate:response:%@",request.response);
                        NSLog(@"apiSaveOrUpdate:responseJSONObject:%@",request.responseJSONObject);
                    }];
                };
            }
            [_enterpriseView addSubview:imageOptView];
        }
        {
            OneImgOptView *imageOptView = [[OneImgOptView alloc] initWithFrame:CGRectMake(kMyPadding*3+imgWidth*2, self.contentViewHeight, imgWidth, imgWidth+20+30)];
            OneImgOptViewModel *model = [[OneImgOptViewModel alloc] init];
            model.imageNameStr = @"组织结构代码证";
            model.descStr = @"";
            model.imageUrlStr = [NSString stringWithFormat:@"%@%@",[YTKNetworkConfig sharedConfig].cdnUrl,self.facUserM.fi.infoJgdmzFile];

            imageOptView.oneImgViewM = model;
            imageOptView.parentVC = self;
            if (!(self.viewType == 1 ||self.viewType == 2)) {
                imageOptView.selectedBlock = ^(UIImage *selectImage) {
                    //上传图片
                    Api_UploadImage *api = [[Api_UploadImage alloc] initWithImage:selectImage];
                    api.animatingText = @"正在上传数据...";
                    api.animatingView = weakSelf.view;
                    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                        if ([request.responseJSONObject[@"code"] integerValue] == 200) {
                            weakSelf.facUserM.fi.infoJgdmzFile = api.responseImageId;
                            
                        }else if ([request.responseJSONObject[@"code"] integerValue] == 500){
                            NSString *str = request.responseJSONObject[@"msg"];
                            [NSObject ToastShowStr:str];
                        }
                        NSLog(@"apiSaveOrUpdate succeed");
                        NSLog(@"apiSaveOrUpdate succeed");
                        NSLog(@"apiSaveOrUpdate:requestArgument:%@",request.requestArgument);
                        NSLog(@"apiSaveOrUpdate:response:%@",request.response);
                        NSLog(@"apiSaveOrUpdate:responseJSONObject:%@",request.responseJSONObject);
                    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                        NSString *str = request.responseJSONObject[@"msg"];
                        [NSObject ToastShowStr:str];
                        NSLog(@"apiSaveOrUpdate Failde");
                        NSLog(@"apiSaveOrUpdate failed");
                        NSLog(@"apiSaveOrUpdate:requestArgument:%@",request.requestArgument);
                        NSLog(@"apiSaveOrUpdate:response:%@",request.response);
                        NSLog(@"apiSaveOrUpdate:responseJSONObject:%@",request.responseJSONObject);
                    }];
                };
            }
            [_enterpriseView addSubview:imageOptView];
        }
        self.contentViewHeight += imgWidth+20+30;

    }return _enterpriseView;
}
-(UIView *)personalView{
    if (!_personalView) {
        _personalView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 300)];
        __weak typeof(self) weakSelf = self;

        //姓名
        if (!self.view_i_1) {
            TitleTextFieldTView *cell = [[TitleTextFieldTView alloc] initWithFrame:CGRectMake(0, self.contentViewHeight, kScreen_Width, [TitleTextFieldTView cellHeight])];
            self.contentViewHeight += [TitleTextFieldTView cellHeight];
            [_personalView addSubview:cell];
            self.view_i_1 = cell;
        }
        [self.view_i_1 setTitleStr:@"姓名" valueStr:self.facUserM.caseName placeHolder:@"必填"];

        if (!(self.viewType == 1 ||self.viewType == 2)) {
            self.view_i_1.endEditBlock = ^(NSString *text) {
                weakSelf.facUserM.caseName = text;
            };
        }
        //身份证号
        if (!self.view_i_2) {
            TitleTextFieldTView *cell = [[TitleTextFieldTView alloc] initWithFrame:CGRectMake(0, self.contentViewHeight, kScreen_Width, [TitleTextFieldTView cellHeight])];
            self.contentViewHeight += [TitleTextFieldTView cellHeight];
            [_personalView addSubview:cell];
            self.view_i_2 = cell;
        }
        [self.view_i_2 setTitleStr:@"身份证号" valueStr:self.facUserM.facCard placeHolder:@"必填"];

        if (!(self.viewType == 1 ||self.viewType == 2)) {
            self.view_i_2.endEditBlock = ^(NSString *text) {
                weakSelf.facUserM.facCard = text;
            };
        }
    }return _personalView;
}

-(UITextField *)mobileCodeField{
    if (!_mobileCodeField) {
        _mobileCodeField = [[UITextField alloc] init];
        _mobileCodeField.placeholder = @"认证验证码";
        _mobileCodeField.font = [UIFont systemFontOfSize:15];
        _mobileCodeField.borderStyle = UITextBorderStyleNone;
        _mobileCodeField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _mobileCodeField.keyboardType = UIKeyboardTypeNumberPad;
        
        _mobileCodeField.delegate = self;
        _mobileCodeField.layer.cornerRadius = 5;
        _mobileCodeField.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        _mobileCodeField.rightViewMode = UITextFieldViewModeAlways;
        _mobileCodeField.rightView = self.mobileCodeBtn;
    }return _mobileCodeField;
}
-(UIButton *)mobileCodeBtn{
    if (!_mobileCodeBtn) {
        _mobileCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _mobileCodeBtn.size = CGSizeMake(100, 30);
        [_mobileCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _mobileCodeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        _mobileCodeBtn.clipsToBounds = YES;
        _mobileCodeBtn.layer.cornerRadius = 15;
        _mobileCodeBtn.backgroundColor = kColorNav;
        _mobileCodeBtn.userInteractionEnabled = NO;
        _mobileCodeBtn.alpha = 0.5;
        
        [_mobileCodeBtn addTarget:self action:@selector(actionMobileCode) forControlEvents:UIControlEventTouchUpInside];
    }return _mobileCodeBtn;
}
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.contentViewHeight, kScreen_Width, 300)];
        //验证码
        self.mobileCodeField.frame = CGRectMake(kMyPadding,  0, kScreen_Width - kMyPadding*2, 44);
        [_bottomView addSubview:_mobileCodeField];
        //        self.mobileCodeBtn.frame = CGRectMake(CGRectGetMaxX(self.mobileCodeField.frame), CGRectGetMaxY(_mobileField.frame)+9, 100, 30);
        //        [_myScrollView addSubview:self.mobileCodeBtn];
        //        self.mobileCodeBtn.userInteractionEnabled = YES;
        UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(kMyPadding, 44, kScreen_Width - kMyPadding*2, 1)];
        lineView3.backgroundColor = [UIColor lightGrayColor];
        [_bottomView addSubview:lineView3];
        self.contentViewHeight += 44;

        self.bottomBtn.center = CGPointMake(kScreen_Width/2, 44+50);
        [_bottomView addSubview:_bottomBtn];
        self.contentViewHeight += 100;
        
        UILabel *bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMyPadding, 44+50+50, kScreen_Width - kMyPadding *2, 200)];
        bottomLabel.numberOfLines = 0;
        bottomLabel.textColor = [UIColor grayColor];
        bottomLabel.font = [UIFont systemFontOfSize:15];
        //
        NSMutableAttributedString * str1 = [[NSMutableAttributedString alloc] initWithString:@"⚠︎ 温馨提示：\n• 安全支付手机用于平台资金收付款等环节操作，为保证账户资金安全，请您尽快绑定\n• 若您是企业用户，建议使用财务人员手机号进行安全支付手机的绑定操作\n• 若有疑问请联系客服热线 0315-3859900（周一至周五 9:00-16:00）"];
        NSDictionary * attri1 = @{ NSFontAttributeName:[UIFont boldSystemFontOfSize:13],NSForegroundColorAttributeName:[UIColor blackColor],}; [str1 setAttributes:attri1 range:NSMakeRange(0,str1.length)];
        
        NSMutableParagraphStyle * paragraphStyle = [NSMutableParagraphStyle new];
        //调整行间距
        paragraphStyle.alignment = NSTextAlignmentLeft;
        paragraphStyle.lineSpacing = 5; //设置行间距
        paragraphStyle.firstLineHeadIndent = 10.0;//设置第一行缩进
        [str1 addAttributes:@{NSParagraphStyleAttributeName:paragraphStyle,NSKernAttributeName:@(1)} range:NSMakeRange(0, str1.length)];
        bottomLabel.attributedText = str1;
        [_bottomView addSubview:bottomLabel];
        self.contentViewHeight += 100;

    }return _bottomView;
}
-(UIButton *)bottomBtn{
    if (!_bottomBtn) {
        CGFloat btnHeight = 44;
        CGFloat btnWidth = [UIScreen mainScreen].bounds.size.width - kMyPadding*2;
        
        _bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomBtn setSize:CGSizeMake(btnWidth, btnHeight)];
        [_bottomBtn setTitle:@"申请开户" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
        [_bottomBtn setCornerRadius:btnHeight/2];
        [_bottomBtn setBackgroundColor:kColorNav];
        [_bottomBtn addTarget:self action:@selector(actionBottomBtn) forControlEvents:UIControlEventTouchUpInside];
    }return _bottomBtn;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self serveData_UserInfo];
    
        
    if ([[UserManager readUserInfo].facUserType isEqualToString:@"0"]) {/*账户类型（0、企业 1、个人）*/
        self.isEnterprise = YES;
    }else{
        self.isEnterprise = NO;
    }
    
    
    
    
    
    [self.view addSubview:self.scrollView];
//    [self configScrollView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)configScrollView{
    //头部的提示信息
    [self.scrollView addSubview:self.topTipsView];
    //企业的信息
    self.contentViewHeight += self.topTipsViewHeight;
    if (self.isEnterprise) {
        [self.scrollView addSubview:self.enterpriseView];
    }else{
        [self.scrollView addSubview:self.personalView];
    }
    __weak typeof(self) weakSelf = self;

    //@"上传授权人资料"
    UILabel *sectionTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMyPadding, self.contentViewHeight, kScreen_Width - 2*kMyPadding, 50)];
    self.contentViewHeight += 50;
    sectionTitleLabel.text = @"上传授权人资料";
    [self.scrollView addSubview:sectionTitleLabel];
    CGFloat imgWidth = (kScreen_Width -kMyPadding *4)/3;
    {
        OneImgOptView *imageOptView = [[OneImgOptView alloc] initWithFrame:CGRectMake(kMyPadding, self.contentViewHeight, imgWidth, imgWidth+20+30)];
        OneImgOptViewModel *model = [[OneImgOptViewModel alloc] init];
        model.imageNameStr = @"身份证";
        model.descStr = @"正反面扫描件或复印件加本人签字";
        model.imageUrlStr = [NSString stringWithFormat:@"%@%@",[YTKNetworkConfig sharedConfig].cdnUrl,self.facUserM.fi.infoSszFile];
        
        imageOptView.oneImgViewM = model;
        imageOptView.parentVC = self;
        if (!(self.viewType == 1 ||self.viewType == 2)) {
            imageOptView.selectedBlock = ^(UIImage *selectImage) {
                //上传图片
                Api_UploadImage *api = [[Api_UploadImage alloc] initWithImage:selectImage];
                api.animatingText = @"正在上传数据...";
                api.animatingView = weakSelf.view;
                [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                    if ([request.responseJSONObject[@"code"] integerValue] == 200) {
                        weakSelf.facUserM.fi.infoSszFile = api.responseImageId;
                        
                    }else if ([request.responseJSONObject[@"code"] integerValue] == 500){
                        NSString *str = request.responseJSONObject[@"msg"];
                        [NSObject ToastShowStr:str];
                    }
                    NSLog(@"apiSaveOrUpdate succeed");
                    NSLog(@"apiSaveOrUpdate succeed");
                    NSLog(@"apiSaveOrUpdate:requestArgument:%@",request.requestArgument);
                    NSLog(@"apiSaveOrUpdate:response:%@",request.response);
                    NSLog(@"apiSaveOrUpdate:responseJSONObject:%@",request.responseJSONObject);
                } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                    NSString *str = request.responseJSONObject[@"msg"];
                    [NSObject ToastShowStr:str];
                    NSLog(@"apiSaveOrUpdate Failde");
                    NSLog(@"apiSaveOrUpdate failed");
                    NSLog(@"apiSaveOrUpdate:requestArgument:%@",request.requestArgument);
                    NSLog(@"apiSaveOrUpdate:response:%@",request.response);
                    NSLog(@"apiSaveOrUpdate:responseJSONObject:%@",request.responseJSONObject);
                }];
            };
        }
        
        [self.scrollView addSubview:imageOptView];
    }
    if (self.isEnterprise) {
        {
            OneImgOptView *imageOptView = [[OneImgOptView alloc] initWithFrame:CGRectMake(kMyPadding*2+imgWidth, self.contentViewHeight, imgWidth, imgWidth+20+30)];
            OneImgOptViewModel *model = [[OneImgOptViewModel alloc] init];
            model.imageNameStr = @"授权委托书";
            model.descStr = @"加盖公章且经办人签字";
            model.imageUrlStr = [NSString stringWithFormat:@"%@%@",[YTKNetworkConfig sharedConfig].cdnUrl,self.facUserM.fi.infoSqwtsFile];
            self.weituoshu = imageOptView;
            imageOptView.oneImgViewM = model;
            imageOptView.parentVC = self;
            if (!(self.viewType == 1 ||self.viewType == 2)) {
                imageOptView.selectedBlock = ^(UIImage *selectImage) {
                    //上传图片
                    Api_UploadImage *api = [[Api_UploadImage alloc] initWithImage:selectImage];
                    api.animatingText = @"正在上传数据...";
                    api.animatingView = weakSelf.view;
                    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                        if ([request.responseJSONObject[@"code"] integerValue] == 200) {
                            weakSelf.facUserM.fi.infoSqwtsFile = api.responseImageId;
                            
                        }else if ([request.responseJSONObject[@"code"] integerValue] == 500){
                            NSString *str = request.responseJSONObject[@"msg"];
                            [NSObject ToastShowStr:str];
                        }
                        NSLog(@"apiSaveOrUpdate succeed");
                        NSLog(@"apiSaveOrUpdate succeed");
                        NSLog(@"apiSaveOrUpdate:requestArgument:%@",request.requestArgument);
                        NSLog(@"apiSaveOrUpdate:response:%@",request.response);
                        NSLog(@"apiSaveOrUpdate:responseJSONObject:%@",request.responseJSONObject);
                    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                        NSString *str = request.responseJSONObject[@"msg"];
                        [NSObject ToastShowStr:str];
                        NSLog(@"apiSaveOrUpdate Failde");
                        NSLog(@"apiSaveOrUpdate failed");
                        NSLog(@"apiSaveOrUpdate:requestArgument:%@",request.requestArgument);
                        NSLog(@"apiSaveOrUpdate:response:%@",request.response);
                        NSLog(@"apiSaveOrUpdate:responseJSONObject:%@",request.responseJSONObject);
                    }];
                };
            }
            [self.scrollView addSubview:imageOptView];
        }
    }
    
    
    self.contentViewHeight += imgWidth+20+30;
    
    //@"上传授权人资料"
    UILabel *sectionTitleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(kMyPadding, self.contentViewHeight, kScreen_Width - 2*kMyPadding, 50)];
    self.contentViewHeight += 50;
    sectionTitleLabel1.text = @"绑定安全支付手机";
    [self.scrollView addSubview:sectionTitleLabel1];

    
    //财务联系人
    if (!self.view_i_4) {
        TitleTextFieldTView *cell = [[TitleTextFieldTView alloc] initWithFrame:CGRectMake(0, self.contentViewHeight, kScreen_Width, [TitleTextFieldTView cellHeight])];
        self.contentViewHeight += [TitleTextFieldTView cellHeight];
        [self.scrollView addSubview:cell];
        self.view_i_4 = cell;
    }
    [self.view_i_4 setTitleStr:@"财务联系人" valueStr:self.facUserM.facPayName placeHolder:@"必填"];
    if (!(self.viewType == 1 ||self.viewType == 2)) {
        self.view_i_4.endEditBlock = ^(NSString *text) {
            weakSelf.facUserM.facPayName = text;
            
        };
    }

    //财务操作认证手机号
    if (!self.view_i_5) {
        TitleTextFieldTView *cell = [[TitleTextFieldTView alloc] initWithFrame:CGRectMake(0, self.contentViewHeight, kScreen_Width, [TitleTextFieldTView cellHeight])];
        self.contentViewHeight += [TitleTextFieldTView cellHeight];
        [self.scrollView addSubview:cell];
        self.view_i_5 = cell;
    }
    [self.view_i_5 setTitleStr:@"财务操作手机号" valueStr:self.facUserM.facPayMobil placeHolder:@"必填"];
    if (!(self.viewType == 1 ||self.viewType == 2)) {
        self.view_i_5.endEditBlock = ^(NSString *text) {
            weakSelf.facUserM.facPayMobil = text;
            if (text.length>8) {
                weakSelf.mobileCodeBtn.userInteractionEnabled = YES;
            }
        };
    }
    if (self.facUserM.facPayMobil.length>8) {
        weakSelf.mobileCodeBtn.userInteractionEnabled = YES;
    }

    if (!(self.viewType == 1 ||self.viewType == 2)) {
        [self.scrollView addSubview:self.bottomView];
    }
    self.scrollView.contentSize = CGSizeMake(kScreen_Width, self.contentViewHeight+200);
}
-(void)serveData_UserInfo{
    Api_userInfo *api = [[Api_userInfo alloc] initWithfacUserid:[UserManager readUserInfo].facUserid];
    api.animatingText = @"正在链接服务器";
    api.animatingView = self.view;
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"succeed");
        NSLog(@"requestArgument:%@",request.requestArgument);
        NSLog(@"response:%@",request.response);
        NSLog(@"responseJSONObject:%@",request.responseJSONObject);
        self.facUserM = [[Model_FacUser alloc] initWithDictionary:request.responseJSONObject[@"object"] error:nil];
        
        /*//0 未认证 1 已认证  2未通过  3请等待审核*/
        //服务器数据 /*//0 未认证 1 已认证  2未通过  3请等待审核*/
        //本地数据 0 未认证  1已开户 2 审核中 3 未通过
        if ([self.facUserM.facIsTrade isEqualToString:@"0"]) {
            self.viewType = 0;
            
        }else if ([self.facUserM.facIsTrade isEqualToString:@"1"]){
            self.viewType = 1;
            
        }else if ([self.facUserM.facIsTrade isEqualToString:@"2"]){
            self.viewType = 3;
            
        }else if ([self.facUserM.facIsTrade isEqualToString:@"3"]){
            self.viewType = 2;
        }
        if (self.viewType == 1) {
            self.title = @"开户资料";
        }else{
            self.title = @"申请开户";
        }
        
        [self configScrollView];

    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"failed");
        NSLog(@"requestArgument:%@",request.requestArgument);
        NSLog(@"response:%@",request.response);
        NSLog(@"responseJSONObject:%@",request.responseJSONObject);
    }];
    
    
}
// 开启倒计时效果
-(void)actionMobileCode{
    Api_SendSMSCode *SendUpdateLoginMobileCodeApi = [[Api_SendSMSCode alloc] initWithMobile:self.facUserM.facPayMobil type:@"4"];
    [SendUpdateLoginMobileCodeApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        if ([request.responseJSONObject[@"code"] integerValue] == 200) {
            __block NSInteger time = 59; //倒计时时间
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(time <= 0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //设置按钮的样式
                        [self.mobileCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                        [self.mobileCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        self.mobileCodeBtn.userInteractionEnabled = YES;
                    });
                }else{
                    int seconds = time % 60;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //设置按钮显示读秒效果
                        [self.mobileCodeBtn setTitle:[NSString stringWithFormat:@"(%.2ds)", seconds] forState:UIControlStateNormal];
                        [self.mobileCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        self.mobileCodeBtn.userInteractionEnabled = NO;
                    });
                    time--;
                }
            });
            dispatch_resume(_timer);
        }else if ([request.responseJSONObject[@"code"] integerValue] == 500){
            NSString *str = request.responseJSONObject[@"msg"];
            [NSObject ToastShowStr:str];
        }
        NSLog(@"SendUpdateLoginMobileCodeApi succeed");
        NSLog(@"SendUpdateLoginMobileCodeApi succeed");
        NSLog(@"requestArgument:%@",request.requestArgument);
        NSLog(@"responseHeaders:%@",request.responseHeaders);
        NSLog(@"response:%@",request.response);
        NSLog(@"responseData:%@",request.responseData);
        NSLog(@"responseString:%@",request.responseString);
        NSLog(@"responseJSONObject:%@",request.responseJSONObject);
    } failure:^(__kindof YTKBaseRequest *request) {
        NSLog(@"SendUpdateLoginMobileCodeApi failed");

    }];
}
-(BOOL)isCanGotoNextStep{
    if (self.isEnterprise) {
        if (!([NSObject isString:self.facUserM.facCountryType])) {
            [NSObject ToastShowStr:@"请选择企业类型"];
            return NO;
        }
        if (!([NSObject isString:self.facUserM.fi.unitsFull])) {
            [NSObject ToastShowStr:@"请输入公司全称"];

            return NO;
        }
        if (!([NSObject isString:self.facUserM.fi.unitsAbd])) {
            [NSObject ToastShowStr:@"单位简称"];

            return NO;
        }
        if (!([NSObject isString:self.facUserM.fi.infoSzhyStatus])) {
            [NSObject ToastShowStr:@"请选择是否是三证合一"];
            return NO;
        }
        if ([self.facUserM.fi.infoSzhyStatus isEqualToString:@"0"]) {
            if (!([NSObject isString:self.facUserM.fi.infoYyzzFile])) {
                [NSObject ToastShowStr:@"请上传营业执照"];
                return NO;
            }
            if (!([NSObject isString:self.facUserM.fi.infoSwdjzFile])) {
                [NSObject ToastShowStr:@"请上传税务登记证"];
                return NO;
            }
            if (!([NSObject isString:self.facUserM.fi.infoJgdmzFile])) {
                [NSObject ToastShowStr:@"请上传组织机构代码证"];
                return NO;
            }
        }else{
            if (!([NSObject isString:self.facUserM.fi.infoYyzzFile])) {
                [NSObject ToastShowStr:@"请上传营业执照"];
                return NO;
            }
        }
        if (!([NSObject isString:self.facUserM.fi.infoSqwtsFile])) {
            [NSObject ToastShowStr:@"请上传授权委托书"];
            return NO;
        }
    }else{
        if (!([NSObject isString:self.facUserM.caseName])) {
            [NSObject ToastShowStr:@"请输入真实姓名"];
            return NO;
        }
        if (!([NSObject isString:self.facUserM.facCard])) {
            [NSObject ToastShowStr:@"请输入身份证号"];
            return NO;
        }
    }
    

    if (!([NSObject isString:self.facUserM.fi.infoSszFile])) {
        [NSObject ToastShowStr:@"请上传身份证"];
        return NO;
    }
    if (!([NSObject isString:self.facUserM.facPayName])) {
        [NSObject ToastShowStr:@"请输入财务联系人"];
        return NO;
    }
    if (!([NSObject isString:self.facUserM.facPayMobil])) {
        [NSObject ToastShowStr:@"请输入财务操作认证手机"];
        return NO;
    }
    return YES;
}
-(void)actionBottomBtn{
    if (!([self isCanGotoNextStep])) {
        return;
    }
    if (![NSObject isString:self.mobileCodeField.text]) {
        [NSObject ToastShowStr:@"请输入验证码"];
        return;
    }
    Api_UpdateUserInfo *api = [[Api_UpdateUserInfo alloc] initWithFacUser:self.facUserM withFacInfo:self.facUserM.fi phoneCode:self.mobileCodeField.text];
    api.animatingText = @"正在上传资料，请稍候！";
    api.animatingView = self.view;
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if ([request.responseJSONObject[@"success"] integerValue] == 1) {
            [NSObject ToastShowStr:@"开户信息已提交,请等待审核！"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        if (request.responseJSONObject[@"message"]) {
            [NSObject ToastShowStr:request.responseJSONObject[@"message"]];
        }
        
        
        NSLog(@"requestArgument:%@",request.requestArgument);
        NSLog(@"response:%@",request.response);
        NSLog(@"responseJSONObject:%@",request.responseJSONObject);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {

        if ([NSObject isString:request.responseJSONObject[@"message"]]) {
            [NSObject ToastShowStr:request.responseJSONObject[@"message"]];
        }else{
            [NSObject ToastShowStr:@"提交失败！"];
        }
        NSLog(@"requestArgument:%@",request.requestArgument);
        NSLog(@"response:%@",request.response);
        NSLog(@"responseJSONObject:%@",request.responseJSONObject);
    }];
}


@end
