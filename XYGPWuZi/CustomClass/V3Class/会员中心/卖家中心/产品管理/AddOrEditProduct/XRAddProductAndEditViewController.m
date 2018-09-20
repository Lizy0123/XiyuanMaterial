//
//  XRAddProductAndEditViewController.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/9/26.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "XRAddProductAndEditViewController.h"

#import "LLImagePickerView.h"
#import "XRProductUintTableViewController.h"
#import "XRProductStatusTableViewController.h"
#import "SecondViewController.h"
#import "AddressManageerViewController.h"
#import "STPickerDate.h"
#import "XRAddProductTwoViewController.h"
#import "ZZTableViewController.h"

#import "AddProductViewController.h"

#define DzyWid ([UIScreen mainScreen].bounds.size.width)
#define DzyHei ([UIScreen mainScreen].bounds.size.height)
#define photoViewHeight (S_W/4)+5
#define kCellHeght 44

@interface XRAddProductAndEditViewController ()<UITextFieldDelegate,STPickerDateDelegate,UIGestureRecognizerDelegate>

@property (nonatomic,strong) NSMutableArray *data;

@property (nonatomic,strong) NSMutableArray *imageUrlData;

@property (nonatomic,strong)UIButton *bottomButton;

@property(nonatomic,strong)UIButton *numAddBtn;

@property(nonatomic,strong)UIButton *numSubtractBtn;

@property (nonatomic,strong) LLImagePickerView * pickerV;

@end

@implementation XRAddProductAndEditViewController


-(id)init{
    
    if (self = [super init]) {
        
        [self setupUI];
        [self bottomBtn];
    }
    return self;
}

-(void)setImageUrlArray:(NSMutableArray *)imageUrlArray{
    _imageUrlArray = imageUrlArray;
    self.imageUrlData = [NSMutableArray new];
    NSLog(@"---imageUrlArray--%@",imageUrlArray);
    CGFloat height = [LLImagePickerView defaultViewHeight];
    UIView *headerV = [UIView new];
    
    _pickerV = [[LLImagePickerView alloc]initWithFrame:CGRectMake(0, 5, [UIScreen mainScreen].bounds.size.width, height)];
    _pickerV.showDelete = YES;
    _pickerV.showAddButton = YES;
    _pickerV.maxImageSelected = 4;
    _pickerV.allowMultipleSelection = NO;
    _pickerV.allowPickingVideo = NO;
    
    [_pickerV observeAddItemSelected:^{
        NSLog(@"点击了添加按钮");
        [self.view endEditing:YES];
    }];
    // 动态变换高度
    [_pickerV observeViewHeight:^(CGFloat height) {
        CGRect rect = headerV.frame;
        rect.size.height = CGRectGetMaxY(_pickerV.frame);
        headerV.frame = rect;
    }];
     if (imageUrlArray.count>0) {
        _pickerV.preShowMedias = imageUrlArray;
         self.imageUrlData = [imageUrlArray mutableCopy];
    }
    NSLog(@"编辑之前的url----%@",self.imageUrlData);
    __weak typeof(self)weakSelf = self;
    [_pickerV observeSelectedMediaArray:^(NSArray<LLImagePickerModel *> *list) {
        weakSelf.data = [NSMutableArray new];
        [weakSelf.imageUrlData removeAllObjects];
        for (LLImagePickerModel *model in list) {
            // 在这里取到模型的数据
            if (model.image) {
                [weakSelf.data addObject:model.image];
            }else if (model.imageUrlString){
                [weakSelf.imageUrlData addObject:model.imageUrlString];
            }
        }
        NSLog(@"--图片url-%@\n图片数据-%@",weakSelf.imageUrlData,weakSelf.data);
    }];
    [headerV addSubview:_pickerV];
    headerV.frame = CGRectMake(0, 0, self.view.frame.size.width, CGRectGetMaxY(_pickerV.frame)+5);
    [_backGroundScrollView addSubview:headerV];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
}
#pragma mark - 界面布局
-(void)setupUI{

    _backGroundScrollView = [[UIScrollView alloc]initWithFrame:CGRectZero];
    _backGroundScrollView.backgroundColor = [UIColor whiteColor];
    _backGroundScrollView.bounces = YES;
    _backGroundScrollView.alwaysBounceVertical = YES;
    _backGroundScrollView.alwaysBounceHorizontal = NO;
    _backGroundScrollView.pagingEnabled = NO;
    _backGroundScrollView.showsVerticalScrollIndicator = YES;
    _backGroundScrollView.showsHorizontalScrollIndicator = NO;
    _backGroundScrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    _backGroundScrollView.scrollsToTop = YES;
    [self.view addSubview:_backGroundScrollView];
    [_backGroundScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        
    }];

    //画12条线
    for (int i = 0; i<12; i++) {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, photoViewHeight+(i*kCellHeght), S_W, 0.3)];
        line.backgroundColor = [UIColor grayColor];
        [_backGroundScrollView addSubview:line];
        
    }
    //添加手势点击
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    tap.numberOfTapsRequired = 1;
    tap.delegate = self;
    [self.backGroundScrollView addGestureRecognizer:tap];
    
   
    
    [self layoutAllLabels];
    [self layoutGlobalVariable];
}


