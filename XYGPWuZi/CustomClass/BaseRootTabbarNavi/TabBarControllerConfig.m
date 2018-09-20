//
//  TabBarControllerConfig.m
//  XYGPWuZi
//
//  Created by Lzy on 2017/12/30.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "TabBarControllerConfig.h"
#import <UIKit/UIKit.h>

static CGFloat const CYLTabBarControllerHeight = 40.f;

#pragma mark - V3.0
#import "MyHomeViewController.h"
#import "MyBiddingViewController.h"
#import "JiTuanZhuanChangViewController.h"


#import "XianZhiQiuGouViewController.h"
#import "HuiYuanZhongXinViewController.h"

@interface TabBarControllerConfig ()<UITabBarControllerDelegate>
@property (nonatomic, readwrite, strong) BaseTabBarController *tabBarController;

@end


@implementation TabBarControllerConfig
/**
 *  lazy load tabBarController
 *
 *  @return CYLTabBarController
 */
- (BaseTabBarController *)tabBarController {
    if (_tabBarController == nil) {
        /**
         * 以下两行代码目的在于手动设置让TabBarItem只显示图标，不显示文字，并让图标垂直居中。
         * 等效于在 `-tabBarItemsAttributesForController` 方法中不传 `CYLTabBarItemTitle` 字段。
         * 更推荐后一种做法。
         */
        UIEdgeInsets imageInsets = UIEdgeInsetsZero;//UIEdgeInsetsMake(4.5, 0, -4.5, 0);
        UIOffset titlePositionAdjustment = UIOffsetZero;//UIOffsetMake(0, MAXFLOAT);
        
        BaseTabBarController *tabBarController = [BaseTabBarController tabBarControllerWithViewControllers:self.viewControllers tabBarItemsAttributes:self.tabBarItemsAttributesForController imageInsets:imageInsets titlePositionAdjustment:titlePositionAdjustment context:self.context ];
        [self customizeTabBarAppearance:tabBarController];
        _tabBarController = tabBarController;
    }
    return _tabBarController;
}

- (NSArray *)viewControllers {
    UIViewController *HomeNavigationController = [[BaseMyNavigationController alloc] initWithRootViewController:[MyHomeViewController new]];

    UIViewController *XRGongGaoNavigationController = [[BaseMyNavigationController alloc] initWithRootViewController:[MyBiddingViewController new]];
    UIViewController *IdleProductNavigationController = [[BaseMyNavigationController alloc] initWithRootViewController:[JiTuanZhuanChangViewController new]];
    UIViewController *MemberCenterNavigationController = [[BaseMyNavigationController alloc] initWithRootViewController:[HuiYuanZhongXinViewController new]];
    return @[HomeNavigationController, XRGongGaoNavigationController, IdleProductNavigationController, MemberCenterNavigationController];
}

- (NSArray *)tabBarItemsAttributesForController {
    NSDictionary *firstTabBarItemsAttributes = @{CYLTabBarItemTitle : @"首页",
                                                 CYLTabBarItemImage : @"tabbar_main",  /* NSString and UIImage are supported*/
                                                 CYLTabBarItemSelectedImage : @"tabbar_main_s", /* NSString and UIImage are supported*/
                                                 };
    NSDictionary *secondTabBarItemsAttributes = @{CYLTabBarItemTitle : @"竞价专区",
                                                  CYLTabBarItemImage : @"tabbar_second",
                                                  CYLTabBarItemSelectedImage : @"tabbar_second_s",
                                                  };
    NSDictionary *thirdTabBarItemsAttributes = @{CYLTabBarItemTitle : @"集团专场",
                                                 CYLTabBarItemImage : @"tabbar_third",
                                                 CYLTabBarItemSelectedImage : @"tabbar_third_s",
                                                 };
    NSDictionary *fourthTabBarItemsAttributes = @{CYLTabBarItemTitle : @"会员中心",
                                                  CYLTabBarItemImage : @"tabbar_me",
                                                  CYLTabBarItemSelectedImage : @"tabbar_me_s"
                                                  };
    return @[firstTabBarItemsAttributes, secondTabBarItemsAttributes, thirdTabBarItemsAttributes, fourthTabBarItemsAttributes];
}

