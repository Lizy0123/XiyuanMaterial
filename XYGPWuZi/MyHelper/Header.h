//
//  Header.h
//  XYGPWuZi
//
//  Created by Lzy on 2017/12/15.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.

#ifndef Header_h
#define Header_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef struct _MyPage{
    NSUInteger pageSize;
    NSUInteger pageIndex;
}MyPage;

typedef NS_ENUM(NSInteger, kMyProductAuditStatus) {
    kMyProductAuditStatus_Success = 0, //已审核
    kMyProductAuditStatus_ToDo = 1, //待审核
    kMyProductAuditStatus_Reject = 2, //未通过
};
typedef NS_ENUM(NSInteger, kMyTradeSiteStatus) {
    kMyTradeSiteStatus_WaitPublic = 0,//待发布
    kMyTradeSiteStatus_PublicSuccess = 1, //已发布
    kMyTradeSiteStatus_BiddingNow = 2, //竞价中
    kMyTradeSiteStatus_WaitReciveMoney = 3, //待收款
    kMyTradeSiteStatus_WaitReciveProduct = 4, //待提货
    kMyTradeSiteStatus_BiddingSuccess = 5, //竞价成功
    kMyTradeSiteStatus_Failure = 6, //竞价失败
    
};
//我的竞价列表状态
typedef NS_ENUM(NSInteger, kMyJingJingListStatus){
    kMyJingJingListStatusYiBaoMing = 0,//已报名
    kMyJingJingListStatusYiCanJia = 1,//已参加
    kMyJingJingListStatusStarted = 2,//竞价中,开始竞价
    kMyJingJingListStatusWaitingTopay = 3,//待付款
    kMyJingJingListStatusAlreadyPay = 4,//待提货
    kMyJingJingListStatusSuccess = 5,//交易成功
    kMyJingJingListStatusFaild =6,//竞拍失败(流拍或者被别人买走)
};

typedef NS_ENUM(NSUInteger, KNSemiModalTransitionStyle) {
    KNSemiModalTransitionStyleSlideUp,
    KNSemiModalTransitionStyleFadeInOut,
    KNSemiModalTransitionStyleFadeIn,
    KNSemiModalTransitionStyleFadeOut,
};

#import "BaseNavigationController.h"
#import "BaseMyNavigationController.h"
#import "BaseViewController.h"
#import "UserModel.h"
#import "LoginViewController.h"


#import "AFNetworking.h"
#import "YTKNetworkConfig.h"
#import "YTKNetworkAgent.h"
#import "YTKBatchRequest+AnimatingAccessory.h"
#import "YTKChainRequest+AnimatingAccessory.h"

#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "Helper.h"
#import "Masonry.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "ZJScrollPageView.h"
#import "CYLConstants.h"
#import "IQKeyboardManager.h"

#pragma mark - Category
#import "NSObject+Common.h"
#import "NSString+Common.h"
#import "UIBarButtonItem+Common.h"
#import "UIView+Common.h"
#import "UIView+Toast.h"
#import "UIButton+Common.h"
#import "UIImage+Common.h"
#import "UISearchBar+Common.h"
#import "UILabel+Common.h"


#pragma mark UserURL
#ifdef DEBUG
/////13测试服务器
//#define myBaseUrl @"http://192.168.0.13/XYGPWuzi_App/"//网络请求开头
//#define myCDNUrl @"http://192.168.0.14/XiYuanUpload/"//图片服务器地址
//#define mySocketBaseUrl @"http://192.168.0.13:3000"//socket连接的网址

///雪纯测试服务//5418
//#define myBaseUrl @"http://192.168.0.121/XYGPWuzi_App/"//网络请求开头
//#define myCDNUrl @"http://192.168.0.14/XiYuanUpload/"//图片服务器地址
//#define mySocketBaseUrl @"http://192.168.0.13:3000"//socket连接的网址

#define myBaseUrl @"http://app.xz.gpwuzi.com/"//网络请求开头
#define myCDNUrl @"http://img.gpwuzi.com/XiYuanUpload/"//图片服务器地址
#define mySocketBaseUrl @"http://socket.gpwuzi.com"//socket连接的网址

#else//else
#define myBaseUrl @"http://app.xz.gpwuzi.com/"//网络请求开头
#define myCDNUrl @"http://img.gpwuzi.com/XiYuanUpload/"//图片服务器地址
#define mySocketBaseUrl @"http://socket.gpwuzi.com"//socket连接的网址
#endif

