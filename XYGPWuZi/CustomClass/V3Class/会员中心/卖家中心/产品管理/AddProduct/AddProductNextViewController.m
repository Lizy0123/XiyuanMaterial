//
//  AddProductNextViewController.m
//  XYGPWuZi
//
//  Created by Lzy on 2018/1/12.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "AddProductNextViewController.h"
#import "TitleTextFieldTCell.h"
#import "BRPickerView.h"
#import "ProductCategoryModel.h"
#import "TitleTextViewTCell.h"
#import "MyImgPickerModel.h"
#import "MyProductListViewController.h"
#import "AddProductViewController.h"

@interface AddProductNextViewController ()<UITableViewDelegate, UITableViewDataSource, TitleTextViewTCellDelegate>
@property(strong, nonatomic)UITableView *myTableView;
@property(strong, nonatomic)NSMutableArray *dataSourceArray;
@property(strong, nonatomic)ProductCategoryModel *productCategoryM;

@end

@implementation AddProductNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.isEdit?@"编辑产品":@"添加产品";
    [self configMyTableView];
    [self configBottomView];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.imgUrlArray = nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UI
-(void)configMyTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, kViewAtBottomHeight, 0);
    tableView.contentInset = insets;
    tableView.scrollIndicatorInsets = insets;
    
    
    [tableView registerClass:[TitleTextFieldTCell class] forCellReuseIdentifier:kCellIdentifier_TitleTextFieldTCell];
    [tableView registerClass:[TitleTextViewTCell class] forCellReuseIdentifier:kCellIdentifier_TitleTextViewTCell];

    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kSafeAreaBottomHeight)];
    
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.myTableView = tableView;
}
-(void)configBottomView{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomView.backgroundColor = [UIColor clearColor];
    NSString *str =@"添加产品";
    if (self.isEdit) {
        str = @"修改产品";
    }
    //右上角按钮
    UIBarButtonItem *nextStepBtn = [[UIBarButtonItem alloc]initWithTitle:str style:UIBarButtonItemStyleDone target:self action:@selector(goToNextStep)];
    self.navigationItem.rightBarButtonItem = nextStepBtn;
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];

    
    UIButton *button = [UIButton buttonWithStyle:StrapDefaultStyle andTitle:str andFrame:CGRectMake(16, 0, kScreen_Width-32, 44) target:self action:@selector(goToNextStep)];
    [bottomView addSubview:button];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreen_Width, kViewAtBottomHeight));
        make.bottom.equalTo(self.view);
        make.left.equalTo(self.view);
    }];
}




