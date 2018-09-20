//
//  X_ShaiXuanTableViewController.h
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/6/8.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class X_ShaiXuanTableViewController;

@protocol shaiXuanDelegate <NSObject>


@required

-(void)postBackController:(X_ShaiXuanTableViewController *)shaixuanController postBackCode:(NSString *)acode;


@end






@interface X_ShaiXuanTableViewController : UITableViewController
//代理
@property (nonatomic,weak)id<shaiXuanDelegate>shaiXuandelegate;

@property(nonatomic,copy)NSString *code;



@end
