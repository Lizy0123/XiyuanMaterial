//
//  AddProductViewController.m
//  XYGPWuZi
//
//  Created by Lzy on 2018/1/12.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "AddProductViewController.h"
#import "TitleValueMoreTCell.h"
#import "TitleTextFieldTCell.h"
#import "BRPickerView.h"
#import "ProductCategoryModel.h"
#import "MyStepper.h"
#import "AddProductNextViewController.h"
#import "MyPhotoPickerView.h"
#import "ZZTableViewController.h"
#import "AddressManageerViewController.h"

#import "TitleTextFieldTView.h"

@interface AddProductViewController ()

//@property(strong, nonatomic)UITableView *myTableView;
@property(strong, nonatomic)UIScrollView *myScrollView;

//@property(strong, nonatomic)NSMutableArray *dataSourceArray;
@property(strong, nonatomic)ProductCategoryModel *productCategoryM;
@property(strong, nonatomic)MyStepper *numberStepper;
@property(strong, nonatomic)NSMutableArray *imgUrlArray;
@property(strong, nonatomic)NSMutableArray *imgUploadUrlArray;
@property(strong, nonatomic)NSMutableArray *imgDataArray;
//仅用于取出cell用于block传值后进行更改，无实际用处
@property(strong, nonatomic)TitleTextFieldTView *view_i_0;
@property(strong, nonatomic)TitleTextFieldTView *view_i_1;
@property(strong, nonatomic)TitleTextFieldTView *view_i_2;
@property(strong, nonatomic)TitleTextFieldTView *view_i_3;
@property(strong, nonatomic)TitleTextFieldTView *view_i_4;
@property(strong, nonatomic)TitleTextFieldTView *view_i_5;
@property(strong, nonatomic)TitleTextFieldTView *view_i_6;
@property(strong, nonatomic)TitleTextFieldTView *view_i_7;
@property(strong, nonatomic)TitleTextFieldTView *view_i_8;
@property(strong, nonatomic)TitleTextFieldTView *view_i_9;
@property(strong, nonatomic)TitleTextFieldTView *view_i_10;
@property(strong, nonatomic)TitleTextFieldTView *view_i_11;
@property(strong, nonatomic)UIView *footerView;
@end