#define kImgUrl_Light @"https://www.apple.com/newsroom/images/live-action/wwdc-2018/Apple_Design_Awards_06072018_big.jpg.large.jpg"
#define kImgUrl_Dark @"https://www.apple.com/newsroom/images/live-action/wwdc-2017/wwdc_design_awards_cube_big.jpg.large.jpg"
//#define kImgUrl @"https://www.apple.com/newsroom/images/values/connected/Student_captures_video_on_iPad_03272018_big.jpg.large.jpg"
//#define kImgUrl @"https://www.apple.com/newsroom/images/product/apps/lifestyle/Apple-Watch-records-ski-workouts-02282018_big.jpg.large.jpg"

#pragma mark - 关于所有的接口链接
#pragma mark - UserInfo&&Login&&Regist
#define kPath_FindUserLogin @"xy/user/login.json"//登录
#define kPath_FindLoginOut @"xy/user/layout.json"//退出登录
#define kPath_FindBackUserPwd @"xy/user/modifypwd.json"//找回密码
#define kPath_SaveRegisterUser @"xy/user/register.json"//注册
#define kPath_UpdateUserPwd @"xy/user/token/modifypwd.json"//会员中心-密码修改
#define kPath_CheckMobileCode @"xy/user/token/checkMobileCode.json"//V2.0-会员中心-手机号修改第一步校验验证码
#define kPath_UpadteMobile @"xy/user/token/modifyMobile.json"//V2.0-会员中心-手机号修改
//#define sendYzmUrl @"xy/user/send.json"//手机验证码
#define kMyImageColor UIColor.blackColor

#pragma mark - 首页
#pragma mark V2.0-首页-主搜索//公告:tnTitle(公告标题)|预告:tnTitle(预告标题)|产品:piName(产品名称)|需求:riKeyword(需求关键字)

//V2.0-求购信息-求购信息列表//需求
#define kPath_FindRequInfoList @"/xy/requirement/list.json"
//V2.0-闲置购-闲置购列表 18、首页的搜索功能接口
#define kPath_ProductList @"xy/product/list.json"
//59、V2.0-求购信息-求购信息详情
#define kPath_FindRequInfoDetail @"xy/requirement/detail.json"
//V2.0-闲置购-闲置购详情-发送购买意愿 V2.0-求购信息-求购信息详情-发送供应意愿
#define kPath_LeaveMessage @"xy/leave/token/message.json"
//38、V2.0-会员中心-我的需求-发布需求（添加和编辑通用接口）
#define kPath_FabuXuqiu @"xy/requirement/token/member/edit.json"
//56、V2.0-闲置购-闲置购详情
#define kPath_ProductDetail @"xy/product/detail.json"
//16、筛选
#define kPath_ShaixuanList @"xy/category/getThirdList.json"
//25、V2.0-公告-公告详情页和成交案例详情
#define kPath_TradeNoticeDetail @"xy/tradeNotice/detail.json"
//17、报名参加竞价
#define kPath_GoTrade @"xy/tradeNotice/token/goTrade.json"
//7、开始竞价|竞价结果
#define kPath_GetBidInfo @"xy/tradeSite/token/getBidInfo.json"


#pragma mark - 公告
//公告--交易预告
#define kPath_AdvanceNoticeList @"xy/advanceNotice/getAdvanceNoticeList.json"/*pageNum：页码（默认1）|pageSize：显示的条数（默认10）|tnTitle:预告标题 */
//V2.0-类别-获取一级类别的名称和ID//proCategoryId：类别id categoryName：类别名称
#define kPath_GetFirstListId @"xy/category/getFirstList.json"
//V2.0-竞价公告列表页和成交案例列表
#define kPath_TradeNoticeList @"xy/tradeNotice/getList.json"
//V2.0-公告-交易预告-交易预告列表
#define kPath_SearchAdvanceNotice @"/xy/advanceNotice/getAdvanceNoticeList.json"
//V2.0-公告-交易预告-交易预告详情
#define kPath_GetAdvanceNoticeDetail @"xy/advanceNotice/getAdvanceNoticeDetail.json"


#pragma mark - 闲置物资
#define kProductCategoryCache @"kProductCategoryCache"
#define kProductCategoryCacheAll @"kProductCategoryCacheAll"
//V2.0-闲置购-闲置购列表
#define kPath_FindProductList @"xy/product/list.json"/*pageNum：页码（默认值1） | pageSize：每页显示条数（默认值10）| piDqzt：当前状态(0,正常使用，1故障，2报废，3其它) | piCateFirst.proCategoryId:一级类别id |piCateSecond.proCategoryId：二级类别ID（没有第三级类别的产品传二级类别的ID）| piCateThird.proCategoryId：三级类别ID（第三级触发查询）| piName：产品关键字 | piCpcd：品牌关键字 | piCpxh：型号关键字 */


