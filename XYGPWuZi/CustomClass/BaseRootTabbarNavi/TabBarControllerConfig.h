//
//  TabBarControllerConfig.h
//  XYGPWuZi
//
//  Created by Lzy on 2017/12/30.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseTabBarController.h"

@interface TabBarControllerConfig : NSObject
@property (nonatomic, readonly, strong) BaseTabBarController *tabBarController;
@property (nonatomic, copy) NSString *context;

@end

@interface PlusButtonSubclass : CYLPlusButton <CYLPlusButtonSubclassing>

@end
