//
//  PayForBailViewController.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/4/12.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "PayForBailViewController.h"
#import "TTTAttributedLabel.h"
#import "SpecialSingleModel.h"
#import "MyBottomBoxView.h"
#import "OneImgOptView.h"
#import "Api_SendSMSCode.h"
#import "Api_updateDepositInfoById.h"
#import "Api_UploadImage.h"
#import "Api_updatePayProof.h"
#import "DanChangJingJiaViewController.h"
#import "MyJingJiaListViewController.h"

@interface PayForBailViewController ()<UITableViewDataSource, UITableViewDelegate, TTTAttributedLabelDelegate, UITextFieldDelegate>
@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)NSMutableArray *dataSourceArray;
@property(strong, nonatomic)NSMutableArray *selectDataArray;

@property(strong, nonatomic)UIView *bottomView;
@property(strong, nonatomic)UILabel *priceLabel;
@property(strong, nonatomic)UIButton *payBtn;
@property(strong, nonatomic)TTTAttributedLabel *baozhengjin;
@property(strong, nonatomic)TTTAttributedLabel *xianxiafukuan;


@property(assign, nonatomic)NSIndexPath *selIndex;//单选，当前选中的行

@property(strong, nonatomic)UIButton *mobileCodeBtn;
@property(strong, nonatomic)UITextField *mobileCodeField;
@property(strong, nonatomic)UIButton *sendRequestBtn;
@property(copy, nonatomic)NSString *picUrl;
@property(strong, nonatomic)MyBottomBoxView *myBottomBoxView;
@end