@implementation AddProductViewController
//-(NSMutableArray *)imgDataArray{
//    if (!_imgDataArray) {
//        _imgDataArray = [NSMutableArray new];
//    }return _imgDataArray;
//}
-(NSMutableArray *)imgUrlArray{
    if (!_imgUrlArray) {
        _imgUrlArray = [NSMutableArray new];
    }return _imgUrlArray;
}
-(NSMutableArray *)imgUploadUrlArray{
    if (!_imgUploadUrlArray) {
        _imgUploadUrlArray = [NSMutableArray new];
    }return _imgUploadUrlArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.isEdit?@"编辑产品":@"添加产品";
    if (self.isEdit) {
//        [self serveData];
    }

    if (!self.addProductM) {
        self.addProductM = [AddProductModel new];
        self.addProductM.piUnit = @"件";
        self.addProductM.piDqzt = @"0";
    }
    
    MyStepper *stepper = [[MyStepper alloc] initWithFrame:CGRectMake(100, 7, 120, 30)];
    [stepper setBorderColor:kColorNav];
    [stepper setTextColor:kColorNav];
    [stepper setButtonTextColor:kColorNav forState:UIControlStateNormal];
    self.numberStepper = stepper;

    [self configSrcollView];
    [self configBottomView];
    
//    [self configMyTableView];
//    [self serveProductCategory];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self configSrcollView];
}
#pragma mark - UI
-(void)configSrcollView{
    __weak typeof(self) weakSelf = self;
    if (!self.myScrollView) {
        UIScrollView *myScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:myScrollView];
        [myScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        self.myScrollView = myScrollView;
    }
    if (!self.headerView) {
        self.headerView = [self configHeaderView];
        [self.myScrollView addSubview:self.headerView];

    }
    CGFloat headerHeight = CGRectGetHeight(self.headerView.frame);
    UIView *topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, headerHeight, kScreen_Width, 15)];
    topLineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.myScrollView addSubview:topLineView];
    headerHeight += 15;
    for (int i = 0; i< 12; i++) {
        if (i==0) {
            if (!self.view_i_0) {
                TitleTextFieldTView *cell = [[TitleTextFieldTView alloc] initWithFrame:CGRectMake(0, headerHeight, kScreen_Width, [TitleTextFieldTView cellHeight])];
                [self.myScrollView addSubview:cell];
                self.view_i_0 = cell;
            }
            [self.view_i_0 setTitleStr:@"品名" valueStr:self.addProductM.piName placeHolder:@"必填"];
            self.view_i_0.endEditBlock = ^(NSString *text) {
                weakSelf.addProductM.piName = text;
            };
        }
        else if (i== 1){
            if (!self.view_i_1) {
                headerHeight += [TitleTextFieldTView cellHeight];
                TitleTextFieldTView *cell = [[TitleTextFieldTView alloc] initWithFrame:CGRectMake(0, headerHeight, kScreen_Width, [TitleTextFieldTView cellHeight])];
                [self.myScrollView addSubview:cell];
                self.view_i_1 = cell;
            }
            NSString *str = @"";
            if ([NSObject isString:self.addProductM.cateFirst]&&[NSObject isString:self.addProductM.cateSecond]&&[NSObject isString:self.addProductM.cateThird]) {
                str = [NSString stringWithFormat:@"%@-%@-%@",self.addProductM.cateFirst,self.addProductM.cateSecond,self.addProductM.cateThird];
            }else if ([NSObject isString:self.addProductM.cateFirst]&&[NSObject isString:self.addProductM.cateSecond]){
                str = [NSString stringWithFormat:@"%@-%@",self.addProductM.cateFirst,self.addProductM.cateSecond];
            }else{
                str = self.addProductM.cateFirst;
            }
            [self.view_i_1 setTitleStr:@"产品类别" valueStr:str placeHolder:@"必选"];
            self.view_i_1.tapAcitonBlock = ^{
                ZZTableViewController *vc = [[ZZTableViewController alloc]init];
                vc.nameBlock = ^(NSString *firstName, NSString *secondName, NSString *thirdName) {
                    weakSelf.addProductM.cateFirst = firstName;
                    weakSelf.addProductM.cateSecond = secondName;
                    weakSelf.addProductM.cateThird = thirdName;
                    [weakSelf.view_i_1 setTitleStr:@"产品类别" valueStr:[NSString stringWithFormat:@"%@-%@-%@",weakSelf.addProductM.cateFirst,weakSelf.addProductM.cateSecond,weakSelf.addProductM.cateThird] placeHolder:@"必选"];
                };
                vc.idBlock = ^(NSString *firstId, NSString *secondId, NSString *thirdId) {
                    weakSelf.addProductM.cateFirstId = firstId;
                    weakSelf.addProductM.cateSecondId = secondId;
                    weakSelf.addProductM.cateThirdId = thirdId;
                };
                [weakSelf.navigationController pushViewController:vc animated:YES];
            };
        }
        else if (i== 2){
            if (!self.view_i_2) {
                headerHeight += [TitleTextFieldTView cellHeight];
                TitleTextFieldTView *cell = [[TitleTextFieldTView alloc] initWithFrame:CGRectMake(0, headerHeight, kScreen_Width, [TitleTextFieldTView cellHeight])];
                [self.myScrollView addSubview:cell];
                self.view_i_2 = cell;
            }
            [self.view_i_2 setTitleStr:@"数量" valueStr:self.addProductM.piUnit placeHolder:@"件"];
            self.view_i_2.tapAcitonBlock = ^{
                NSArray *dataSources = @[@"件",@"箱",@"桶",@"吨",@"套",@"批",@"辆",@"条",@"块",@"部",@"架",@"个",@"根",@"包",@"米",@"立方米",@"平方米",@"台"];
                [BRStringPickerView showStringPickerWithTitle:@"数量" dataSource:dataSources defaultSelValue:@"件" isAutoSelect:YES resultBlock:^(id selectValue) {
                    weakSelf.addProductM.piUnit = selectValue;
                    [weakSelf.view_i_2 setTitleStr:@"数量" valueStr:weakSelf.addProductM.piUnit placeHolder:@"件"];
                }];
            };
            if ([self.addProductM.piNumber floatValue] == 0) {
                self.addProductM.piNumber = @"1";
            }
            self.numberStepper.value = [self.addProductM.piNumber floatValue];
            //        self.numberStepper.hidesDecrementWhenMinimum = YES;
            //        self.numberStepper.hidesIncrementWhenMaximum = YES;
            [self.view_i_2 addSubview:self.numberStepper];
            
            // plain
            self.numberStepper.valueChangedCallback = ^(MyStepper *stepper, float count) {
                NSLog(@"返回的数字%@",@(count));
                stepper.countTextField.text = weakSelf.addProductM.piNumber = [NSString stringWithFormat:@"%.0f", count];
            };
            [self.numberStepper setup];
        }
        else if (i== 3){
            if (!self.view_i_3) {
                headerHeight += [TitleTextFieldTView cellHeight];
                TitleTextFieldTView *cell = [[TitleTextFieldTView alloc] initWithFrame:CGRectMake(0, headerHeight, kScreen_Width, [TitleTextFieldTView cellHeight])];
                [self.myScrollView addSubview:cell];
                self.view_i_3 = cell;

            }
            [self.view_i_3 setTitleStr:@"产品型号" valueStr:self.addProductM.piCpxh placeHolder:@"必填"];
            self.view_i_3.endEditBlock = ^(NSString *text) {
                weakSelf.addProductM.piCpxh = text;
            };
        }
        else if (i== 4){
            if (!self.view_i_4) {
                headerHeight += [TitleTextFieldTView cellHeight];
                TitleTextFieldTView *cell = [[TitleTextFieldTView alloc] initWithFrame:CGRectMake(0, headerHeight, kScreen_Width, [TitleTextFieldTView cellHeight])];
                [self.myScrollView addSubview:cell];
                self.view_i_4 = cell;
            }
            [self.view_i_4 setTitleStr:@"产品品牌" valueStr:self.addProductM.piCpcd placeHolder:@"必填"];
            self.view_i_4.endEditBlock = ^(NSString *text) {
                weakSelf.addProductM.piCpcd = text;
            };
        }
        else if (i== 5){
            if (!self.view_i_5) {
                headerHeight += [TitleTextFieldTView cellHeight];
                TitleTextFieldTView *cell = [[TitleTextFieldTView alloc] initWithFrame:CGRectMake(0, headerHeight, kScreen_Width, [TitleTextFieldTView cellHeight])];
                [self.myScrollView addSubview:cell];
                self.view_i_5 = cell;
            }
            [self.view_i_5 setTitleStr:@"新旧程度" valueStr:self.addProductM.piXjcd placeHolder:@"必填"];
            self.view_i_5.endEditBlock = ^(NSString *text) {
                weakSelf.addProductM.piXjcd = text;
            };
        }
        else if (i== 6){
            if (!self.view_i_6) {
                headerHeight += [TitleTextFieldTView cellHeight];
                TitleTextFieldTView *cell = [[TitleTextFieldTView alloc] initWithFrame:CGRectMake(0, headerHeight, kScreen_Width, [TitleTextFieldTView cellHeight])];
                [self.myScrollView addSubview:cell];
                self.view_i_6 = cell;
            }
            NSString *str = @"正常使用";
            if ([self.addProductM.piDqzt isEqualToString:@"0"]) {
                str = @"正常使用";
            }else if ([self.addProductM.piDqzt isEqualToString:@"1"]){
                str = @"故障";
            }else if ([self.addProductM.piDqzt isEqualToString:@"2"]){
                str = @"报废";
            }else if ([self.addProductM.piDqzt isEqualToString:@"3"]){
                str = @"其他";
            }
            [self.view_i_6 setTitleStr:@"当前状态" valueStr:str placeHolder:@"请选择"];
            self.view_i_6.tapAcitonBlock = ^{
                NSArray *dataSources = @[@"正常使用",@"故障",@"报废",@"其他"];
                [BRStringPickerView showStringPickerWithTitle:@"当前状态" dataSource:dataSources defaultSelValue:@"正常使用" isAutoSelect:YES resultBlock:^(id selectValue) {
                    if ([selectValue isEqualToString:@"正常使用"]) {
                        weakSelf.addProductM.piDqzt = @"0";
                    }else if ([selectValue isEqualToString:@"故障"]){
                        weakSelf.addProductM.piDqzt = @"1";
                    }else if ([selectValue isEqualToString:@"报废"]){
                        weakSelf.addProductM.piDqzt = @"2";
                    }else if ([selectValue isEqualToString:@"其他"]){
                        weakSelf.addProductM.piDqzt = @"3";
                    }
                    [weakSelf.view_i_6 setTitleStr:@"当前状态" valueStr:selectValue placeHolder:@"请选择"];
                }];
            };
        }
        else if (i== 7){
            if (!self.view_i_7) {
                headerHeight += [TitleTextFieldTView cellHeight];
                TitleTextFieldTView *cell = [[TitleTextFieldTView alloc] initWithFrame:CGRectMake(0, headerHeight, kScreen_Width, [TitleTextFieldTView cellHeight])];
                [self.myScrollView addSubview:cell];
                self.view_i_7 = cell;
            }
            [self.view_i_7 setTitleStr:@"工作小时数" valueStr:self.addProductM.piGzxs placeHolder:@"必填"];
            self.view_i_7.endEditBlock = ^(NSString *text) {
                weakSelf.addProductM.piGzxs = text;
            };
        }
        else if (i== 8){
            if (!self.view_i_8) {
                headerHeight += [TitleTextFieldTView cellHeight];
                TitleTextFieldTView *cell = [[TitleTextFieldTView alloc] initWithFrame:CGRectMake(0, headerHeight, kScreen_Width, [TitleTextFieldTView cellHeight])];
                [self.myScrollView addSubview:cell];
                self.view_i_8 = cell;
            }
            [self.view_i_8 setTitleStr:@"生产日期" valueStr:self.addProductM.piScDate placeHolder:@"请选择日期"];
            self.view_i_8.tapAcitonBlock = ^{
                [BRDatePickerView showDatePickerWithTitle:@"生产日期" dateType:UIDatePickerModeDate defaultSelValue:weakSelf.addProductM.piScDate minDateStr:nil maxDateStr:[NSObject currentDateString] isAutoSelect:YES resultBlock:^(NSString *selectValue) {
                    weakSelf.addProductM.piScDate = selectValue;
                    [weakSelf.view_i_8 setTitleStr:@"生产日期" valueStr:weakSelf.addProductM.piScDate placeHolder:@"请选择日期"];
                }];
            };
        }
        else if (i== 9){
            if (!self.view_i_9) {
                headerHeight += [TitleTextFieldTView cellHeight];
                TitleTextFieldTView *cell = [[TitleTextFieldTView alloc] initWithFrame:CGRectMake(0, headerHeight, kScreen_Width, [TitleTextFieldTView cellHeight])];
                [self.myScrollView addSubview:cell];
                self.view_i_9 = cell;
            }
            [self.view_i_9 setTitleStr:@"最低出售价" valueStr:self.addProductM.piMinPrice placeHolder:@"元"];
            self.view_i_9.endEditBlock = ^(NSString *text) {
                weakSelf.addProductM.piMinPrice = text;
            };
        }
        else if (i== 10){
            if (!self.view_i_10) {
                headerHeight += [TitleTextFieldTView cellHeight];
                TitleTextFieldTView *cell = [[TitleTextFieldTView alloc] initWithFrame:CGRectMake(0, headerHeight, kScreen_Width, [TitleTextFieldTView cellHeight])];
                [self.myScrollView addSubview:cell];
                self.view_i_10 = cell;
            }
            
            [self.view_i_10 setTitleStr:@"所在区域" valueStr:self.addProductM.piAddress placeHolder:@"请选择地址"];
            self.view_i_10.tapAcitonBlock = ^{
                AddressManageerViewController *address = [[AddressManageerViewController alloc]init];
                address.blockAddress = ^(NSDictionary *newAddress){
                    NSLog(@"--地址和编码------%@",newAddress);
                    if (newAddress.count == 4) {
                        weakSelf.addProductM.piAddress = [NSString stringWithFormat:@"%@,%@",newAddress[@"province"],newAddress[@"city"]];
                    }
                    else if (newAddress.count == 6){
                        weakSelf.addProductM.piProvince = newAddress[@"firstAddress"];
                        weakSelf.addProductM.piCity = newAddress[@"secondAddress"];
                        weakSelf.addProductM.piCounty = newAddress[@"thirdAddress"];
                        weakSelf.addProductM.piAddress = [NSString stringWithFormat:@"%@,%@,%@",newAddress[@"province"],newAddress[@"city"],newAddress[@"area"]];
                        [weakSelf.view_i_10 setTitleStr:@"所在区域" valueStr:weakSelf.addProductM.piAddress placeHolder:@"请选择地址"];
                    }
                    [TitleTextFieldTView refreshView];
                };
                [weakSelf.view endEditing:YES];
                [weakSelf.navigationController pushViewController:address animated:YES];
            };
        }
        else if (i== 11){
            if (!self.footerView) {
                headerHeight += [TitleTextFieldTView cellHeight];
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, headerHeight, kScreen_Width, 50)];
                view.backgroundColor = [UIColor clearColor];
                [self.myScrollView addSubview:view];
                self.footerView = view;
            }
        }
    }
    self.myScrollView.contentSize = CGSizeMake(kScreen_Width, 50 + headerHeight);
}


