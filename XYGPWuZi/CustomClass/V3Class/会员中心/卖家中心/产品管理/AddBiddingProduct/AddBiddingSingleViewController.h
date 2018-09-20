//
//  AddBiddingSingleViewController.h
//  XYGPWuZi
//
//  Created by Lzy on 2018/1/4.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "BaseViewController.h"
#import "AddBiddingModel.h"
#import "MyProductModel.h"

@interface AddBiddingSingleViewController : BaseViewController
@property(strong, nonatomic)AddBiddingModel *addBiddingM;
@property(strong, nonatomic)MyProductModel *myProductM;

@property(assign, nonatomic)BOOL isEdit;
@end