#pragma mark - 会员中心
//V2.0-会员中心-我的产品列表
#define kPath_FindMyProductList @"xy/product/token/member/list.json"/*token：登录令牌 | pageNum：页码（默认值1） | pageSize：每页显示条数（默认值10）| piStatus：（0、待审核 1、已审核 2、未通过） */
//V2.0-会员中心-我的产品列表-上架（寄售）和下架
#define kPath_UpdateProductIsSj @"xy/product/token/member/sale.json"/* token：登录令牌 | piId：产品主键ID | status：寄售按钮(传参数：1) 下架（传参数：0） */
//V2.0-会员中心-我的产品列表-未通过-查看反馈
#define kPath_FindProductReson @"xy/product/token/member/reason.json"/* token：登录令牌 | piId：产品主键ID */
//V2.0-会员中心-生成和更新单品、拼盘场次
#define kPath_SaveOrUpdateTradeSite @"xy/tradeSite/token/saveOrUpdateTradeSite.json"/*token：登录令牌 |tsId:场次ID（生成场次不需要该参数，更新场次需要该参数）| tsSiteType：场次类型（0单品1拼盘）| tsName：场次名称 | tsNoticeDate：公告日 | tsTradeDate：竞价日 | tsStartTime：开始时间 | tsEndTime：结束时间 | tsMinPrice：起始价 | tsProtectPrice：最低出售价 | tsAddPrice：加价幅度 | tsCountPrice：总价格 | tsNum：数量 | tsUnits：单位 | tsTradeType:报盘方式（0：单价报盘1：总价报盘）| tsJjfs：计价方式（0：重量计价1：数量计价）| 交易方式（0：公开增价）| tradeProducts（场次中产品的集合，单品场次集合中一条数据，拼盘场次集合中多条数据，集合中的参数 -- piId：产品ID | piNumber：产品数量） */
//V2.0-会员中心-我的场次
#define kPath_GetTradeSiteList @"xy/tradeSite/token/getTradeSiteList.json"/*pageNum：页码（默认1）|pageSize：显示的条数（默认5）|token（登录token）|tsProcess (流程 0：已报名 1：已参加 2：竞价中 3：待支付 4：待提货 5：竞价完成 6:竞价失败) */
//V2.0-会员中心-我的场次-删除待发布的场次
#define kPath_DeleteTradeSite @"xy/tradeSite/token/deleteTradeSite.json"/*token：登录令牌 | tsId：场次id */
//V2.0-会员中心-我的场次-更新前查找场次信息
#define kPath_FindTradeSiteForUpdate @"xy/tradeSite/token/findTradeSiteForUpdate.json"/*token：登录令牌 |tsId:场次ID */
//V2.0-会员中心-我的场次-出价记录
#define kPath_GetTradeSiteProcessList @"xy/tradeSite/token/getTradeSiteProcessList.json"/*token（登录token）| id(场次ID) */
//V2.0-会员中心-我的场次-查看成交结果
#define kPath_GetTradeSiteDetailInBidList @"xy/tradeSite/token/getTradeSiteDetail.json"/*tsId（场次id）|token（登录token）|type(0查询我的竞价成交结果1查询支付货款界面信息2我的场次成交结果) */
//会员中心-我的竞价列表页
#define kPath_GetBidList @"xy/tradeSite/token/getBidList.json"
//12、上传图片
#define kPath_UpLoadPic @"xy/upload/pic.json"
//V2.0-会员中心-我的产品编辑（添加和修改）
#define kPath_AddProduct @"xy/product/token/member/edit.json"
//52、V2.0-会员中心-我的产品修改更新前数据查询
#define kPath_EdictProductInfo @"xy/product/token/member/find/edit.json"
//15、会员中心-账户信息修改
#define kPath_ModifyUserInfo @"xy/user/token/modify/info.json"
//V2.0-会员中心-消息中心列表页和会员中心首页需求留言通知的数量
#define kPath_MessageCenterIndexCount @"xy/messageCenter/token/MessageCenterIndexCount.json"




#pragma mark - 常用宏定义
#define kToken @"token"
#define kStringToken [[NSUserDefaults standardUserDefaults] objectForKey:kToken]
#define kStringSessionId [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId]?[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId]:@""

#define kTradeSiteCache @"kTradeSiteCache"
#define kStrShowFilter @"kStrShowFilter"
#define kStrSaveFilterDic @"kStrSaveFilterDic"

#define kBadgeTipStr @"badgeTip"
#define KEY_USER_picurl @"KEY_USER_picurl"