#pragma mark - Action
-(void)goToNextStep{
    [NSObject HUDActivityShowStr:nil];
//    if (self.imgDataArray.count>0) {
//        [self serveWithImgs:self.imgDataArray];
//    }else{
        [self serveWithProduct];
//    }
}
//-(void)serveWithImgs:(NSMutableArray *)imageDataArray{
//    __weak typeof(self)weakSelf = self;
//    //接收返回的图片url
//    NSMutableArray *tempUrlArr = [NSMutableArray array];
//    for (int i = 0; i< imageDataArray.count; i++) {
//        UIImage *image = (UIImage *)imageDataArray[i];
//        NSData * imageData = UIImageJPEGRepresentation(image, 0.5);
//        [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_UpLoadPic] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//            [formData appendPartWithFileData:imageData name:@"uploadPic" fileName:@"uploadPic.jpg" mimeType:@"image/jpg"];
//        } progress:^(NSProgress * _Nonnull uploadProgress) {
//
//        }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//            NSLog(@"图片上传-responseObject--%@",responseObject);
//            if ([responseObject[@"code"] intValue] == 200) {
//                NSString *str = responseObject[@"object"][@"saveUrl"];
//                [tempUrlArr addObject:str];
//                if (tempUrlArr.count == imageDataArray.count) {
//                    if (!self.imgUrlArray) {
//                        self.imgUrlArray = [NSMutableArray new];
//                    }
//                    [self.imgUrlArray addObjectsFromArray:tempUrlArr];
//                    [weakSelf serveWithProduct];
//                }
//            }
//        }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            NSLog(@"error=%@",error);
////            if (i== imageDataArray.count -1) {
//                [NSObject HUDActivityHide];
////            }
//        }];
//    }
//}
-(void)serveWithProduct{
    __weak typeof(self)weakSelf = self;
    NSString *imageUrlStr = @"";
    if ((self.imgUrlArray.count==0)) {
        for (int i = 0; i<self.addProductM.picUrls.count; i++) {
            imageUrlStr = [imageUrlStr stringByAppendingString:[NSString stringWithFormat:@"%@,",self.addProductM.picUrls[i]]];
        }
    }else{
        for (int i = 0; i<self.imgUrlArray.count; i++) {
            imageUrlStr = [imageUrlStr stringByAppendingString:[NSString stringWithFormat:@"%@,",self.imgUrlArray[i]]];
        }
    }
    NSLog(@"--准备上传产品---图片url===%@",imageUrlStr);
    NSMutableDictionary *parma = [[NSMutableDictionary alloc]init];
    if ([NSObject isString:self.addProductM.piId]) {
        [parma setObject:self.addProductM.piId forKey:@"piId"];
    }
    
    //必填参数
    [parma setObject:[UserManager readUserInfo].token forKey:@"token"];
    [parma setObject:imageUrlStr forKey:@"piPics"];
    [parma setObject:self.addProductM.piName forKey:@"piName"];
    [parma setObject:self.addProductM.piNumber forKey:@"piNumber"];
    [parma setObject:self.addProductM.piUnit forKey:@"piUnit"];
    [parma setObject:self.addProductM.piCpxh forKey:@"piCpxh"];
    [parma setObject:self.addProductM.piCpcd forKey:@"piCpcd"];
    [parma setObject:self.addProductM.piXjcd forKey:@"piXjcd"];
    [parma setObject:self.addProductM.piDqzt forKey:@"piDqzt"];
    [parma setObject:self.addProductM.piGzxs forKey:@"piGzxs"];
    [parma setObject:self.addProductM.piScDate forKey:@"piScDate"];
    [parma setObject:self.addProductM.piMinPrice forKey:@"piMinPrice"];
    if ([NSObject isString:self.addProductM.piProvince]) {
        [parma setObject:self.addProductM.piProvince forKey:@"piProvince"];
    }
    if ([NSObject isString:self.addProductM.piCity]) {
        [parma setObject:self.addProductM.piCity forKey:@"piCity"];
    }
    if ([NSObject isString:self.addProductM.piCounty]) {
        [parma setObject:self.addProductM.piCounty forKey:@"piCounty"];
    }
    [parma setObject:self.addProductM.piAddress forKey:@"piAddress"];
    [parma setObject:self.addProductM.cateFirstId forKey:@"piCateFirst.proCategoryId"];
    [parma setObject:self.addProductM.cateSecondId forKey:@"piCateSecond.proCategoryId"];
    [parma setObject:self.addProductM.cateThirdId forKey:@"piCateThird.proCategoryId"];
        if (self.addProductM.cateThirdId) {
            [parma setObject:self.addProductM.cateThirdId forKey:@"category.proCategoryId"];
        }else if (self.addProductM.cateSecondId){
            [parma setObject:self.addProductM.cateSecondId forKey:@"category.proCategoryId"];
        }else{
            [parma setObject:self.addProductM.cateFirstId forKey:@"category.proCategoryId"];
        }
    //选填
    if ([NSObject isString:self.addProductM.piWarehouse]) {
        [parma setObject:self.addProductM.piWarehouse forKey:@"piWarehouse"];
    }
    if ([NSObject isString:self.addProductM.piJjfs]) {
        [parma setObject:self.addProductM.piJjfs forKey:@"piJjfs"];
    }
    if ([NSObject isString:self.addProductM.piCch]) {
        [parma setObject:self.addProductM.piCch forKey:@"piCch"];
    }
    if ([NSObject isString:self.addProductM.piZyh]) {
        [parma setObject:self.addProductM.piZyh forKey:@"piZyh"];
    }
    if ([NSObject isString:self.addProductM.piGlh]) {
        [parma setObject:self.addProductM.piGlh forKey:@"piGlh"];
    }
    if ([NSObject isString:self.addProductM.piKbh]) {
        [parma setObject:self.addProductM.piKbh forKey:@"piKbh"];
    }
    if ([NSObject isString:self.addProductM.piZyms]) {
        [parma setObject:self.addProductM.piZyms forKey:@"piZyms"];
    }
    if ([NSObject isString:self.addProductM.piMark]) {
        [parma setObject:self.addProductM.piMark forKey:@"piMark"];
    }
    NSLog(@"--parma参数:----%@",parma);
    [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_AddProduct] parameters:parma progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [NSObject HUDActivityHide];

        NSLog(@"--添加产品成功--%@",responseObject);
        if ([responseObject[@"code"] intValue] == 200) {
            int par = [responseObject[@"params"] intValue];
            if (par == 2) {
                [NSObject ToastShowStr:@"添加产品成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"添加成功,是否继续上传" message:nil preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
//                        self.addProductM = nil;
//                        NSLog(@"33333%@",weakSelf.addProductM);
                        NSString *addressStr = weakSelf.addProductM.piAddress;
                        weakSelf.addProductM = [AddProductModel new];
                        weakSelf.addProductM.piAddress = addressStr;
                        weakSelf.addProductM.piUnit = @"件";
                        weakSelf.addProductM.piDqzt = @"0";
                        AddProductViewController *vc = weakSelf.navigationController.viewControllers[1];
                        vc.addProductM = weakSelf.addProductM;
                        vc.imgPickerView.preShowMedias = nil;
                        [vc.headerView removeFromSuperview];
                        vc.headerView = nil;
                        [vc.imgPickerView reload];

                        [weakSelf.navigationController popToViewController:vc animated:YES];
                    }];
                    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                        //得到当前视图控制器中的所有控制器
//                        NSMutableArray *array = [self.navigationController.viewControllers mutableCopy];
//                        //把B从里面删除
//                        [array removeObjectAtIndex:1];
//                        [array removeObjectAtIndex:1];
                        //把删除后的控制器数组再次赋值
//                        [self.navigationController setViewControllers:[array copy] animated:YES];
                        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                    }];
                    [alert addAction:action1];
                    [alert addAction:action2];
                    [weakSelf.navigationController presentViewController:alert animated:YES completion:nil];
                });
            }
            else if (par == 0) {
                //0、操作失败 2、添加成功 1、修改成功 3、该产品已经生成场次，不能编辑。
                [NSObject ToastShowStr:@"操作失败"];
            }else if (par == 1) {
                [NSObject ToastShowStr:@"修改成功,请等待审核"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"添加成功,是否继续上传" message:nil preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            
                            NSString *addressStr = weakSelf.addProductM.piAddress;
                            weakSelf.addProductM = [AddProductModel new];
                            weakSelf.addProductM.piAddress = addressStr;
                            
                            [weakSelf.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
                        }];
                        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            //                        //得到当前视图控制器中的所有控制器
                            //                        NSMutableArray *array = [self.navigationController.viewControllers mutableCopy];
                            //                        //把B从里面删除
                            //                        [array removeObjectAtIndex:1];
                            //                        [array removeObjectAtIndex:1];
                            //把删除后的控制器数组再次赋值
                            //                        [self.navigationController setViewControllers:[array copy] animated:YES];
                            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                        }];
                        [alert addAction:action1];
                        [alert addAction:action2];
                        [weakSelf.navigationController presentViewController:alert animated:YES completion:nil];
                    });
                });
            } else if (par == 3) {
                [NSObject ToastShowStr:@"该产品已经生成场次,不能编辑"];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [NSObject HUDActivityHide];

        NSLog(@"error=%@",error);
    }];
}