@implementation PayForBailViewController
-(NSMutableArray *)dataSourceArray{
    if (!_dataSourceArray) {
        _dataSourceArray = [NSMutableArray new];
    }return _dataSourceArray;
}
-(NSMutableArray *)selectDataArray{
    if (!_selectDataArray) {
        _selectDataArray = [NSMutableArray new];
    }return _selectDataArray;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.sectionIndexTrackingBackgroundColor = [UIColor whiteColor];
        _tableView.sectionIndexColor = [UIColor groupTableViewBackgroundColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.allowsMultipleSelectionDuringEditing = YES;
        
        UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, kViewAtBottomHeight, 0);
        _tableView.contentInset = insets;
        _tableView.scrollIndicatorInsets = insets;
        
        
    }return _tableView;
}
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 50)];
        _bottomView.backgroundColor = [UIColor whiteColor];
        _bottomView.userInteractionEnabled = YES;
        CGFloat btnWidth = 100;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kScreen_Width -15 - btnWidth, CGRectGetHeight(_bottomView.frame))];
        label.font = [UIFont boldSystemFontOfSize:17];
        label.attributedText = [NSObject attributedStr:[NSString stringWithFormat:@"应付金额：%@",[NSObject moneyStyle:[NSString stringWithFormat:@"%ld",[self.tradeM.diNeedPay integerValue] - [self.tradeM.diHasPay integerValue]]] ] color:[UIColor redColor] length:5];
        [_bottomView addSubview:label];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(kScreen_Width - btnWidth, 0, btnWidth, CGRectGetHeight(_bottomView.frame));
        [btn setTitle:@"确认并支付" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
        [btn setBackgroundColor:kColorNav];
        [btn addTarget:self action:@selector(actionPayFor) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:btn];
        self.payBtn = btn;
    }return _bottomView;
}
static inline NSRegularExpression * NameRegularExpression() {
    static NSRegularExpression *_nameRegularExpression = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _nameRegularExpression = [[NSRegularExpression alloc] initWithPattern:@"^\\w+" options:NSRegularExpressionCaseInsensitive error:nil];
    });
    return _nameRegularExpression;
}
-(TTTAttributedLabel *)baozhengjin{
    if (!_baozhengjin) {
        _baozhengjin = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
        _baozhengjin.font = [UIFont systemFontOfSize:14];
        _baozhengjin.textColor = [UIColor blackColor];
        _baozhengjin.lineBreakMode = NSLineBreakByCharWrapping;
        _baozhengjin.numberOfLines = 0;
        //设置高亮颜色
        _baozhengjin.highlightedTextColor = [UIColor blueColor];
        //检测url
        _baozhengjin.enabledTextCheckingTypes = NSTextCheckingTypeLink;
        //对齐方式
        _baozhengjin.textAlignment = NSTextAlignmentLeft;
        _baozhengjin.delegate = self; // Delegate
        //NO 不显示下划线
        _baozhengjin.linkAttributes = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:(NSString *)kCTUnderlineStyleAttributeName];
        NSString *text = @"查看保证金使用说明";
        [_baozhengjin setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString){
            //设置可点击文字的范围
            NSRange boldRange = [[mutableAttributedString string] rangeOfString:@"查看保证金使用说明" options:NSCaseInsensitiveSearch];
            //设定可点击文字的的大小
            UIFont *boldSystemFont = [UIFont boldSystemFontOfSize:13];
            CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)boldSystemFont.fontName, boldSystemFont.pointSize, NULL);
            if (font) {
                //设置可点击文本的大小
                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:boldRange];
                //设置可点击文本的颜色
                [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[kColorNav CGColor] range:boldRange];
                CFRelease(font);
            }
            return mutableAttributedString;
        }];
        //        //正则
        NSRegularExpression *regexp = NameRegularExpression();
        NSRange linkRange = [regexp rangeOfFirstMatchInString:text options:0 range:NSMakeRange(0, 9)];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"baozhengjin://"]];
        //设置链接的url
        [_baozhengjin addLinkToURL:url withRange:linkRange];
    }return _baozhengjin;
}
-(TTTAttributedLabel *)xianxiafukuan{
    if (!_xianxiafukuan) {
        _xianxiafukuan = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
        _xianxiafukuan.font = [UIFont systemFontOfSize:14];
        _xianxiafukuan.lineBreakMode = NSLineBreakByCharWrapping;
        _xianxiafukuan.numberOfLines = 0;
        //设置高亮颜色
//        _xianxiafukuan.highlightedTextColor = [UIColor blueColor];
        //检测url
//        _xianxiafukuan.enabledTextCheckingTypes = NSTextCheckingTypeLink;
        //对齐方式
        _xianxiafukuan.textAlignment = NSTextAlignmentLeft;
        _xianxiafukuan.font = [UIFont systemFontOfSize:11];
        _xianxiafukuan.delegate = self; // Delegate
        //NO 不显示下划线
        _xianxiafukuan.linkAttributes = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:(NSString *)kCTUnderlineStyleAttributeName];
        NSString *text = @"线下付款注意事项";
        [_xianxiafukuan setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString){
            //设置可点击文字的范围
            NSRange boldRange = [[mutableAttributedString string] rangeOfString:@"线下付款注意事项" options:NSCaseInsensitiveSearch];
            //设定可点击文字的的大小
            UIFont *boldSystemFont = [UIFont boldSystemFontOfSize:13];
            CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)boldSystemFont.fontName, boldSystemFont.pointSize, NULL);
            if (font) {
                //设置可点击文本的大小
                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:boldRange];
                //设置可点击文本的颜色
                [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[kColorNav CGColor] range:boldRange];
                CFRelease(font);
            }
            return mutableAttributedString;
        }];
        //        //正则
        NSRegularExpression *regexp = NameRegularExpression();
        NSRange linkRange = [regexp rangeOfFirstMatchInString:text options:0 range:NSMakeRange(0, 8)];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"xianxiafukuan://"]];
        //设置链接的url
        [_xianxiafukuan addLinkToURL:url withRange:linkRange];
    }return _xianxiafukuan;
}
-(UITextField *)mobileCodeField{
    if (!_mobileCodeField) {
        _mobileCodeField = [[UITextField alloc] init];
        _mobileCodeField.placeholder = @"短信验证码";
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
        _mobileCodeBtn.userInteractionEnabled = YES;
        _mobileCodeBtn.alpha = 0.5;
        
        [_mobileCodeBtn addTarget:self action:@selector(actionMobileCode) forControlEvents:UIControlEventTouchUpInside];
    }return _mobileCodeBtn;
}
-(UIButton *)sendRequestBtn{
    if (!_sendRequestBtn) {
        CGFloat btnHeight = 44;
        CGFloat btnWidth = [UIScreen mainScreen].bounds.size.width - kMyPadding*2;
        
        _sendRequestBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendRequestBtn setSize:CGSizeMake(btnWidth, btnHeight)];
        [_sendRequestBtn setTitle:@"确认付款" forState:UIControlStateNormal];
        [_sendRequestBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sendRequestBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
        [_sendRequestBtn setCornerRadius:btnHeight/2];
        [_sendRequestBtn setBackgroundColor:kColorNav];
        [_sendRequestBtn addTarget:self action:@selector(actionSendRequestBtn) forControlEvents:UIControlEventTouchUpInside];
    }return _sendRequestBtn;
}
#pragma mark -生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付保证金";
    if (self.isSingle) {
        self.selIndex = [NSIndexPath indexPathForRow:0 inSection:1];
    }else{
        self.selIndex = [NSIndexPath indexPathForRow:0 inSection:2];
    }
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-kSafeBottomOffset);
        make.height.mas_equalTo(CGRectGetHeight(self.bottomView.frame));
    }];
    SpecialSingleModel *specialSingleM = [SpecialSingleModel new];
    specialSingleM.spicialName = @"专场标题";
    specialSingleM.bailMoney = @"$999999.00";
    
    SpecialSingleModel *specialSingleM1 = [SpecialSingleModel new];
    specialSingleM1.spicialName = @"专场标题1";
    specialSingleM1.bailMoney = @"$999999.00";
    
    SpecialSingleModel *specialSingleM2 = [SpecialSingleModel new];
    specialSingleM2.spicialName = @"专场标题2";
    specialSingleM2.bailMoney = @"$999999.00";
    
    SpecialSingleModel *specialSingleM3 = [SpecialSingleModel new];
    specialSingleM3.spicialName = @"专场标题3";
    specialSingleM3.bailMoney = @"$999999.00";
    
    SpecialSingleModel *specialSingleM4 = [SpecialSingleModel new];
    specialSingleM4.spicialName = @"专场标题4";
    specialSingleM4.bailMoney = @"$999999.00";
    
    SpecialSingleModel *specialSingleM5 = [SpecialSingleModel new];
    specialSingleM5.spicialName = @"专场标题5";
    specialSingleM5.bailMoney = @"$999999.00";
    
    self.dataSourceArray = [NSMutableArray arrayWithObjects:specialSingleM,specialSingleM1,specialSingleM2,specialSingleM3,specialSingleM4,specialSingleM5, nil];
    [self.tableView reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)configBottomBoxView_baozhengjin{
    MyBottomBoxView *boxView = [[MyBottomBoxView alloc]initWithFrame:CGRectMake(0, kScreen_Height, kScreen_Width, kScreen_Height*0.4)];
    [self.view.window addSubview:boxView];

    // 设置数据
    [boxView initWithTitle:@"保证金使用说明"];
    CGFloat scrollViewContentHeight = 0;
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, scrollViewContentHeight, kScreen_Width - 32, 300)];
        label.textColor = kColorNav;
        label.font = [UIFont systemFontOfSize:13];
        label.numberOfLines = 0;
        //
        NSMutableAttributedString * str1 = [[NSMutableAttributedString alloc] initWithString:@"1、此保证金仅用于该场次竞拍；\n2、您可以将通过线上支付方式缴纳保证金，或将保证金转账、汇入平台指定银行账户中；\n3、竞拍不成功，保证金将在竞拍结束的第一时间退回至您在闲置物资平台的账户中；\n"];
        NSDictionary * attri1 = @{ NSFontAttributeName:[UIFont boldSystemFontOfSize:13],NSForegroundColorAttributeName:[UIColor blackColor],}; [str1 setAttributes:attri1 range:NSMakeRange(0,str1.length)];
        //
        NSMutableAttributedString * str2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"4、本场竞拍需缴纳保证金 %@元，建议您使用线上支付，通过平台账户直接缴纳，到账迅速，安全无忧；\n",[NSObject moneyStyle:[NSString stringWithFormat:@"%ld",[self.tradeM.diNeedPay integerValue] - [self.tradeM.diHasPay integerValue]]]]];
        NSDictionary * attri2 = @{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:kColorNav,};
        [str2 setAttributes:attri2 range:NSMakeRange(0,str2.length)];
        //
        NSMutableAttributedString * str3 = [[NSMutableAttributedString alloc] initWithString:@"5、若您选择线下转账付款方式，请您转款完成后，第一时间将付款凭证上传至服务器中，用于平台的工作人员进行付款凭证的审核和查验，或致电客服热线 0315-3859900；"];
        NSDictionary * attri3 = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:13],NSForegroundColorAttributeName:[UIColor blackColor],};
        [str3 setAttributes:attri3 range:NSMakeRange(0,str3.length)];


        [str1 appendAttributedString:str2];
        [str1 appendAttributedString:str3];
        
        NSMutableParagraphStyle * paragraphStyle = [NSMutableParagraphStyle new];
        //调整行间距
        paragraphStyle.alignment = NSTextAlignmentLeft;
        paragraphStyle.lineSpacing = 5; //设置行间距
        paragraphStyle.firstLineHeadIndent = 10.0;//设置第一行缩进
        [str1 addAttributes:@{NSParagraphStyleAttributeName:paragraphStyle,NSKernAttributeName:@(1)} range:NSMakeRange(0, str1.length)];
        label.attributedText = str1;
        
        [boxView.scrollView addSubview:label];
        scrollViewContentHeight +=250;
    }

    boxView.scrollView.contentSize = CGSizeMake(kScreen_Width, scrollViewContentHeight+44);
    boxView.scrollView.backgroundColor = [UIColor whiteColor];

    // 显示弹框
    [boxView showBottomBoxView];
}
-(void)configBottomBoxView_xianxiafukuan{
    MyBottomBoxView *boxView = [[MyBottomBoxView alloc]initWithFrame:CGRectMake(0, kScreen_Height, kScreen_Width, kScreen_Height*0.3)];
    [self.view.window addSubview:boxView];
    
    // 设置数据
    [boxView initWithTitle:@"线下付款注意事项"];
    CGFloat scrollViewContentHeight = 0;
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, scrollViewContentHeight, kScreen_Width - 32, 100)];
        label.textColor = kColorNav;
        label.font = [UIFont systemFontOfSize:13];
        label.numberOfLines = 0;
        
        label.text = @"若您选择线下转账付款，请您转款完成后第一时间将付款凭证上传至服务器中，用于平台工作人员对付款凭证进行审核和查验，请耐心等待，或致电客服热线 0315-3859900；";
        [boxView.scrollView addSubview:label];
        scrollViewContentHeight +=100;
    }
    
    boxView.scrollView.contentSize = CGSizeMake(kScreen_Width, scrollViewContentHeight+44);
    boxView.scrollView.backgroundColor = [UIColor whiteColor];
    
    // 显示弹框
    [boxView showBottomBoxView];
}

