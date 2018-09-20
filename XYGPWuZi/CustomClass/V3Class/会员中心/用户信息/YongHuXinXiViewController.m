//
//  YongHuXinXiViewController.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/8/11.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//
#define headImgWidth 80
#import "YongHuXinXiViewController.h"
#import "UIImageView+WebCache.h"

@interface YongHuXinXiViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate
,
UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)UITableView *myTableView;
@property(strong, nonatomic)UIView *tableViewHeaderView;

@property (nonatomic,strong)UIButton *headImageView;
@property (nonatomic,strong)NSData *fileData;
@property (nonatomic,strong)UIButton *headBtn;
@property (nonatomic,strong)UILabel *zhangHaoTypeLabel;
@property (nonatomic,strong)UILabel *zhangHaoLabel;
@property (nonatomic,strong)UILabel *companyNameLabel;
@property (nonatomic,strong)UILabel *shouQuanRenLabel;
@property (nonatomic,strong)UILabel *phoneNumLabel;

@end

@implementation YongHuXinXiViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
    [self.navigationController setNavigationBarHidden:NO animated:YES];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账号信息";
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //右上角按钮
    UIBarButtonItem *rightLoginBtn = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(actionSaveUserInfo)];

    self.navigationItem.rightBarButtonItem = rightLoginBtn;
    
    
    [self.view addSubview:self.myTableView];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.tableViewHeaderView addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.tableViewHeaderView);
        make.size.mas_equalTo((CGSize){headImgWidth,headImgWidth});
    }];
}
#pragma mark - Action
-(void)actionSaveUserInfo{
    
}

-(void)actionChangeImg{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    // 2.创建并添加按钮
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"本地相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Cancel Action");
    }];
    
    [alertController addAction:action0];
    [alertController addAction:action1];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeImage]) {
        UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
        [self performSelector:@selector(saveImage:)  withObject:img afterDelay:0.5];
    }
    else if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeMovie]) {
        NSString *videoPath = [[info objectForKey:UIImagePickerControllerMediaURL] path];
        self.fileData = [NSData dataWithContentsOfFile:videoPath];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveImage:(UIImage *)image {
    //    NSLog(@"保存头像！");
    //    [userPhotoButton setImage:image forState:UIControlStateNormal];
       //    UIImage *smallImage=[self scaleFromImage:image toSize:CGSizeMake(80.0f, 80.0f)];//将图片尺寸改为80*80
    UIImage *smallImage = [self thumbnailWithImageWithoutScale:image size:CGSizeMake(200, 200)];
//    self.headImageView.image = smallImage;
}

// 改变图像的尺寸，方便上传服务器
- (UIImage *) scaleFromImage: (UIImage *) image toSize: (CGSize) size{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


//2.保持原来的长宽比，生成一个缩略图
- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize{
    UIImage *newimage;
    if (nil == image) {
        newimage = nil;
    }
    else{
        CGSize oldsize = image.size;
        CGRect rect;
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width)/2;
            rect.origin.y = 0;
        }
        else{
            rect.size.width = asize.width;
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = (asize.height - rect.size.height)/2;
        }
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}


#pragma mark - 上传图片
-(void)serve_saveUserInfo{
    __weak typeof(self)weakSelf = self;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setObject:[UserManager readUserInfo].token forKey:@"token"];
    
    [[AFHTTPSessionManager manager] POST:[myBaseUrl stringByAppendingString:kPath_ModifyUserInfo] parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    
//       NSData *imdata = UIImageJPEGRepresentation(weakSelf.headImageView.image,1);
//    [formData appendPartWithFileData:imdata name:@"uploadPic" fileName:@"uploadPic.png" mimeType:@"image/png"];
       
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [hud hide:YES];
        NSLog(@"----%@",responseObject);
        MBProgressHUD *hudd = [MBProgressHUD showHUDAddedTo:weakSelf.view animated:YES];
        hudd.mode = MBProgressHUDModeCustomView;
        int code = [responseObject[@"code"] intValue];
        if (code == 200) {
            NSString *headPicUrl = (NSString *)responseObject[@"object"][@"align"];
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject:headPicUrl forKey:KEY_USER_picurl];
            [userDefault synchronize];
            
            hudd.labelText = @"保存成功";
            [hudd hide:YES afterDelay:0.7];
            
            /*
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
            */
        }
        if (code == 1322 ) {
            hudd.labelText = @"修改失败";
            [hudd hide:YES afterDelay:0.7];
        }
        if (code == 1323 ) {
            hudd.labelText = @"图片上传失败";
            [hudd hide:YES afterDelay:0.7];
        }
        
        /*
         | 1322：账户信息修改失败！| 1323：图片上传失败！
         {
         code = 200;
         message = "upload/xzwz/app/user/201708111708738002.png";
         object =     {
         align = "http://192.168.0.14/XiYuanUpload/upload/xzwz/app/user/201708111708738002.png";
         error = 0;
         picName = 201708111708738002;
         saveUrl = "upload/xzwz/app/user/201708111708738002.png";
         url = "http://192.168.0.14/XiYuanUpload/upload/xzwz/app/user/201708111708738002.png";
         };
         success = 1;
         }*/
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [hud hide:YES];
    }];
}