-(UIView *)configHeaderView{
    UIView *headerV = [UIView new];

    MyImgPickerView *pickerV = [MyImgPickerView ImgPickerViewWithFrame:CGRectMake(0 , 0, [UIScreen mainScreen].bounds.size.width, 0) CountOfRow:4];
    pickerV.isCustomCamera = YES;
    pickerV.type = MyImgType_PhotoAndCamera;
    pickerV.allowMultipleSelection = YES;
    pickerV.showAddButton = YES;
    pickerV.showDelete = YES;
    pickerV.maxImageSelected = 4;
    self.imgPickerView = pickerV;
    [self.myScrollView addSubview:pickerV];
    //拼接后的图片url数组
    NSMutableArray *completedImageUrlArray = [[NSMutableArray alloc]init];
    //拼接前的url数组
    NSArray *imageArray = self.addProductM.picUrls;
    //目前手机端只支持4张照片的编辑,但是pc端有的有5张照片,为了不大量修改代码,暂时选4张展示在手机端
    if (imageArray.count>0) {
        if (imageArray.count>4) {
            for (int i = 0; i<4; i++) {
                NSString *imageUrl = (NSString *)imageArray[i];
                NSString *completedUrl = [myCDNUrl stringByAppendingString:imageUrl];
                [completedImageUrlArray addObject:completedUrl];
            }
        }else{
            for (NSString *imageUrl in imageArray) {
                NSString *completedUrl = [myCDNUrl stringByAppendingString:imageUrl];
                [completedImageUrlArray addObject:completedUrl];
            }
        }
    }
    pickerV.preShowMedias =completedImageUrlArray;
    [pickerV observeSelectedMediaArray:^(NSArray<MyImgPickerModel *> *list) {
        self.imgDataArray = [NSMutableArray new];
        self.imgUrlArray = [NSMutableArray new];
        for (MyImgPickerModel *model in list) {

            // 在这里取到模型的数据
            if (model.image) {
//                [self.imgDataArray addObject:model.image];
                if (![self.imgDataArray containsObject:model.image]) {
                    [self.imgDataArray addObject:model.image];
                }
            }else if (model.imageUrlString){
//                [self.imgUrlArray addObject:model.imageUrlString];
                if (![self.imgUrlArray containsObject:model.imageUrlString]) {
                    [self.imgUrlArray addObject:model.imageUrlString];
                }
            }
        }
        self.addProductM.picUrls = list;
    }];
    // 如果在预览的基础上又要添加照片 则需要调用此方法 来动态变换高度
    [pickerV observeViewHeight:^(CGFloat height) {
        CGRect rect = headerV.frame;
        rect.size.height = CGRectGetMaxY(pickerV.frame);
        headerV.frame = rect;
    }];
//    self.pickerView = pickerV;
    [headerV addSubview:pickerV];
    headerV.frame = CGRectMake(0, 0, self.view.frame.size.width, CGRectGetMaxY(pickerV.frame));
    return headerV;
}
-(void)configBottomView{
    //右上角按钮
    UIBarButtonItem *nextStepBtn = [[UIBarButtonItem alloc]initWithTitle:@"下一步" style:UIBarButtonItemStyleDone target:self action:@selector(goToNextStep)];
    self.navigationItem.rightBarButtonItem = nextStepBtn;
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];

    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomView.backgroundColor = [UIColor clearColor];
    
    UIButton *button = [UIButton buttonWithStyle:StrapDefaultStyle andTitle:@"下一步" andFrame:CGRectMake(16, 0, kScreen_Width-32, 44) target:self action:@selector(goToNextStep)];
    [bottomView addSubview:button];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreen_Width, kViewAtBottomHeight));
        make.bottom.equalTo(self.view);
        make.left.equalTo(self.view);
    }];
}