#define kColorMain kColorNav

#define StrHome @"首页"
#define StrSecond @"拍卖"
#define StrMiddle @"易物"
#define StrThird @"店铺"
#define StrMine @"我的"


#pragma mark - Define
#define kMyPadding 15.0f
#define kTagHome 1000
#define kTagSecond 2000
#define kTagMiddle 3000
#define kTagThird 4000
#define kTagMine 5000

static const CGFloat kTitleFontSizeLarger = 20.f;
static const CGFloat kTitleFontSizeLarge = 17.f;
static const CGFloat kTitleFontSizeMiddle = 15.f;
static const CGFloat kTitleFontSizeSmall = 13.f;


static const CGFloat kTitleFontSize = 14.f;
static const CGFloat kSubTitleFontSize = 13.f;
static const CGFloat kValueFontSize = 13.f;
static const CGFloat kContentFontSize = 13.f;




#pragma mark - Define
#define kColorPlaceholder [UIColor colorWithRed:213/255.0 green:213/255.0 blue:213/255.0 alpha:1]
#define kColorGary [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1]

#define kColorBorder [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1]
#define kColorTitleStr kColorHex(0x1D1D1D)
#define kColorValueStr kColorHex(0x999999)
#define kColorDescStr kColorHex(0x353535)
#define kColorSeparate kColorHex(0xF5F5F5)


#define kColorMainTitle kColorHex(0x323A45)
#define kColorTableBG kColorHex(0xFFFFFF)
#define kColorTableSectionBg kColorHex(0xF2F4F6)
#define kColor222 kColorHex(0x222222)
#define kColor666 kColorHex(0x666666)
#define kColor999 kColorHex(0x999999)
#define kColorDDD kColorHex(0xDDDDDD)
#define kColorCCC kColorHex(0xCCCCCC)
#define kColorBrandGreen kColorHex(0x3BBD79)
#define kColorBrandRed kColorHex(0xFF5846)
#define kColorNav [UIColor colorWithRed:15 / 255.0 green:212 / 255.0 blue:172 / 255.0 alpha:1]
#define kColorBorder [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1]
#define kColorNavTitle kColorHex(0x323A45)





#ifdef DEBUG
//Log
#define NSLog(FORMAT, ...) fprintf(stderr,"%s(%ld)%s\n%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], (long)__LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
//Alert
#define MyAlert(TITLE,MSG) [[[UIAlertView alloc] initWithTitle:(TITLE) \
message:(MSG) \
delegate:nil \
cancelButtonTitle:@"确定" \
otherButtonTitles:nil] show]
//Array
#define MyArray [NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"",@"",@"", nil]
#else
#define NSLog(FORMAT, ...) nil
#define MyAlert(TITLE,MSG) nil
#define MyArray [NSMutableArray new]
#endif

//机型判断
#pragma mark - Device
#define kScaleFrom_iPhone5_Desgin(_X_) (_X_ * (kScreen_Width/320))
#define kDevice_iPhone4     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_iPhone5     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_iPhone6     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_iPhoneX     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)


//OS系统
#pragma mark - Edition
#define kIOSVersion             ((float)[[[UIDevice currentDevice] systemVersion] doubleValue])
//Edition
#define kEdition_iOS7           (([UIDevice currentDevice].systemVersion.floatValue >= 7.0f && [UIDevice currentDevice].systemVersion.floatValue < 8.0) ? YES : NO)
#define kEdition_iOS7OrLater    (([UIDevice currentDevice].systemVersion.floatValue >= 7.0f) ? YES : NO)
#define kEdition_iOS8           (([UIDevice currentDevice].systemVersion.floatValue >= 8.0f && [UIDevice currentDevice].systemVersion.floatValue < 9.0f) ? YES : NO)
#define kEdition_iOS8OrLater    (([UIDevice currentDevice].systemVersion.floatValue >= 8.0f) ? YES : NO)
#define kEdition_iOS9           (([UIDevice currentDevice].systemVersion.floatValue >= 9.0f && [UIDevice currentDevice].systemVersion.floatValue < 10.0f) ? YES : NO)
#define kEdition_iOS9OrLater    (([UIDevice currentDevice].systemVersion.floatValue >= 9.0f) ? YES : NO)
#define kEdition_iOS10          (([UIDevice currentDevice].systemVersion.floatValue >= 10.0f && [UIDevice currentDevice].systemVersion.floatValue < 11.0f) ? YES : NO)
#define kEdition_iOS10OrLater   (([UIDevice currentDevice].systemVersion.floatValue >= 10.0f) ? YES : NO)
#define kEdition_iOS11          (([[UIDevice currentDevice].systemVersion floatValue] >= 11) ? YES : NO)
#define kEdition_iOS_EqualTo(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define kEdition_iOS_GreaterThan(v)             ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define kEdition_iOS_GreaterThanOrEqualTo(v)    ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define kEdition_iOS_LessThan(v)                ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define kEdition_iOS_LessThanOrEqualTo(v)       ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