-(void)bottomBtn{
    
    
    self.bottomButton = [UIButton buttonWithStyle:StrapDefaultStyle andTitle:@"下一步" andFrame:CGRectMake(1, 1, 1, 44) target:self action:@selector(next)];
    [self.view addSubview:_bottomButton];
    [self.bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(S_W-32, 44));
        make.left.equalTo(self.view).offset(16);
        make.bottom.equalTo(self.view).offset(-kSafeAreaBottomHeight-6);
        
    }];
    
    //右上角按钮
    UIBarButtonItem *rightLoginBtn = [[UIBarButtonItem alloc]initWithTitle:@"下一步" style:UIBarButtonItemStyleDone target:self action:@selector(addProductVC)];
    self.navigationItem.rightBarButtonItem = rightLoginBtn;
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
}
-(void)addProductVC{
    [self.navigationController pushViewController:[AddProductViewController new] animated:YES];
}
-(void)layoutAllLabels{
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(kMyPadding, photoViewHeight +12, 70, 20)];
    label1.text = @"品名";
    label1.font = [UIFont systemFontOfSize:13];
    label1.textColor = [UIColor blackColor];
    [_backGroundScrollView addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(kMyPadding, photoViewHeight +12+kCellHeght, 70, 20)];
    label2.text = @"产品类别";
    label2.font = [UIFont systemFontOfSize:13];
    label2.textColor = [UIColor blackColor];
    [_backGroundScrollView addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(kMyPadding, photoViewHeight +12+kCellHeght*2, 70, 20)];
    label3.text = @"数量";
    label3.font = [UIFont systemFontOfSize:13];
    label3.textColor = [UIColor blackColor];
    [_backGroundScrollView addSubview:label3];
    
    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(kMyPadding, photoViewHeight +12+kCellHeght*3, 70, 20)];
    label4.text = @"产品型号";
    label4.font = [UIFont systemFontOfSize:13];
    label4.textColor = [UIColor blackColor];
    [_backGroundScrollView addSubview:label4];
    
    UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(kMyPadding, photoViewHeight +12+kCellHeght*4, 70, 20)];
    label5.text = @"品牌";
    label5.font = [UIFont systemFontOfSize:13];
    label5.textColor = [UIColor blackColor];
    [_backGroundScrollView addSubview:label5];
    
    UILabel *label6 = [[UILabel alloc]initWithFrame:CGRectMake(kMyPadding, photoViewHeight +12+kCellHeght*5, 70, 20)];
    label6.text = @"新旧程度";
    label6.font = [UIFont systemFontOfSize:13];
    label6.textColor = [UIColor blackColor];
    [_backGroundScrollView addSubview:label6];
    
    UILabel *label7 = [[UILabel alloc]initWithFrame:CGRectMake(kMyPadding, photoViewHeight +12+kCellHeght*6, 70, 20)];
    label7.text = @"当前状态";
    label7.font = [UIFont systemFontOfSize:13];
    label7.textColor = [UIColor blackColor];
    [_backGroundScrollView addSubview:label7];
    
    UILabel *label8 = [[UILabel alloc]initWithFrame:CGRectMake(kMyPadding, photoViewHeight +12+kCellHeght*7, 70, 20)];
    label8.text = @"工作小时";
    label8.font = [UIFont systemFontOfSize:13];
    label8.textColor = [UIColor blackColor];
    [_backGroundScrollView addSubview:label8];
    
    UILabel *label9 = [[UILabel alloc]initWithFrame:CGRectMake(kMyPadding, photoViewHeight +12+kCellHeght*8, 70, 20)];
    label9.text = @"日期选择";
    label9.font = [UIFont systemFontOfSize:13];
    label9.textColor = [UIColor blackColor];
    [_backGroundScrollView addSubview:label9];
    
    UILabel *label10 = [[UILabel alloc]initWithFrame:CGRectMake(kMyPadding, photoViewHeight +12+kCellHeght*9, 70, 20)];
    label10.text = @"最低出售价";
    label10.font = [UIFont systemFontOfSize:13];
    label10.textColor = [UIColor blackColor];
    [_backGroundScrollView addSubview:label10];
    
    UILabel *label11 = [[UILabel alloc]initWithFrame:CGRectMake(kMyPadding, photoViewHeight +12+kCellHeght*10, 70, 20)];
    label11.text = @"所在区域";
    label11.font = [UIFont systemFontOfSize:13];
    label11.textColor = [UIColor blackColor];
    [_backGroundScrollView addSubview:label11];
    
    
    _backGroundScrollView.contentSize = CGSizeMake(S_W, photoViewHeight +12+kCellHeght*11+kViewAtBottomHeight);
    
}
-(void)layoutGlobalVariable{
    
    
    self.nameField = [[UITextField alloc]initWithFrame:CGRectMake(100, photoViewHeight+12, S_W-100-20, 20)];
    _nameField.placeholder = @"必填，请填写";
    _nameField.borderStyle = UITextBorderStyleNone;
    _nameField.font = [UIFont systemFontOfSize:13];
    _nameField.textAlignment = NSTextAlignmentLeft;
    _nameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_backGroundScrollView addSubview:_nameField];
    
    
    self.numSubtractBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _numSubtractBtn.frame = CGRectMake(100, photoViewHeight+12+kCellHeght*2, 20, 20);
    _numSubtractBtn.backgroundColor = [UIColor redColor];
    [_numSubtractBtn addTarget:self action:@selector(NumSub) forControlEvents:UIControlEventTouchUpInside];
    [_numSubtractBtn setBackgroundImage:[UIImage imageNamed:@"subBtnBackground"] forState:UIControlStateNormal];
    //[_numSubtractBtn setImage:[UIImage imageNamed:@"subBtnBackground"] forState:UIControlStateNormal];
    [_backGroundScrollView addSubview:_numSubtractBtn];
    
    _numberField = [[UITextField alloc]initWithFrame:CGRectMake(100+20+10, photoViewHeight+12+kCellHeght*2, 70, 20)];
    _numberField.text = @"0";
    _numberField.delegate = self;
    _numberField.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _numberField.borderStyle = UITextBorderStyleNone;
    _numberField.font = [UIFont systemFontOfSize:13];
    _numberField.textAlignment = NSTextAlignmentCenter;
    _numberField.keyboardType = UIKeyboardTypePhonePad;
    _numberField.clearButtonMode = UITextFieldViewModeNever;
    [_backGroundScrollView addSubview:_numberField];
    
    self.numAddBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _numAddBtn.frame = CGRectMake(100+20+10+70+10, photoViewHeight+12+kCellHeght*2, 20, 20);
    //_numAddBtn.backgroundColor = [UIColor redColor];
    //[_numAddBtn setImage:[UIImage imageNamed:@"addBtnBackground"] forState:UIControlStateNormal];
    [_numAddBtn setBackgroundImage:[UIImage imageNamed:@"addBtnBackground"] forState:UIControlStateNormal];
    [_numAddBtn addTarget:self action:@selector(NumAdd) forControlEvents:UIControlEventTouchUpInside];
    [_backGroundScrollView addSubview:_numAddBtn];

    UIButton *button0 = [UIButton buttonWithType:UIButtonTypeCustom];
    button0.frame = CGRectMake(100, photoViewHeight+12+kCellHeght, S_W-100-20, 20);
    //button1.backgroundColor = [UIColor cyanColor];
    [button0 addTarget:self action:@selector(choseProductLeibie) forControlEvents:UIControlEventTouchUpInside];
    [_backGroundScrollView addSubview:button0];
    
    UIImageView *rightImage0 = [[UIImageView alloc]initWithFrame:CGRectMake(S_W-100-20-12, 0, 12, 20)];
    rightImage0.image = [UIImage imageNamed:@"ico_zhixiang"];
    [button0 addSubview:rightImage0];
    
    self.productLeiBieField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, S_W-100-20-15, 20)];
    self.productLeiBieField.userInteractionEnabled = NO;
    _productLeiBieField.placeholder = @"必选,请选择";
    _productLeiBieField.delegate = self;
    _productLeiBieField.font = [UIFont systemFontOfSize:13];
    _productLeiBieField.textAlignment = NSTextAlignmentRight;
    _productLeiBieField.textColor = [UIColor blackColor];
    [button0 addSubview:_productLeiBieField];
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(S_W-20-40, photoViewHeight+12+kCellHeght*2, 40, 20);
    //button1.backgroundColor = [UIColor cyanColor];
    [button1 addTarget:self action:@selector(choseProductUnit) forControlEvents:UIControlEventTouchUpInside];
    [_backGroundScrollView addSubview:button1];
    
    
    UIImageView *rightImage = [[UIImageView alloc]initWithFrame:CGRectMake(40-12, 0, 12, 20)];
    rightImage.image = [UIImage imageNamed:@"ico_zhixiang"];
    [button1 addSubview:rightImage];
    
    self.productUnitLabel = [[UILabel alloc]initWithFrame:CGRectMake(3, 0, 20, 20)];
    _productUnitLabel.text = @"吨";
    _productUnitLabel.font = [UIFont systemFontOfSize:13];
    _productUnitLabel.textColor = [UIColor blackColor];
    [button1 addSubview:_productUnitLabel];
    
    
    
    self.productTypeField = [[UITextField alloc]initWithFrame:CGRectMake(100, photoViewHeight+12+kCellHeght*3, S_W-100-20, 20)];
    _productTypeField.placeholder = @"必填，请填写";
    _productTypeField.borderStyle = UITextBorderStyleNone;
    _productTypeField.font = [UIFont systemFontOfSize:13];
    _productTypeField.textAlignment = NSTextAlignmentLeft;
    _productTypeField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_backGroundScrollView addSubview:_productTypeField];

    self.productBrandField = [[UITextField alloc]initWithFrame:CGRectMake(100, photoViewHeight+12+kCellHeght*4, S_W-100-20, 20)];
    _productBrandField.placeholder = @"必填，请填写";
    _productBrandField.borderStyle = UITextBorderStyleNone;
    _productBrandField.font = [UIFont systemFontOfSize:13];
    _productBrandField.textAlignment = NSTextAlignmentLeft;
    _productBrandField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_backGroundScrollView addSubview:_productBrandField];
    
    self.productOldField = [[UITextField alloc]initWithFrame:CGRectMake(100, photoViewHeight+12+kCellHeght*5, S_W-100-20, 20)];
    _productOldField.placeholder = @"必填，请填写";
    _productOldField.borderStyle = UITextBorderStyleNone;
    _productOldField.font = [UIFont systemFontOfSize:13];
    _productOldField.textAlignment = NSTextAlignmentLeft;
    _productOldField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_backGroundScrollView addSubview:_productOldField];

    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(S_W-20-100, photoViewHeight+12+kCellHeght*6, 100, 20);
    //button2.backgroundColor = [UIColor cyanColor];
    [button2 addTarget:self action:@selector(choseProductStatus) forControlEvents:UIControlEventTouchUpInside];
    button2.userInteractionEnabled = YES;
    [_backGroundScrollView addSubview:button2];
    
    
    UIImageView *rightImage2 = [[UIImageView alloc]initWithFrame:CGRectMake(100-12, 0, 12, 20)];
    rightImage2.image = [UIImage imageNamed:@"ico_zhixiang"];
    [button2 addSubview:rightImage2];
    
    self.productStatusField = [[UITextField alloc]initWithFrame:CGRectMake(3, 0, 80, 20)];
    self.productStatusField.userInteractionEnabled = NO;
    _productStatusField.placeholder = @"必选,请选择";
    _productStatusField.delegate = self;
    _productStatusField.font = [UIFont systemFontOfSize:13];
    _productStatusField.textAlignment = NSTextAlignmentRight;
    _productStatusField.textColor = [UIColor blackColor];
    [button2 addSubview:_productStatusField];
    
    
    
    self.workTimeField = [[UITextField alloc]initWithFrame:CGRectMake(100, photoViewHeight+12+kCellHeght*7, S_W-100-20, 20)];
    _workTimeField.placeholder = @"必填，请填写";
    _workTimeField.borderStyle = UITextBorderStyleNone;
    _workTimeField.font = [UIFont systemFontOfSize:13];
    _workTimeField.textAlignment = NSTextAlignmentLeft;
    _workTimeField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_backGroundScrollView addSubview:_workTimeField];
    
    
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    button4.frame = CGRectMake(100, photoViewHeight+12+kCellHeght*8, S_W-100-20, 20);
    //button4.backgroundColor = [UIColor cyanColor];
    [button4 addTarget:self action:@selector(choseProductTime) forControlEvents:UIControlEventTouchUpInside];
    button4.userInteractionEnabled = YES;
    [_backGroundScrollView addSubview:button4];

    UIImageView *rightImage4 = [[UIImageView alloc]initWithFrame:CGRectMake(S_W-100-20-12, 0, 12, 20)];
    rightImage4.image = [UIImage imageNamed:@"ico_zhixiang"];
    [button4 addSubview:rightImage4];
    
    self.productTimeField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, S_W-100-20-15, 20)];
    self.productTimeField.userInteractionEnabled = NO;
    _productTimeField.placeholder = @"选择日期";
    _productTimeField.delegate = self;
    _productTimeField.font = [UIFont systemFontOfSize:13];
    _productTimeField.textAlignment = NSTextAlignmentRight;
    _productTimeField.textColor = [UIColor blackColor];
    [button4 addSubview:_productTimeField];
    
    
    self.minPriceField = [[UITextField alloc]initWithFrame:CGRectMake(100, photoViewHeight+12+kCellHeght*9, S_W-100-20-30, 20)];
    _minPriceField.placeholder = @"0.00";
    _minPriceField.borderStyle = UITextBorderStyleNone;
    _minPriceField.font = [UIFont systemFontOfSize:13];
    _minPriceField.textAlignment = NSTextAlignmentLeft;
    _minPriceField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _minPriceField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [_backGroundScrollView addSubview:_minPriceField];

    
    UILabel *labelPrice = [[UILabel alloc]initWithFrame:CGRectMake(S_W-40, photoViewHeight+12+kCellHeght*9, 20, 20)];
    labelPrice.text = @"元";
    labelPrice.font = [UIFont systemFontOfSize:13];
    labelPrice.textColor = [UIColor blackColor];
    [_backGroundScrollView addSubview:labelPrice];
    
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectMake(100, photoViewHeight+12+kCellHeght*10, S_W-100-20, 20);
    //button3.backgroundColor = [UIColor cyanColor];
    [button3 addTarget:self action:@selector(choseProductAddress) forControlEvents:UIControlEventTouchUpInside];
    button3.userInteractionEnabled = YES;
    [_backGroundScrollView addSubview:button3];
    
    self.productAddressField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, S_W-100-20-15, 20)];
    self.productAddressField.userInteractionEnabled = NO;
    _productAddressField.placeholder = @"选择地区";
    _productAddressField.delegate = self;
    _productAddressField.font = [UIFont systemFontOfSize:13];
    _productAddressField.textAlignment = NSTextAlignmentRight;
    _productAddressField.textColor = [UIColor blackColor];
    [button3 addSubview:_productAddressField];

    UIImageView *rightImage3 = [[UIImageView alloc]initWithFrame:CGRectMake(S_W-100-20-12, 0, 12, 20)];
    rightImage3.image = [UIImage imageNamed:@"ico_zhixiang"];
    [button3 addSubview:rightImage3];
    
    
    
    //添加键盘监听事件
    //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    //监听键盘事件
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}
#pragma mark 监听键盘
- (void)keyboardWillChange:(NSNotification *)note
{
    NSDictionary *userInfo = note.userInfo;
    CGFloat duration = [userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    
    CGRect keyFrame = [userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    CGFloat moveY = keyFrame.origin.y - self.view.frame.size.height-kSafeAreaTopHeight;
    //这个64是我减去的navigationbar加上状态栏20的高度,可以看自己的实际情况决定是否减去;
    
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, moveY);
        _backGroundScrollView.transform = CGAffineTransformMakeTranslation(0, -moveY);
    }];
    
}

