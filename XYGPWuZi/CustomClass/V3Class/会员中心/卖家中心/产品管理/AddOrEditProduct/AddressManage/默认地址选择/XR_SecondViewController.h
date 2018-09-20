//
//  XR_SecondViewController.h
//  hhhhhhh
//
//  Created by apple on 2017/10/9.
//  Copyright © 2017年 xiaoRan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^addressBlock)(NSDictionary *);

@interface XR_SecondViewController : UIViewController

@property(nonatomic,copy)addressBlock blockAddress;

@end