#pragma mark - TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else if (section == 1){
        return 4;
    }else {
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 44;
    }else if (indexPath.section == 1){
        return 44;
    }else if (indexPath.section == 2){
        return [TitleTextViewTCell cellHeightWithObj:self.addProductM.piZyms];
    }else if (indexPath.section == 3){
        return [TitleTextViewTCell cellHeightWithObj:self.addProductM.piMark];
    }else{
        return 44;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    __weak typeof(self) weakSelf = self;
    if (indexPath.section == 0) {
        TitleTextFieldTCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_TitleTextFieldTCell forIndexPath:indexPath];
        if (indexPath.row == 0) {
            [cell setTitleStr:@"仓库" valueStr:self.addProductM.piWarehouse placeHolder:@"选填"];
            cell.endEditBlock = ^(NSString *text) {
                weakSelf.addProductM.piWarehouse = text;
            };
            return cell;
            
        }else {
            [cell setTitleStr:@"计价方式" valueStr:self.addProductM.piJjfs placeHolder:@"选填"];
            cell.endEditBlock = ^(NSString *text) {
                weakSelf.addProductM.piJjfs = text;
            };
            return cell;
        }
    }else if (indexPath.section == 1){
        TitleTextFieldTCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_TitleTextFieldTCell forIndexPath:indexPath];
        if (indexPath.row == 0) {
            [cell setTitleStr:@"仓储号" valueStr:self.addProductM.piCch placeHolder:@"选填"];
            cell.endEditBlock = ^(NSString *text) {
                weakSelf.addProductM.piCch = text;
            };
            return cell;
            
        }else if (indexPath.row == 1){
            [cell setTitleStr:@"资源号" valueStr:self.addProductM.piZyh placeHolder:@"选填"];
            cell.endEditBlock = ^(NSString *text) {
                weakSelf.addProductM.piZyh = text;
            };
            return cell;
            
        }else if (indexPath.row == 2){
            [cell setTitleStr:@"管理号" valueStr:self.addProductM.piGlh placeHolder:@"选填"];
            cell.endEditBlock = ^(NSString *text) {
                weakSelf.addProductM.piGlh = text;
            };
            return cell;
            
        }else {
            [cell setTitleStr:@"捆包号" valueStr:self.addProductM.piKbh placeHolder:@"选填"];
            cell.endEditBlock = ^(NSString *text) {
                weakSelf.addProductM.piKbh = text;
            };
            return cell;
        }
    }else if (indexPath.section == 2){
        TitleTextViewTCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_TitleTextViewTCell forIndexPath:indexPath];
        cell.delegate = self;
        [cell setTitleStr:@"资源描述" valueStr:self.addProductM.piZyms placeHolder:@"选填"];
        return cell;
    }else {
        TitleTextViewTCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_TitleTextViewTCell forIndexPath:indexPath];
        cell.delegate = self;
        [cell setTitleStr:@"备注" valueStr:self.addProductM.piMark placeHolder:@"选填"];
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        //        MyProductModel *model = [self.productListArray objectAtIndex:indexPath.row];
        //        ProductDetailViewController *vc = [ProductDetailViewController new];
        //        vc.hidBottomView = YES;
        //        vc.piId = model.piId;
        //        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)MyTitleTextViewDidChange:(NSString *)str tableViewCell:(TitleTextViewTCell *)cell{
    if ([cell.titleLabel.text isEqualToString:@"资源描述"]) {
        self.addProductM.piZyms = str;
    }else if ([cell.titleLabel.text isEqualToString:@"备注"]){
        self.addProductM.piMark = str;
    }
    [self.myTableView beginUpdates];
    [self.myTableView endUpdates];
}


@end
