//
//  AddProductNextViewController.h
//  XYGPWuZi
//
//  Created by Lzy on 2018/1/12.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "BaseViewController.h"
#import "AddProductModel.h"

@interface AddProductNextViewController : BaseViewController
@property(assign, nonatomic)BOOL isEdit;
@property(strong, nonatomic)AddProductModel *addProductM;
@property(copy, nonatomic)NSArray *imgUrlArray;

@end
