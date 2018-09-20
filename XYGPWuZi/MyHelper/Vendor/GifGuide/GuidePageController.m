//
//  GuidePageController.m
//  GuidePage
//
//  Created by LiYang on 16/5/30.
//  Copyright © 2016年 www.chinawutong.com. All rights reserved.
//

#import "GuidePageController.h"
#import "AppDelegate.h"
#import "BaseNavigationController.h"

#import "FLAnimatedImage.h"
#import "FLAnimatedImageView.h"

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

//随机颜色
#if 1
#define DEBUG_VIEW_COLOR [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1.0]
#else
#define DEBUG_VIEW_COLOR [UIColor clearColor]
#endif

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface GuidePageController ()
@property (weak, nonatomic) IBOutlet FLAnimatedImageView *animatedImageView;
@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UIButton *entryButton;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pageControlBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *entryButtonBottom;
@end

@implementation GuidePageController
- (void)viewDidLoad {
    [super viewDidLoad];
    _pageControl.defersCurrentPageDisplay = YES;
    
    UISwipeGestureRecognizer *rightSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    UISwipeGestureRecognizer *leftSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:rightSwipeGesture];
    [self.view addGestureRecognizer:leftSwipeGesture];
    
    self.animatedImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.animatedImageView.clipsToBounds = YES;
    self.animatedImageView.animatedImage = [self animatedImageWithURLForResource:@"GuidePage1"];
    self.entryButton.hidden = YES;
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.backgroundColor = [UIColor clearColor];
    _pageControl.pageIndicatorTintColor = [UIColor blackColor];
}

- (void)swipeAction:(UISwipeGestureRecognizer *)gesture{
    if (gesture.direction == UISwipeGestureRecognizerDirectionLeft) {
        if (self.pageControl.currentPage < 3) {
            self.pageControl.currentPage ++;
            [self.pageControl updateCurrentPageDisplay];
            switch (_pageControl.currentPage) {
                case 1:
                {
                    self.animatedImageView.animatedImage = [self animatedImageWithURLForResource:@"GuidePage2"];
                }
                    break;
                case 2:
                {
                    self.animatedImageView.animatedImage = [self animatedImageWithURLForResource:@"GuidePage3"];
                    [UIView animateWithDuration:0.3 animations:^{
                        
                        self.pageControl.alpha = 0;
//                        self.pageControlBottom.constant -= 50;
//                        [self.pageControl layoutIfNeeded];
                        
                    } completion:^(BOOL finished) {
                        self.entryButton.alpha = 1.0;
                        self.entryButton.hidden = NO;
                        if (iPhone6) {
                            //self.entryButtonBottom.constant += 70;
                        }else{
                            //self.entryButtonBottom.constant += 50;
                        }
                        //[self.entryButton layoutIfNeeded];
                    }];

                }
                    break;
               
                  
//                case 5:
//                {
//                    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//                    
//                    LoginViewController *controller = [[LoginViewController alloc] init];
//                    [appDelegate.window setRootViewController:controller];
//                }
//                    break;
                default:
                    break;
            }
            
        }
    }
    
    if (gesture.direction == UISwipeGestureRecognizerDirectionRight) {
        if (self.pageControl.currentPage > 0) {
            self.pageControl.currentPage --;
            [self.pageControl updateCurrentPageDisplay];
        }
        switch (_pageControl.currentPage) {
            case 0:
            {
                self.animatedImageView.animatedImage = [self animatedImageWithURLForResource:@"GuidePage1"];
            }
                break;
            case 1:
            {
                self.animatedImageView.animatedImage = [self animatedImageWithURLForResource:@"GuidePage2"];
                [UIView animateWithDuration:0.3 animations:^{
                    self.entryButton.alpha = 0;
                    if (iPhone6) {
                        self.entryButtonBottom.constant -= 70;
                    }else{
                        self.entryButtonBottom.constant -= 50;
                    }
                    [self.entryButton layoutIfNeeded];
                } completion:^(BOOL finished) {
                    self.pageControl.alpha = 1.0;
                    self.pageControlBottom.constant += 50;
                    [self.pageControl layoutIfNeeded];
                }];
                
                self.animatedImageView.animatedImage = [self animatedImageWithURLForResource:@"GuidePage3"];
            }
                break;
            default:
                break;
        }
    }
}

- (FLAnimatedImage *)animatedImageWithURLForResource:(NSString *)fileName {
    NSURL *url = [[NSBundle mainBundle] URLForResource:fileName withExtension:@"gif"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    FLAnimatedImage *animatedImage = [[FLAnimatedImage alloc] initWithAnimatedGIFData:data];
    return animatedImage;
}

- (IBAction)entryAction:(id)sender {
    [((AppDelegate *)[UIApplication sharedApplication].delegate) configTabBarController];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

#pragma mark - didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
