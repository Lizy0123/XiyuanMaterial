//
//  AppDelegate.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/6/5.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "AppDelegate.h"
#import "GuidePageController.h"
#import "TabBarControllerConfig.h"
#import "FLEX.h"

@interface AppDelegate ()<UIActionSheetDelegate, UITabBarControllerDelegate, CYLTabBarControllerDelegate>

@end

@implementation AppDelegate
- (void)setHTTPRequestConfig{
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    //Release url
    config.baseUrl = myBaseUrl;
    config.cdnUrl = myCDNUrl;
    
    //设置全局请求公共参数
    //    LLYTKUrlCommonParamsFilter *urlFilter = [LLYTKUrlCommonParamsFilter my_filterWithArguments:
    //                                                @{@"version": @"1.0"}];
    
    //    [config addUrlFilter:urlFilter];
    
    //KVC返回设置contentType
    //    NSSet *contentTypeSet = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json",@"text/html",@"text/css", nil];
    //    [[YTKNetworkAgent sharedAgent] setValue:contentTypeSet forKeyPath:@"_manager.responseSerializer.acceptableContentTypes"];
    
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
#pragma mark - Flex
#ifdef DEBUG
    [[FLEXManager sharedManager] showExplorer];
#else
#endif
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    [self setHTTPRequestConfig];
        //保存当前版本
    NSString *currentAppVersion = [[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleShortVersionString"];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *appVersion = [userDefaults objectForKey:@"appVersion"];
    
    //    判断当前版本和之前版本，如果为nil或不一样，执行启动图
    if (appVersion == nil || ![appVersion isEqualToString:currentAppVersion]) {
        [userDefaults setValue:currentAppVersion forKey:@"appVersion"];
        [self configGuidePageController];
    }else{
        [self configTabBarController];
    }
    [self.window makeKeyAndVisible];
    return YES;
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectControl:(UIControl *)control {
//    UIView *animationView;
    
//    if ([control cyl_isTabButton]) {
//        //更改红标状态
//        if ([[self cyl_tabBarController].selectedViewController cyl_isShowTabBadgePoint]) {
//            [[self cyl_tabBarController].selectedViewController cyl_removeTabBadgePoint];
//        } else {
//            [[self cyl_tabBarController].selectedViewController cyl_showTabBadgePoint];
//        }
//
//        animationView = [control cyl_tabImageView];
//    }
//
//    // 即使 PlusButton 也添加了点击事件，点击 PlusButton 后也会触发该代理方法。
//    if ([control cyl_isPlusButton]) {
//        UIButton *button = CYLExternPlusButton;
//        animationView = button.imageView;
//    }
    
}
-(void)configTabBarController{
    [PlusButtonSubclass registerPlusButton];
    [self.window setRootViewController:[TabBarControllerConfig new].tabBarController];
}
-(void)configGuidePageController{
    [self.window setRootViewController:[GuidePageController new]];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"XYGPWuZi"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