-(void)configBottomBoxView_payForOnline{
    MyBottomBoxView *boxView = [[MyBottomBoxView alloc]initWithFrame:CGRectMake(0, kScreen_Height, kScreen_Width, kScreen_Height*0.6)];
    boxView.showInfoBtn = YES;
    self.myBottomBoxView = boxView;
    [self.view.window addSubview:boxView];
    
    Model_Account *accountM = self.tradeM.facUser.accounts.count>0? [self.tradeM.facUser.accounts objectAtIndex:0]:nil;
    if (!accountM) {
        return;
    }
    // 设置数据
    NSArray *titleArray = [NSArray arrayWithObjects:@"保证金应缴金额 ",@"支付方式",@"账户名称",@"支付账户",@"可用余额", nil];
    NSArray *detailArray = [NSArray arrayWithObjects:[NSObject moneyStyle:[NSString stringWithFormat:@"%ld",[self.tradeM.diNeedPay integerValue] - [self.tradeM.diHasPay integerValue]]],@"在线支付",accountM.zizhanghmc,accountM.zizhanghao, accountM.fbaBalance, nil];
    [boxView initWithTitle:@"付款至银行监管账户" titleArray:titleArray detailArray:detailArray imageArray:nil];
    CGFloat scrollViewContentHeight = 44*5;
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, scrollViewContentHeight, kScreen_Width - 32, 50)];
        label.textColor = kColorNav;
        label.font = [UIFont systemFontOfSize:13];
        label.numberOfLines = 0;
        
        NSMutableString * num = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@",self.tradeM.facUser.facPayMobil]];
        [num replaceCharactersInRange:NSMakeRange(3, 4)  withString:@"****"];
        
        label.text = [NSString stringWithFormat:@"向安全支付操作手机 %@ 发送支付验证码",num];
        [boxView.scrollView addSubview:label];
        scrollViewContentHeight +=50;
    }
    //验证码
    self.mobileCodeField.frame = CGRectMake(16, scrollViewContentHeight, kScreen_Width - 30, 44);
    [boxView.scrollView addSubview:self.mobileCodeField];
    scrollViewContentHeight +=44;
    
    
    
    [boxView.scrollView addSubview:self.sendRequestBtn];
    self.sendRequestBtn.frame = CGRectMake(16, scrollViewContentHeight, kScreen_Width - 32, 50);
    scrollViewContentHeight +=50;
    
    
    boxView.scrollView.contentSize = CGSizeMake(kScreen_Width, scrollViewContentHeight+44);
    boxView.scrollView.backgroundColor = [UIColor whiteColor];
    
    __weak typeof(self) weakSelf = self;
    boxView.clickBlock = ^(UIView *itemView) {
        if ([itemView isKindOfClass:[UIButton class]]) {
            MyBottomBoxView *iew = [[MyBottomBoxView alloc]initWithFrame:CGRectMake(0, kScreen_Height, kScreen_Width, kScreen_Height*0.5)];
            [self.view.window addSubview:iew];
            
            [iew initWithTitle:@"竞拍场次银行监管账户" titleArray:nil detailArray:nil imageArray:nil];
            CGFloat scrollViewContentHeight = 44*1;
            {
                UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height*0.5)];
                backView.backgroundColor = [UIColor whiteColor];
                [iew.scrollView addSubview:backView];
                UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, kScreen_Width - 30, 44)];
                label1.text = weakSelf.tradeM.tradeSite.zizhanghao;
                label1.textColor = UIColor.blueColor;
                [backView addSubview:label1];
                
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 44, kScreen_Width - 32, 150)];
                label.textColor = kColorNav;
                label.font = [UIFont systemFontOfSize:13];
                label.numberOfLines = 0;

                NSMutableAttributedString * str1 = [[NSMutableAttributedString alloc] initWithString:@"●监管账户介绍\n为了保障了买卖双方的交易资金安全，维护了买卖双方的权益。工平物资平台联合第三方银行机构打造安全支付手段--银行监管账户，让保证金、货款在竞拍过程中统一冻结，使竞拍流程更加公开、公平、透明！竞拍全程由银行方提供资金监管服务，安全无忧！"];
                NSDictionary * attri1 = @{ NSFontAttributeName:[UIFont boldSystemFontOfSize:13],NSForegroundColorAttributeName:[UIColor blackColor],}; [str1 setAttributes:attri1 range:NSMakeRange(0,str1.length)];
                NSMutableParagraphStyle * paragraphStyle = [NSMutableParagraphStyle new];
                //调整行间距
                paragraphStyle.alignment = NSTextAlignmentLeft;
                paragraphStyle.lineSpacing = 5; //设置行间距
                paragraphStyle.firstLineHeadIndent = 10.0;//设置第一行缩进
                [str1 addAttributes:@{NSParagraphStyleAttributeName:paragraphStyle,NSKernAttributeName:@(1)} range:NSMakeRange(0, str1.length)];
                label.attributedText = str1;
                
                [backView addSubview:label];
                scrollViewContentHeight +=50;
            }
            [iew showBottomBoxView];

        }
        if (itemView.tag == 100) {// 点击选项一
            NSLog(@"1");
        }
        if (itemView.tag == 101) {// 点击选项二
            NSLog(@"2");
        }
        if (itemView.tag == 102) {// 点击选项三
            
        }
        BoxItemView *itemView1 = (BoxItemView*)itemView;
        //        [tanKuangView1 closeBottomBoxView];
    };
    
    
    // 显示弹框
    [boxView showBottomBoxView];
}
-(void)configBottomBoxView_payForOffline{
    MyBottomBoxView *boxView = [[MyBottomBoxView alloc]initWithFrame:CGRectMake(0, kScreen_Height, kScreen_Width, kScreen_Height*0.8)];
    boxView.showInfoBtn = YES;
    self.myBottomBoxView = boxView;
    [self.view addSubview:boxView];
    Model_Account *accountM = self.tradeM.facUser.accounts.count>0? [self.tradeM.facUser.accounts objectAtIndex:0]:nil;
    if (!accountM) {
        return;
    }
    
    
    // 设置数据
    NSArray *titleArray = [NSArray arrayWithObjects:@"保证金应缴金额 ",@"户名",@"账号：",@"开户行", nil];
    NSArray *detailArray = [NSArray arrayWithObjects:[NSObject moneyStyle:[NSString stringWithFormat:@"%ld",[self.tradeM.diNeedPay integerValue] - [self.tradeM.diHasPay integerValue]]],accountM.zhanghumc,accountM.zhuzhanghao,@"平安银行", nil];
    [boxView initWithTitle:@"付款至银行监管账户" titleArray:titleArray detailArray:detailArray imageArray:nil];
    CGFloat scrollViewContentHeight = 44*4;
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, scrollViewContentHeight, kScreen_Width - 32, 90)];
        label.textColor = kColorNav;
        label.font = [UIFont systemFontOfSize:13];
        label.numberOfLines = 0;
        label.text = @"请将保证金转账、汇入至以上指定账户中，付款完成上传付款凭证、\n上传凭证后，工作人员将在第一时间审核您的付款凭证，请您耐心等待，或致电客服热线了解审核进程   0315-3859900；";
        [boxView.scrollView addSubview:label];
        scrollViewContentHeight +=90;
    }
    //验证码
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 100)];
//    {
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, scrollViewContentHeight, kScreen_Width - 32, 50)];
//        label.textColor = kColorNav;
//        label.font = [UIFont systemFontOfSize:13];
//        label.numberOfLines = 0;
//        label.textAlignment = NSTextAlignmentRight;
//        label.text = @"$9999999999.99 " ;
//        [boxView.scrollView addSubview:label];
//    }
    CGFloat imgWidth = (kScreen_Width -kMyPadding *4)/3;
    __weak typeof(self) weakSelf = self;

    {
        OneImgOptView *imageOptView = [[OneImgOptView alloc] initWithFrame:CGRectMake(kMyPadding, scrollViewContentHeight, imgWidth, imgWidth+20+30)];
        OneImgOptViewModel *model = [[OneImgOptViewModel alloc] init];
        imageOptView.oneImgViewM = model;
        imageOptView.parentVC = self;
        imageOptView.selectedBlock = ^(UIImage *selectImage) {
            Api_UploadImage *api = [[Api_UploadImage alloc] initWithImage:selectImage];
            api.animatingText = @"正在上传数据...";
            api.animatingView = weakSelf.view;
            [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                if ([request.responseJSONObject[@"code"] integerValue] == 200) {
                    weakSelf.picUrl = api.responseImageId;
                    
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
        [boxView.scrollView addSubview:imageOptView];
        scrollViewContentHeight +=imgWidth+20+30;

    }
    
    [boxView.scrollView addSubview:self.sendRequestBtn];
    self.sendRequestBtn.frame = CGRectMake(16, scrollViewContentHeight, kScreen_Width - 32, 50);
    scrollViewContentHeight +=50;
    
    boxView.scrollView.contentSize = CGSizeMake(kScreen_Width, scrollViewContentHeight+44);
    boxView.scrollView.backgroundColor = [UIColor whiteColor];
    
    
    boxView.clickBlock = ^(UIView *itemView) {
        if ([itemView isKindOfClass:[UIButton class]]) {
            MyBottomBoxView *iew = [[MyBottomBoxView alloc]initWithFrame:CGRectMake(0, kScreen_Height, kScreen_Width, kScreen_Height*0.5)];
            [self.view.window addSubview:iew];
            
            [iew initWithTitle:@"竞拍场次银行监管账户" titleArray:nil detailArray:nil imageArray:nil];
            CGFloat scrollViewContentHeight = 44*1;
            {
                UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height*0.5)];
                backView.backgroundColor = [UIColor whiteColor];
                [iew.scrollView addSubview:backView];
                UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, kScreen_Width - 30, 44)];
                label1.text = weakSelf.tradeM.tradeSite.zizhanghao;
                label1.textColor = UIColor.blueColor;
                [backView addSubview:label1];
                
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 44, kScreen_Width - 32, 150)];
                label.textColor = kColorNav;
                label.font = [UIFont systemFontOfSize:13];
                label.numberOfLines = 0;
                
                NSMutableAttributedString * str1 = [[NSMutableAttributedString alloc] initWithString:@"●监管账户介绍\n为了保障了买卖双方的交易资金安全，维护了买卖双方的权益。工平物资平台联合第三方银行机构打造安全支付手段--银行监管账户，让保证金、货款在竞拍过程中统一冻结，使竞拍流程更加公开、公平、透明！竞拍全程由银行方提供资金监管服务，安全无忧！"];
                NSDictionary * attri1 = @{ NSFontAttributeName:[UIFont boldSystemFontOfSize:13],NSForegroundColorAttributeName:[UIColor blackColor],}; [str1 setAttributes:attri1 range:NSMakeRange(0,str1.length)];
                NSMutableParagraphStyle * paragraphStyle = [NSMutableParagraphStyle new];
                //调整行间距
                paragraphStyle.alignment = NSTextAlignmentLeft;
                paragraphStyle.lineSpacing = 5; //设置行间距
                paragraphStyle.firstLineHeadIndent = 10.0;//设置第一行缩进
                [str1 addAttributes:@{NSParagraphStyleAttributeName:paragraphStyle,NSKernAttributeName:@(1)} range:NSMakeRange(0, str1.length)];
                label.attributedText = str1;
                
                [backView addSubview:label];
                scrollViewContentHeight +=50;
            }
            [iew showBottomBoxView];
            
        }
        if (itemView.tag == 100) {// 点击选项一
            NSLog(@"1");
        }
        if (itemView.tag == 101) {// 点击选项二
            NSLog(@"2");
        }
        if (itemView.tag == 102) {// 点击选项三
            
        }
        BoxItemView *itemView1 = (BoxItemView*)itemView;
        //        [tanKuangView1 closeBottomBoxView];
    };
    // 显示弹框
    [boxView showBottomBoxView];
}
#pragma mark - Action
-(void)actionPayFor{
    if (self.selIndex.row == 0) {
        NSLog(@"在线支付");
        [self configBottomBoxView_payForOnline];
    }else{
        NSLog(@"线下支付");
        [self configBottomBoxView_payForOffline];
    }
}
-(void)actionMobileCode{
    Api_SendSMSCode *SendUpdateLoginMobileCodeApi = [[Api_SendSMSCode alloc] initWithMobile:self.tradeM.facUser.facPayMobil type:@"6"];
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
//                        [UIView beginAnimations:nil context:nil];
//                        [UIView setAnimationDuration:1];
//                        [UIView commitAnimations];
                        
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
        NSLog(@"succeed");
        NSLog(@"requestArgument:%@",request.requestArgument);
        NSLog(@"response:%@",request.response);
        NSLog(@"responseJSONObject:%@",request.responseJSONObject);
    } failure:^(__kindof YTKBaseRequest *request) {
        NSLog(@"SendUpdateLoginMobileCodeApi failed");
        
    }];
}
-(void)actionDismiss{
    [self.myBottomBoxView closeBottomBoxView];
    //                [self.navigationController popViewControllerAnimated:YES];
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[DanChangJingJiaViewController class]]) {
            DanChangJingJiaViewController *A =(DanChangJingJiaViewController *)controller;
            A.selectedPage = 1;
            [self.navigationController popToViewController:A animated:YES];
        }
    }
}
-(void)actionSendRequestBtn{
    if (self.selIndex.row == 0) {
        NSLog(@"在线支付");
        if (![NSObject isString:self.mobileCodeField.text]) {
            [NSObject ToastShowStr:@"请输入验证码"];
            return;
        }
        Api_updateDepositInfoById *api = [[Api_updateDepositInfoById alloc] initWithdiId:self.tradeM.diId withPhoneCode:self.mobileCodeField.text];
        api.animatingText = @"正在上传数据";
        api.animatingView = self.view.window;
        [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            if ([request.responseJSONObject[@"success"] integerValue] == 1) {
                [NSObject ToastShowStr:@"支付保证金成功"];
                [self actionDismiss];

            }
            else if ([request.responseJSONObject[@"success"] integerValue] == 0){
                NSString *str = request.responseJSONObject[@"message"];
                [NSObject ToastShowStr:str];
            }
            NSLog(@"succeed");
            NSLog(@"requestArgument:%@",request.requestArgument);
            NSLog(@"response:%@",request.response);
            NSLog(@"responseJSONObject:%@",request.responseJSONObject);
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            [NSObject ToastShowStr:@"提交失败"];
            NSLog(@"failed");
            NSLog(@"requestArgument:%@",request.requestArgument);
            NSLog(@"response:%@",request.response);
            NSLog(@"responseJSONObject:%@",request.responseJSONObject);
        }];
    }else{
        NSLog(@"线下支付");
        if (![NSObject isString:self.picUrl]) {
            [NSObject ToastShowStr:@"请上传凭证"];
            return;
        }
        Api_updatePayProof *api = [[Api_updatePayProof alloc] initWithdiId:self.tradeM.diId payProof:self.picUrl];
        api.animatingText = @"正在上传数据";
        api.animatingView = self.view.window;
        [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            if ([request.responseJSONObject[@"success"] integerValue] == 1) {
                [NSObject ToastShowStr:@"提交成功"];
                [self.myBottomBoxView closeBottomBoxView];
                [self.navigationController popViewControllerAnimated:YES];
                NSMutableArray *marr = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
                for (UIViewController *vc in marr) {
                    if ([vc isKindOfClass:[DanChangJingJiaViewController class]]) {
                        [marr removeObject:vc];
                        break;
                    }
                }
                self.navigationController.viewControllers = marr;
//                DanChangJingJiaViewController *vc = [[DanChangJingJiaViewController alloc]init];
//                vc.selectedPage = 2;
//                [self.navigationController pushViewController:vc animated:YES];

            }
            else if ([request.responseJSONObject[@"success"] integerValue] == 0){
                NSString *str = request.responseJSONObject[@"message"];
                [NSObject ToastShowStr:str];
            }
            NSLog(@"succeed");
            NSLog(@"requestArgument:%@",request.requestArgument);
            NSLog(@"response:%@",request.response);
            NSLog(@"responseJSONObject:%@",request.responseJSONObject);
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            [NSObject ToastShowStr:@"提交失败"];
            NSLog(@"failed");
            NSLog(@"requestArgument:%@",request.requestArgument);
            NSLog(@"response:%@",request.response);
            NSLog(@"responseJSONObject:%@",request.responseJSONObject);
        }];
    }
}
-(void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url{
    if ([url.scheme isEqualToString:@"baozhengjin"]) {
        NSLog(@"保证金");
        [self configBottomBoxView_baozhengjin];
    }else if ([url.scheme isEqualToString:@"xianxiafukuan"]){
        NSLog(@"注意事项");
        [self configBottomBoxView_xianxiafukuan];
    }
}

#pragma mark - UITableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.isSingle) {
        return 2;
    }else{
        return 3;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        if (self.isSingle) {
            return 2;
        }else{
            return self.dataSourceArray.count;
        }
    }else{
        return 2;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (self.isSingle) {
            return 100;
        }else{
            return 50;
        }
    }
    if ((indexPath.section == 1&& self.isSingle == YES)||(indexPath.section == 2&& self.isSingle == NO)) {
        return 100;
    }
    else{
        return 50;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"竞价场次";
    }else{
        if (self.isSingle == NO && section == 2) {
            return @"支付方式";
        }else if (self.isSingle == YES && section == 1){
            return @"支付方式";
        }
        return @"场次";
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CGFloat height = [self tableView:tableView heightForHeaderInSection:section];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), height)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
    if (sectionTitle == nil) {
        return nil;
    }
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(16, 0, CGRectGetWidth(tableView.frame)-16, height);
    label.backgroundColor = [UIColor clearColor];
    
    label.textColor = [UIColor grayColor];
    label.shadowColor = [UIColor whiteColor];
    label.shadowOffset = CGSizeMake(0.0, 1.0);
    label.font = [UIFont boldSystemFontOfSize:16];
    label.text = sectionTitle;
    [view addSubview:label];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 30;
    }else{
        if (self.isSingle == NO && section == 2) {
            return 30;
        }else if (self.isSingle == YES && section == 1){
            return 30;
        }
        return CGFLOAT_MIN;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    CGFloat height = [self tableView:tableView heightForFooterInSection:section];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, height)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    if (section == 0) {
        self.baozhengjin.frame = CGRectMake(16, 0, kScreen_Width - 32, height);
        [view addSubview:self.baozhengjin];
    }
    if ((self.isSingle == NO && section == 2)||(self.isSingle == YES && section == 1)) {
        self.xianxiafukuan.frame = CGRectMake(16, 0, kScreen_Width - 32,  height);
        [view addSubview:self.xianxiafukuan];
    }
    return view;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isSingle) {
#pragma mark -单场竞价
        static NSString *cellIdentifier = @"cellid";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        }
        else{
            while ([cell.contentView.subviews lastObject] != nil) {
                [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        cell.backgroundColor = [UIColor whiteColor];
        cell.tintColor = kColorNav;
        NSString *textStr = @"";
        NSString *detailTextStr = @"";
        if (indexPath.section == 0) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 100)];
            {//场次名称
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 3, kScreen_Width - 30, 30)];
                label.attributedText = [NSObject attributedStr:[NSString stringWithFormat:@"场次名称:%@",self.tradeM.tradeSite.tsName] color:[UIColor grayColor] length:5];
                label.font = [UIFont systemFontOfSize:13];
                [view addSubview:label];
            }
            {//场次编号
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 33, kScreen_Width - 30, 30)];
                label.attributedText = [NSObject attributedStr:[NSString stringWithFormat:@"场次编号:%@",self.tradeM.tradeSite.tsTradeNo] color:[UIColor grayColor] length:5];
                label.font = [UIFont systemFontOfSize:13];
                [view addSubview:label];
            }
            {//竞价开始时间
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 63, kScreen_Width - 30, 30)];
                label.attributedText = [NSObject attributedStr:[NSString stringWithFormat:@"竞价开始时间:%@",self.tradeM.tradeSite.tsStartTime] color:[UIColor grayColor] length:7];
                label.font = [UIFont systemFontOfSize:13];
                [view addSubview:label];
            }
            [cell.contentView addSubview:view];
        }else{
            if (indexPath.row == 0) {
                textStr = @"在线支付";
                detailTextStr = @"通过已开通的线上竞拍账户直接缴纳保证金，到账迅速，无序审核，便捷无忧;";
            }else{
                textStr = @"线下支付";
                detailTextStr = @"通过线下转账至平台指定保证金账户，并上传转账凭证，平台工作人员通过审核后，即可参与竞拍;";
            }
            
            cell.textLabel.text = textStr;
            cell.textLabel.font = [UIFont systemFontOfSize:17];
            
            cell.detailTextLabel.text = detailTextStr;
            cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
            cell.detailTextLabel.numberOfLines = 0;
            [cell.detailTextLabel sizeToFit];
            cell.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
            [cell.detailTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.mas_left).offset(15);
                make.right.equalTo(cell.mas_right).offset(-50);
                make.top.equalTo(cell.textLabel.mas_bottom).offset(3);
            }];
            
            //当上下拉动的时候，因为cell的复用性，我们需要重新判断一下哪一行是打勾的
            if (_selIndex == indexPath) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }else {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }

        return cell;
    }else{
#pragma mark -多场竞价
        if (indexPath.section == 0) {
#pragma mark 竞价场次
            static NSString *cellIdentifier = @"cellid";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            }
            else{
                while ([cell.contentView.subviews lastObject] != nil) {
                    [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
                }
            }
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            cell.backgroundColor = [UIColor clearColor];
            cell.tintColor = kColorNav;
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 100)];
            {//场次名称
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 3, kScreen_Width - 30, 20)];
                label.attributedText = [NSObject attributedStr:[NSString stringWithFormat:@"场次名称:%@",@"银色星芒刺绣网纱底裤"] color:[UIColor grayColor] length:5];
                label.font = [UIFont systemFontOfSize:13];
                [view addSubview:label];
            }
            {//竞价开始时间
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 23, kScreen_Width - 30, 20)];
                label.attributedText = [NSObject attributedStr:[NSString stringWithFormat:@"竞价开始时间:%@",@"2018-02-05 18：00：00"] color:[UIColor grayColor] length:7];
                label.font = [UIFont systemFontOfSize:13];
                [view addSubview:label];
            }
            [cell.contentView addSubview:view];
            return cell;

        }else if (indexPath.section == 1){
#pragma mark 场次
            SpecialSingleModel *model = [self.dataSourceArray objectAtIndex:indexPath.row];
            
            static NSString *cellIdentifier = @"cellid";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
            }
            else{
                while ([cell.contentView.subviews lastObject] != nil) {
                    [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
                }
            }
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            cell.backgroundColor = [UIColor clearColor];
            cell.tintColor = kColorNav;
            NSString *textStr = @"";
            NSString *detailTextStr = @"";

            textStr = [NSString stringWithFormat:@"专场名词：%@;",model.spicialName];
            detailTextStr = [NSString stringWithFormat:@"保证金：%@;",model.bailMoney];
            
            cell.textLabel.text = textStr;
            cell.textLabel.font = [UIFont systemFontOfSize:17];
            
            cell.detailTextLabel.text = detailTextStr;
            cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
            cell.detailTextLabel.numberOfLines = 0;
            [cell.detailTextLabel sizeToFit];
            cell.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
            if ([self.selectDataArray containsObject:model]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            else {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            return cell;
        }else{
#pragma mark 支付方式
            static NSString *cellIdentifier = @"cellid";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            }
            else{
                while ([cell.contentView.subviews lastObject] != nil) {
                    [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
                }
            }
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            cell.backgroundColor = [UIColor clearColor];
            cell.tintColor = kColorNav;
            NSString *textStr = @"";
            NSString *detailTextStr = @"";
            if (indexPath.section == 1) {
                
            }
            if (indexPath.section == 2) {
                if (indexPath.row == 0) {
                    textStr = @"在线支付";
                    detailTextStr = @"通过已开通的线上竞拍账户直接缴纳保证金，到账迅速，无序审核，便捷无忧;";
                }else{
                    textStr = @"线下支付";
                    detailTextStr = @"通过线下转账至平台指定保证金账户，并上传转账凭证，平台工作人员通过审核后，即可参与竞拍;";
                }
                
                cell.textLabel.text = textStr;
                cell.textLabel.font = [UIFont systemFontOfSize:17];
                
                cell.detailTextLabel.text = detailTextStr;
                cell.detailTextLabel.textColor = [UIColor grayColor];
                cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
                cell.detailTextLabel.numberOfLines = 0;
                [cell.detailTextLabel sizeToFit];
                cell.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
                [cell.detailTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(cell.mas_left).offset(15);
                    make.right.equalTo(cell.mas_right).offset(-50);
                    make.top.equalTo(cell.textLabel.mas_bottom).offset(3);
                }];
                
                //当上下拉动的时候，因为cell的复用性，我们需要重新判断一下哪一行是打勾的
                if (_selIndex == indexPath) {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                }else {
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
            }
            return cell;
        }
    }
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ((indexPath.section == 1&& self.isSingle == YES)||(indexPath.section == 2&& self.isSingle == NO)) {
        
    }
    if (self.isSingle) {
        if (indexPath.section == 1) {
            //之前选中的，取消选择
            UITableViewCell *celled = [tableView cellForRowAtIndexPath:_selIndex];
            celled.accessoryType = UITableViewCellAccessoryNone;
            //记录当前选中的位置索引
            _selIndex = indexPath;
            //当前选择的打勾
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }else{
        if (indexPath.section == 1) {
            //之前选中的，取消选择
            SpecialSingleModel *model = [self.dataSourceArray objectAtIndex:indexPath.row];
            UITableViewCell *celled = [tableView cellForRowAtIndexPath:indexPath];
            if (celled.accessoryType == UITableViewCellAccessoryNone) {
                celled.accessoryType = UITableViewCellAccessoryCheckmark;
                [self.selectDataArray addObject:model];
            }else{
                [self.selectDataArray removeObject:model];
                celled.accessoryType = UITableViewCellAccessoryNone;
            }
            NSLog(@"已经选中的产品数量%lu",(unsigned long)self.selectDataArray.count);

        }
        else if (indexPath.section == 2) {
            //之前选中的，取消选择
            UITableViewCell *celled = [tableView cellForRowAtIndexPath:_selIndex];
            celled.accessoryType = UITableViewCellAccessoryNone;
            //记录当前选中的位置索引
            _selIndex = indexPath;
            //当前选择的打勾
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
    
    
//    self.dataSourceArray = [[NSMutableArray alloc] initWithObjects:@"", @"", @"", @"", nil];
//    [self.myTableView reloadData];
//
//    self.headM = [HeadeModel new];
//    self.headM.titleName = @"平安银行";
//    self.headM.accountNumber = @"1000000000000";
//    self.headM.accountName = @"河北修远科技有限公司";
//    self.headM.accountTime = @"2018-08-08 10:00:00";
//    self.headM.allMoney = @"$888888888.88";
//    self.headM.canuseMoney = @"$888888888.88";
//    self.headM.frazeMoney = @"0";
//
//    self.myTableView.tableHeaderView =  self.tableHeaderView;
//
//
//    Record_ChujinViewController *vc = [Record_ChujinViewController new];
//    [self.navigationController pushViewController:vc animated:YES];
//
//
}

@end
