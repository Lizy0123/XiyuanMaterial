//
//  XRGongGaoViewController.h
//  XYGPWuZi
//
//  Created by apple on 2017/10/10.
//  Copyright © 2017年 xiaoRan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMPagerTabView.h"

@interface XRGongGaoViewController : UIViewController<SMPagerTabViewDelegate>

@property(nonatomic,assign)BOOL canGoBack;

@property(nonatomic,assign)NSInteger selectIndex;

@end