//颜色
#pragma mark - Color
#define kColorRGB(r,g,b) [UIColor colorWithRed:(CGFloat)(r)/255.0 green:(CGFloat)(g)/255.0 blue:(CGFloat)(b)/255.0 alpha:1]
#define kColorHex(hexValue) [UIColor \
colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
green:((float)((hexValue & 0xFF00) >> 8))/255.0 \
blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]



//Frame
#pragma mark - Frame
#define S_W [UIScreen mainScreen].bounds.size.width
#define S_H [UIScreen mainScreen].bounds.size.height
#define kScreen_Bounds [UIScreen mainScreen].bounds
#define kScreen_Width [UIScreen mainScreen].bounds.size.width
#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define kViewSafeAreaInsets(view) ({UIEdgeInsets i; if(@available(iOS 11.0, *)) {i = view.safeAreaInsets;} else {i = UIEdgeInsetsZero;} i;})
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavigationBarHeight self.navigationController.navigationBar.frame.size.height

#define kSafeAreaTopHeight (kScreen_Height == 812.0 ? 88 : 64)
#define kSafeAreaBottomHeight (kScreen_Height == 812.0 ? 34 : 0)
#define kViewAtBottomHeight (49 + kSafeAreaBottomHeight)

#define kTabBarHeight (CYL_IS_IPHONE_X ? 83 : 49)
#define kSafeBottomOffset (CYL_IS_IPHONE_X ? 34 : 0)

#define kHudyOffset (S_H-kSafeAreaTopHeight)/2 - kSafeAreaBottomHeight - 80 - 10


/**
 导航栏titleView尽可能充满屏幕，余留的边距
 iPhone5s/iPhone6(iOS8/iOS9/iOS10) margin = 8
 iPhone6p(iOS8/iOS9/iOS10) margin = 12
 
 iPhone5s/iPhone6(iOS11) margin = 16
 iPhone6p(iOS11) margin = 20
 */
#define NavigationBarTitleViewMargin \
(kEdition_iOS11? ([UIScreen mainScreen].bounds.size.width > 375 ? 20 : 16) : \
([UIScreen mainScreen].bounds.size.width > 375 ? 12 : 8))

/**
 导航栏左右navigationBarItem余留的边距
 iPhone5s/iPhone6(iOS8/iOS9/iOS10) margin = 16
 iPhone6p(iOS8/iOS9/iOS10) margin = 20
 */
#define NavigationBarItemMargin ([UIScreen mainScreen].bounds.size.width > 375 ? 20 : 16)

/**
 导航栏titleView和navigationBarItem之间的间距
 iPhone5s/iPhone6/iPhone6p(iOS8/iOS9/iOS10) iterItemSpace = 6
 */
#define NavigationBarInterItemSpace 6

#define  adjustsScrollViewInsets(scrollView)\
do {\
_Pragma("clang diagnostic push")\
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")\
if ([scrollView respondsToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
NSMethodSignature *signature = [UIScrollView instanceMethodSignatureForSelector:@selector(setContentInsetAdjustmentBehavior:)];\
NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];\
NSInteger argument = 2;\
invocation.target = scrollView;\
invocation.selector = @selector(setContentInsetAdjustmentBehavior:);\
[invocation setArgument:&argument atIndex:2];\
[invocation retainArguments];\
[invocation invoke];\
}\
_Pragma("clang diagnostic pop")\
} while (0)


//WeakObject
#pragma mark - WeakObject
#define kWeakObject(obj)                       __weak __typeof(obj) weakObject = obj;
#define kWeak(var, weakVar)                    __weak __typeof(&*var) weakVar = var
#define kStrong_DoNotCheckNil(weakVar, _var)   __typeof(&*weakVar) _var = weakVar
#define kStrong(weakVar, _var)                 kStrong_DoNotCheckNil(weakVar, _var); if (!_var) return;
#define kWeak_(var)                            kWeak(var, weak_##var);
#define kStrong_(var)                          kStrong(weak_##var, _##var);
/** defines a weak `self` named `__weakSelf` */
#define kWeakSelf                              kWeak(self, __weakSelf);
/** defines a strong `self` named `_self` from `__weakSelf` */
#define kStrongSelf                            kStrong(__weakSelf, _self);

#endif /* Header_h */
