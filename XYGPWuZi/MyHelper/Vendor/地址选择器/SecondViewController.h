//
//  SecondViewController.h
//  地址选择器
//
//  Created by admin on 16/6/15.
//  Copyright © 2016年 sigxui-001. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^addressBlock)(NSDictionary *);

@interface SecondViewController : UIViewController

@property (nonatomic, copy) addressBlock blockAddress;


@end
