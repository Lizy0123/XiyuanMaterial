//
//  AppDelegate.h
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/6/5.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;

-(void)configTabBarController;
-(void)configGuidePageController;

@end