#pragma mark ---- 根据键盘高度将当前视图向上滚动同样高度
///键盘显示事件
- (void)keyboardWillShow:(NSNotification *)notification {
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    //计算出键盘顶端到inputTextView panel底端的距离(加上自定义的缓冲距离INTERVAL_KEYBOARD)
    CGFloat offset = kbHeight;
    
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    //double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    NSLog(@"-----%f",offset);

    //将视图上移计算好的偏移
    if(offset > 0) {
        
        _backGroundScrollView.contentSize = CGSizeMake(self.view.bounds.size.width,photoViewHeight +12+kCellHeght*11+offset+kViewAtBottomHeight);
        
        
    }
}
#pragma mark ---- 当键盘消失后，视图需要恢复原状
///键盘消失事件
- (void)keyboardWillHide:(NSNotification *)notify {
    
    _backGroundScrollView.contentSize = CGSizeMake(S_W, photoViewHeight +12+kCellHeght*11+kViewAtBottomHeight);
    
}
-(void)tapAction{
    [_nameField resignFirstResponder];
    [_productTypeField resignFirstResponder];
    [_productBrandField resignFirstResponder];
    [_productOldField resignFirstResponder];
    [_workTimeField resignFirstResponder];
    [_minPriceField resignFirstResponder];
    [_numberField resignFirstResponder];
    [_productStatusField resignFirstResponder];
    [_productAddressField resignFirstResponder];
    [_productTimeField resignFirstResponder];
}
#pragma mark - 选择类别
-(void)choseProductLeibie{
    __weak typeof(self)weakSelf = self;
    ZZTableViewController *vc = [[ZZTableViewController alloc]init];
    vc.nameBlock = ^(NSString *firstName, NSString *secondName, NSString *thirdName) {
        if (thirdName) {
            weakSelf.productLeiBieField.text = [NSString stringWithFormat:@"%@-%@-%@",firstName,secondName,thirdName];
        }else{
            if (secondName) {
                weakSelf.productLeiBieField.text = [NSString stringWithFormat:@"%@-%@",firstName,secondName];
            }else{
                weakSelf.productLeiBieField.text = firstName;
            }
        }
    };
    vc.idBlock = ^(NSString *firstId, NSString *secondId, NSString *thirdId) {
        self.pfirstId = firstId;
        self.psecondId = secondId;
        self.pthirdId = thirdId;
    };
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 减法
-(void)NumSub{
        if (self.numberField.text.length>0) {
            if ([self.numberField.text intValue] <= 0) {
            }
            else{
                self.numberField.text = [NSString stringWithFormat:@"%d",[self.numberField.text intValue]-1];
            }
        }
}
#pragma mark - 加法
-(void)NumAdd{
    
    if (self.numberField.text.length == 0) {
        self.numberField.text = @"1";
    }else{
        if (self.numberField.text.length>0) {
            if ([self.numberField.text intValue] < 0) {
                }
        else{
            self.numberField.text = [NSString stringWithFormat:@"%d",[self.numberField.text intValue]+1];
            }
        }
    }
}
#pragma mark - 选择产品单位
-(void)choseProductUnit{
    XRProductUintTableViewController *vc = [[XRProductUintTableViewController alloc]init];
    __weak typeof(self)weakSelf = self;
    vc.unitBlock = ^(NSString *str) {
        weakSelf.productUnitLabel.text = str;
    };
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark 选择产品状态
-(void)choseProductStatus{
    XRProductStatusTableViewController *vc = [[XRProductStatusTableViewController alloc]init];
    __weak typeof(self)weakSelf = self;
    vc.statusBlock = ^(NSString *string,NSInteger aaa) {
        
        weakSelf.productStatusField.text = string;
        weakSelf.productStatus = [NSString stringWithFormat:@"%ld",aaa];
    };
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark 选择日期
-(void)choseProductTime{
    [self.view endEditing:YES];
    STPickerDate *pickerDate = [[STPickerDate alloc]init];
    [pickerDate setYearLeast:1900];
    [pickerDate setYearSum:300];
    [pickerDate setDelegate:self];
    [pickerDate show];
}
- (void)pickerDate:(STPickerDate *)pickerDate year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSString *text = [NSString stringWithFormat:@"%zd-%zd-%zd", year, month, day];
    self.productTimeField.text = text;
    self.createTime = [NSString stringWithFormat:@"%zd-%zd-%zd", year, month, day];
}
#pragma mark 选择产品地区
-(void)choseProductAddress{
    AddressManageerViewController *address = [[AddressManageerViewController alloc]init];
    __weak typeof(self)weakSelf =self;
    address.blockAddress = ^(NSDictionary *newAddress){
        NSLog(@"--地址和编码------%@",newAddress);
        if (newAddress.count == 4) {
            weakSelf.productAddressField.text = [NSString stringWithFormat:@"%@,%@",newAddress[@"province"],newAddress[@"city"]];
        }
        else if (newAddress.count == 6){
            weakSelf.productAddressField.text = [NSString stringWithFormat:@"%@,%@,%@",newAddress[@"province"],newAddress[@"city"],newAddress[@"area"]];
            weakSelf.piProvince = newAddress[@"firstAddress"];
            weakSelf.piCity = newAddress[@"secondAddress"];
            weakSelf.piCounty = newAddress[@"thirdAddress"];
        }
    };
    [self.view endEditing:YES];
    [self.navigationController pushViewController:address animated:YES];
}

#pragma - DzyImgDelegate
- (void)getImages:(NSArray *)imgData{
    
}
#pragma mark - 跳转下一界面
-(void)next{
    NSLog(@"----%@----%@----%@",_pfirstId,_psecondId,_pthirdId);
    if (self.data.count > 0 || self.imageUrlData.count >0) {
        if ([_numberField.text isEqualToString:@"0"]) {
            NSLog(@"请输入产品数量");
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.yOffset = kHudyOffset;
            hud.labelText = @"请补全信息";
            [hud hide:YES afterDelay:0.7];
            return;
        }
        if (_nameField.text.length ==0 || _productLeiBieField.text.length == 0||_productTypeField.text.length == 0 ||_productBrandField.text.length ==0 || _productOldField.text.length == 0 || _productUnitLabel.text.length == 0 || _productTimeField.text.length ==0 ||_workTimeField.text.length == 0||_productOldField.text.length == 0 ||_minPriceField.text.length ==0 || _productAddressField.text.length == 0 ||_productStatusField.text.length ==0) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.yOffset = kHudyOffset;
            hud.labelText = @"请补全信息";
            [hud hide:YES afterDelay:0.7];
            
        }else
        {
            
            XRAddProductTwoViewController *vc = [[XRAddProductTwoViewController alloc]init];
            vc.imageArray = self.data;
            if (self.imageUrlData.count > 0) {
                NSMutableArray *urlArray = [[NSMutableArray alloc]init];
                for (NSString *string in self.imageUrlData) {
                    NSArray *array = [string componentsSeparatedByString:@"/XiYuanUpload/"];
                    NSString *imageUrl = [array lastObject];
                    [urlArray addObject:imageUrl];
                }
               vc.imageUrlArray = [urlArray mutableCopy];
                NSLog(@"分割后的url---%@",vc.imageUrlArray);
            }
            vc.name = self.nameField.text;
            vc.piId = self.piId;
            vc.shuliang = _numberField.text;
            vc.danwei = _productUnitLabel.text;
            vc.xinghao = _productTypeField.text;
            vc.pinpai = _productBrandField.text;
            vc.xinjiu = _productOldField.text;
            vc.zhuangtai = _productStatus;
            vc.workTime = _workTimeField.text;
            vc.time = self.createTime;
            vc.minPrice = _minPriceField.text;
            vc.address = _productAddressField.text;
            vc.piCateFirst = self.pfirstId;
            vc.piCateSecond = self.psecondId;
            vc.piCateThird = self.pthirdId;
            vc.piProvince = self.piProvince;
            vc.piCity = self.piCity;
            vc.piCounty = self.piCounty;
            [self.navigationController pushViewController:vc animated:YES];
        }  
    }else
    {
        NSLog(@"请选择至少一张照片");
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.yOffset = kHudyOffset;
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请选择至少一张照片";
        [hud hide:YES afterDelay:0.7];
    }
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
 
    if (textField == self.productStatusField) {
        return NO;
    }
    if (textField == self.productAddressField) {
        return NO;
    }
    return YES;
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == self.numberField) {
        //这里的if时候为了获取删除操作,如果没有次if会造成当达到字数限制后删除键也不能使用的后果.
        //so easy
        return [self validateNumber:string];
    }
    
    return YES;
}
- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if ([touch.view isKindOfClass:[_backGroundScrollView class]]){
        
        return YES;
        
    }
    
    return NO;
    
}
@end
