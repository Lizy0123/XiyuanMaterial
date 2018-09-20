//
//  PayForBailViewController.h
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/4/12.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "BaseViewController.h"
#import "Api_findDepositForUpdate.h"

@interface PayForBailViewController : BaseViewController
@property(assign, nonatomic)BOOL isSingle;
@property(strong, nonatomic)Model_Trade *tradeM;
@end