/**
 *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性等等
 */
- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
    // Customize UITabBar height
    // 自定义 TabBar 高度
    tabBarController.tabBarHeight = kTabBarHeight;
    
    // set the text color for unselected state
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = kColorNav;
    
    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // Set the dark color to selected tab (the dimmed background)
    // TabBarItem选中后的背景颜色
    // [self customizeTabBarSelectionIndicatorImage];
    
    // update TabBar when TabBarItem width did update
    // If your app need support UIDeviceOrientationLandscapeLeft or UIDeviceOrientationLandscapeRight，
    // remove the comment '//'
    // 如果你的App需要支持横竖屏，请使用该方法移除注释 '//'
    // [self updateTabBarCustomizationWhenTabBarItemWidthDidUpdate];
    
    // set the bar shadow image
    // This shadow image attribute is ignored if the tab bar does not also have a custom background image.So at least set somthing.
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    //    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tapbar_top_line"]];
    
    // set the bar background image
    // 设置背景图片
    UITabBar *tabBarAppearance = [UITabBar appearance];
    
    //FIXED: #196
    UIImage *tabBarBackgroundImage = [UIImage imageNamed:@"tab_bar"];
    UIImage *scanedTabBarBackgroundImage = [[self class] scaleImage:tabBarBackgroundImage toScale:1.0];
     [tabBarAppearance setBackgroundImage:scanedTabBarBackgroundImage];
    
    // remove the bar system shadow image
    // 去除 TabBar 自带的顶部阴影
    // iOS10 后 需要使用 `-[CYLTabBarController hideTabBadgeBackgroundSeparator]` 见 AppDelegate 类中的演示;
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
}

- (void)updateTabBarCustomizationWhenTabBarItemWidthDidUpdate {
    void (^deviceOrientationDidChangeBlock)(NSNotification *) = ^(NSNotification *notification) {
        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        if ((orientation == UIDeviceOrientationLandscapeLeft) || (orientation == UIDeviceOrientationLandscapeRight)) {
            NSLog(@"Landscape Left or Right !");
        } else if (orientation == UIDeviceOrientationPortrait) {
            NSLog(@"Landscape portrait!");
        }
        [self customizeTabBarSelectionIndicatorImage];
    };
    [[NSNotificationCenter defaultCenter] addObserverForName:CYLTabBarItemWidthDidChangeNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:deviceOrientationDidChangeBlock];
}

- (void)customizeTabBarSelectionIndicatorImage {
    ///Get initialized TabBar Height if exists, otherwise get Default TabBar Height.
    CGFloat tabBarHeight = CYLTabBarControllerHeight;
    CGSize selectionIndicatorImageSize = CGSizeMake(CYLTabBarItemWidth, tabBarHeight);
    //Get initialized TabBar if exists.
    UITabBar *tabBar = [self cyl_tabBarController].tabBar ?: [UITabBar appearance];
    [tabBar setSelectionIndicatorImage:
     [[self class] imageWithColor:[UIColor yellowColor]
                             size:selectionIndicatorImageSize]];
}