-(UIView *)tableViewHeaderView{
    if (!_tableViewHeaderView) {
        _tableViewHeaderView = ({
            UIView *view = [[UIView alloc] initWithFrame:(CGRect){0,0,kScreen_Width,headImgWidth*2}];
            view;
        });
    }return _tableViewHeaderView;
}
-(UIButton *)headImageView{
    if (!_headImageView) {
        _headImageView = ({
            UIButton *imageView = [UIButton buttonWithType:UIButtonTypeCustom];
            imageView.frame = CGRectMake(0, 0, headImgWidth, headImgWidth);
            imageView.cornerRadius = headImgWidth/2;
            imageView.clipsToBounds = YES;
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            [imageView setBackgroundImage:[UIImage imageNamed:@"placeholderImg"] forState:UIControlStateNormal];
            [imageView addTarget:self action:@selector(actionHeadImg) forControlEvents:UIControlEventTouchUpInside];
            imageView;
        });
    }return _headImageView;
}
-(void)actionHeadImg{
    [self actionChangeImg];
}
-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = ({
            UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.backgroundColor = [UIColor clearColor];
            tableView.sectionIndexBackgroundColor = [UIColor clearColor];
            tableView.sectionIndexTrackingBackgroundColor = [UIColor clearColor];
            tableView.sectionIndexColor = [UIColor groupTableViewBackgroundColor];
            tableView.estimatedSectionHeaderHeight = 0;
            tableView.estimatedSectionFooterHeight = 0;
            tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            tableView.showsVerticalScrollIndicator = NO;
            tableView.allowsMultipleSelectionDuringEditing = YES;
            tableView.tableHeaderView = [self tableViewHeaderView];
            //设置cell下划线从最左边开始
            //            if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            //                [tableView setSeparatorInset:UIEdgeInsetsZero];
            //            }
            //            if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            //                [tableView setLayoutMargins:UIEdgeInsetsZero];
            //            }
            
            //            tableView.tableHeaderView = [self tableHeader];
            //            tableView.tableFooterView = [self tableFooterView];
            //        [tableView registerClass:[CountryCodeCell class] forCellReuseIdentifier:kCellIdentifier_CountryCodeCell];
            
            UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, kSafeAreaBottomHeight+60, 0);
            tableView.contentInset = insets;
            tableView.scrollIndicatorInsets = insets;
            tableView;
        });
    }return _myTableView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 5;
    }
    else{
        return 5;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.textLabel.font = [UIFont systemFontOfSize:kTitleFontSize];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:kValueFontSize];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    UserModel *model = [UserManager readUserInfo];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"登录账号";
            cell.detailTextLabel.text = model.loginName;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        else if (indexPath.row == 1){
            cell.textLabel.text = @"用户类型";
            if ([model.facUserType isEqualToString:@"0"]) {
                cell.detailTextLabel.text = @"企业用户";
            }if ([model.facUserType isEqualToString:@"1"]) {
                cell.detailTextLabel.text = @"个人用户";
            }
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        else if (indexPath.row == 2){
            if ([model.facUserType isEqualToString:@"0"]) {
                //企业
                cell.textLabel.text = @"公司名称";
                cell.detailTextLabel.text = @"ToDo:0123";
                cell.accessoryType = UITableViewCellAccessoryNone;
            }else{
                //个人
                cell.textLabel.text = @"会员状态";
                if ([model.facIsTrade isEqualToString:@"0"]) {
                    cell.detailTextLabel.text = @"普通会员";
                }
                if ([model.facIsTrade isEqualToString:@"1"]) {
                    cell.detailTextLabel.text = @"交易会员";
                }
            }
        }
        else if (indexPath.row == 3){
            cell.textLabel.text = @"联系人";
            cell.detailTextLabel.text = model.caseName;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        else if (indexPath.row == 4){
            cell.textLabel.text = @"注册手机";
            cell.detailTextLabel.text = model.mobil;
        }
    }else{
        if (indexPath.row == 0) {
            cell.textLabel.text = @"会员状态";
            if ([model.facIsTrade isEqualToString:@"0"]) {
                cell.detailTextLabel.text = @"普通会员";
            }
            if ([model.facIsTrade isEqualToString:@"1"]) {
                cell.detailTextLabel.text = @"交易会员";
            }
        }
        else if (indexPath.row == 1){
            cell.textLabel.text = @"业务联系人";
            cell.detailTextLabel.text = @"ToDo:0123";
        }
        else if (indexPath.row == 2){
            cell.textLabel.text = @"业务操作认证手机";
            cell.detailTextLabel.text = @"ToDo:0123";
        }
        else if (indexPath.row == 3){
            cell.textLabel.text = @"财务联系人";
            cell.detailTextLabel.text = @"ToDo:0123";
        }
        else if (indexPath.row == 4){
            cell.textLabel.text = @"财务操作认证手机";
            cell.detailTextLabel.text = @"ToDo:0123";
        }
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {

        }else if (indexPath.row == 1){

        }
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {

        }
        else if (indexPath.row == 1){

        }
        else if (indexPath.row == 2){

        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"账号基本信息";
    }else{
        return @"资金操作信息";
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    // 设置section背景颜色
    view.tintColor = [UIColor groupTableViewBackgroundColor];
    
    // 设置section字体颜色
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.textColor = UIColor.grayColor;
    header.textLabel.font = [UIFont systemFontOfSize:13];
}
@end