#pragma mark - Action
-(void)serveProductCategory{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:@"40288098472849cf0147284ed08e0002" forKey:@"proCategoryId"];
    [dict setObject:@"0" forKey:@"status"];
    
    __weak typeof(self)weakSelf = self;
    [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:@"xy/category/get.json"] parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        weakSelf.productCategoryM = [[ProductCategoryModel alloc] initWithDictionary:responseObject[@"object"][0] error:nil];
        [NSObject archiverWithSomeThing:responseObject[@"object"][0] someName:kProductCategoryCacheAll];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}

-(BOOL)configAlertMessage{
    if (!(self.addProductM.picUrls.count>=1)) {
        [NSObject ToastShowStr:@"请至少选择一张照片"];
        return NO;
    }
    if (![NSObject isString:self.addProductM.piName]) {
        [NSObject ToastShowStr:@"请填写起品名"];
        return NO;
    }
    if (![NSObject isString:self.addProductM.cateFirstId]||![NSObject isString:self.addProductM.cateSecondId]||![NSObject isString:self.addProductM.cateThirdId]) {
        [NSObject ToastShowStr:@"请选择产品类别"];
        return NO;
    }
    if (![NSObject isString:self.addProductM.piNumber]) {
        [NSObject ToastShowStr:@"请填写数量"];
        return NO;
    }
    if (![NSObject isString:self.addProductM.piUnit]) {
        [NSObject ToastShowStr:@"请选择产品单位"];
        return NO;
    }
    if (![NSObject isString:self.addProductM.piCpxh]) {
        [NSObject ToastShowStr:@"请填写产品型号"];
        return NO;
    }
    if (![NSObject isString:self.addProductM.piCpcd]) {
        [NSObject ToastShowStr:@"请填写产品品牌"];
        return NO;
    }
    if (![NSObject isString:self.addProductM.piXjcd]) {
        [NSObject ToastShowStr:@"请填写新旧程度"];
        return NO;
    }
    if (![NSObject isString:self.addProductM.piDqzt]) {
        [NSObject ToastShowStr:@"请选择当前状态"];
        return NO;
    }
    if (![NSObject isString:self.addProductM.piGzxs]) {
        [NSObject ToastShowStr:@"请填写工作小时数"];
        return NO;
    }
    if (![NSObject isString:self.addProductM.piScDate]) {
        [NSObject ToastShowStr:@"请选择生产日期"];
        return NO;
    }
    if (![NSObject isString:self.addProductM.piMinPrice]) {
        [NSObject ToastShowStr:@"请填写最低出售价"];
        return NO;
    }
    if (![NSObject isString:self.addProductM.piAddress]) {
        [NSObject ToastShowStr:@"请选择所在区域"];
        return NO;
    }
    return YES;
}