+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize {
    UIGraphicsBeginImageContext(CGSizeMake([UIScreen mainScreen].bounds.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width + 1, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end



#import "AddProductViewController.h"
#import "FaBuXuQiuViewController.h"
#import "MyProductViewController.h"

@interface PlusButtonSubclass ()

@end

@implementation PlusButtonSubclass

#pragma mark -
#pragma mark - Life Cycle

+ (void)load {
    //请在 `-[AppDelegate application:didFinishLaunchingWithOptions:]` 中进行注册，否则iOS10系统下存在Crash风险。
    //[super registerPlusButton];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

//上下结构的 button
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 控件大小,间距大小
    // 注意：一定要根据项目中的图片去调整下面的0.7和0.9，Demo之所以这么设置，因为demo中的 plusButton 的 icon 不是正方形。
    CGFloat const imageViewEdgeWidth   = self.bounds.size.width * 0.7;
    CGFloat const imageViewEdgeHeight  = imageViewEdgeWidth * 0.9;
    
    CGFloat const centerOfView    = self.bounds.size.width * 0.5;
    CGFloat const labelLineHeight = self.titleLabel.font.lineHeight;
    CGFloat const verticalMargin  = (self.bounds.size.height - labelLineHeight - imageViewEdgeHeight) * 0.5;
    
    // imageView 和 titleLabel 中心的 Y 值
    CGFloat const centerOfImageView  = verticalMargin + imageViewEdgeHeight * 0.5;
    CGFloat const centerOfTitleLabel = imageViewEdgeHeight  + verticalMargin * 2 + labelLineHeight * 0.5 + 5;
    
    //imageView position 位置
    self.imageView.bounds = CGRectMake(0, 0, imageViewEdgeWidth, imageViewEdgeHeight);
    self.imageView.center = CGPointMake(centerOfView, centerOfImageView);
    
    //title position 位置
    self.titleLabel.bounds = CGRectMake(0, 0, self.bounds.size.width, labelLineHeight);
    self.titleLabel.center = CGPointMake(centerOfView, centerOfTitleLabel);
}

#pragma mark -
#pragma mark - CYLPlusButtonSubclassing Methods

/*
 *
 Create a custom UIButton with title and add it to the center of our tab bar
 *
 */
+ (id)plusButton {
    PlusButtonSubclass *button = [[PlusButtonSubclass alloc] init];
    [button setImage:[UIImage imageNamed:@"tabbar_middle"] forState:UIControlStateNormal];
    
    [button setTitle:@"发布" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [button setTitle:@"发布" forState:UIControlStateSelected];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    
    button.titleLabel.font = [UIFont systemFontOfSize:9.5];
    [button sizeToFit]; 
    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
    return button;
}


#pragma mark -
#pragma mark - Event Response

- (void)clickPublish {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"添加产品" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
        BaseNavigationController *viewController = tabBarController.selectedViewController;
        if ([kStringToken length]) {
            AddProductViewController *vc = [[AddProductViewController alloc]init];
            vc.title = @"添加产品";
            //            vc.imageUrlArray = nil;
            [viewController pushViewController:vc animated:YES];
        }else{
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            BaseMyNavigationController *nav = [[BaseMyNavigationController alloc] initWithRootViewController:loginVC];
            [viewController presentViewController:nav animated:YES completion:^{
            }];
        }
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"发布需求" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
        BaseNavigationController *viewController = tabBarController.selectedViewController;
        if ([kStringToken length]) {
            FaBuXuQiuViewController *vc = [[FaBuXuQiuViewController alloc]init];
            vc.title = @"发布需求";
            [viewController pushViewController:vc animated:YES];
        }else{
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            BaseMyNavigationController *nav = [[BaseMyNavigationController alloc] initWithRootViewController:loginVC];
            [viewController presentViewController:nav animated:YES completion:^{
            }];
        }
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"发起竞价" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
        BaseNavigationController *viewController = tabBarController.selectedViewController;
        if ([kStringToken length]) {
            MyProductViewController *vc = [MyProductViewController new];
            vc.selectedPage = 1;
            [viewController pushViewController:vc animated:YES];
        }else{
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            BaseMyNavigationController *nav = [[BaseMyNavigationController alloc] initWithRootViewController:loginVC];
            [viewController presentViewController:nav animated:YES completion:^{
            }];
        }
    }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {

    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    [alert addAction:cancelAction];
    
    CYLTabBarController *tabBarController = [self cyl_tabBarController];
    [tabBarController.selectedViewController presentViewController:alert animated:YES completion:nil];
}

+ (CGFloat)multiplierOfTabBarHeight:(CGFloat)tabBarHeight {
    return  0.3;
}

+ (CGFloat)constantOfPlusButtonCenterYOffsetForTabBarHeight:(CGFloat)tabBarHeight {
    return  -10;
}
@end


