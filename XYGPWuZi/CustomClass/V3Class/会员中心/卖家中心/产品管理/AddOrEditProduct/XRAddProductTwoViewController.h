//
//  XRAddProductTwoViewController.h
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/10/8.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTextView.h"

@interface XRAddProductTwoViewController : UIViewController

@property (nonatomic,strong)NSMutableArray *imageUrlArray;
@property(nonatomic,strong)NSMutableArray *imageArray;
//主键id如果添加,不需要传
@property (nonatomic,copy)NSString *piId;

@property(nonatomic,copy)NSString *name;
//类别
@property (nonatomic,copy)NSString *piCateFirst;
@property (nonatomic,copy)NSString *piCateSecond;
@property (nonatomic,copy)NSString *piCateThird;


@property(nonatomic,copy)NSString *shuliang;

@property(nonatomic,copy)NSString *danwei;

@property(nonatomic,copy)NSString *xinghao;

@property(nonatomic,copy)NSString *pinpai;

@property(nonatomic,copy)NSString *xinjiu;

@property(nonatomic,copy)NSString *zhuangtai;

@property(nonatomic,copy)NSString *workTime;

@property(nonatomic,copy)NSString *time;

@property(nonatomic,copy)NSString *minPrice;

@property(nonatomic,copy)NSString *address;

@property(nonatomic,copy)NSString *piProvince;
@property(nonatomic,copy)NSString *piCity;
@property(nonatomic,copy)NSString *piCounty;


@property (nonatomic,strong)UITextField *textField1;
@property (nonatomic,strong)UITextField *textField2;
@property (nonatomic,strong)UITextField *textField3;
@property (nonatomic,strong)UITextField *textField4;
@property (nonatomic,strong)UITextField *textField5;
@property (nonatomic,strong)UITextField *textField6;

@property (nonatomic,strong)MyTextView *textView1;
@property (nonatomic,strong)MyTextView *textView2;
@end