-(void)goToNextStep{
    if (![self configAlertMessage]) {
        return;
    }
    if ([kStringToken length]) {

        
        if (self.imgDataArray.count>0) {
            [self serveWithImgs:self.imgDataArray];
        }else{
            AddProductNextViewController *vc = [AddProductNextViewController new];
            vc.isEdit = self.isEdit;
            vc.addProductM = self.addProductM;
            NSLog(@"11111%@",vc.addProductM);
            NSLog(@"22222%@",self.addProductM);
            vc.imgUrlArray = self.imgUrlArray;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else{
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:loginVC];
        [self.navigationController presentViewController:nav animated:YES completion:^{
        }];
    }
}
-(void)serveWithImgs:(NSMutableArray *)imageDataArray{
    __weak typeof(self)weakSelf = self;
    //接收返回的图片url
    NSMutableArray *tempUrlArr = [NSMutableArray array];
    for (int i = 0; i< imageDataArray.count; i++) {
        UIImage *image = (UIImage *)imageDataArray[i];
        NSData * imageData = UIImageJPEGRepresentation(image, 0.5);
        [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_UpLoadPic] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:imageData name:@"uploadPic" fileName:@"uploadPic.jpg" mimeType:@"image/jpg"];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSLog(@"图片上传-responseObject--%@",responseObject);
            if ([responseObject[@"code"] intValue] == 200) {
                NSString *str = responseObject[@"object"][@"saveUrl"];
                [tempUrlArr addObject:str];
                if (tempUrlArr.count == imageDataArray.count) {

//                    [self.imgUploadUrlArray addObjectsFromArray:tempUrlArr];
                    AddProductNextViewController *vc = [AddProductNextViewController new];
                    vc.isEdit = self.isEdit;
                    vc.addProductM = self.addProductM;
                    NSLog(@"11111%@",vc.addProductM);
                    NSLog(@"22222%@",self.addProductM);
                    NSMutableArray *arr = [NSMutableArray arrayWithArray:tempUrlArr];
                    [arr addObjectsFromArray:self.imgUrlArray];
                    vc.imgUrlArray = arr;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }
        }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error=%@",error);
            //            if (i== imageDataArray.count -1) {
            [NSObject HUDActivityHide];
            //            }
        }];
    }
}
@end
