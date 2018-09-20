//
//  FaBuXuQiuViewController.h
//  XYGPWuZi
//
//  Created by Lzy on 2018/1/2.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "BaseViewController.h"
#import "MyTextView.h"

@interface FaBuXuQiuViewController : BaseViewController
@property(nonatomic,strong)UITextField *textField1;
@property(nonatomic,strong)UITextField *textField2;
@property(nonatomic,strong)UITextField *textField3;
@property(nonatomic,strong)UITextField *textField4;
@property(nonatomic,strong)MyTextView *textView1;
@property(nonatomic,strong)UITextField *productAddressField;
@property(nonatomic,copy)NSString *piProvince;
@property(nonatomic,copy)NSString *piCity;
@property(nonatomic,copy)NSString *piCounty;
@end
