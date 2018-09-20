//
//  XRFabuXuqiuViewController.h
//  XYGPWuZi
//
//  Created by apple on 2017/10/25.
//  Copyright © 2017年 xiaoRan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTextView.h"

@interface XRFabuXuqiuViewController : UIViewController

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
