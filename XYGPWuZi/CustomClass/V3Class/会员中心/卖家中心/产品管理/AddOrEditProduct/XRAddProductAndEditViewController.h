//
//  XRAddProductAndEditViewController.h
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/9/26.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XRAddProductAndEditViewController : UIViewController
//id
@property (nonatomic,copy)NSString *piId;
//url数组
@property (nonatomic,strong)NSMutableArray *imageUrlArray;
//背后的滚动视图
@property (nonatomic,strong)UIScrollView *backGroundScrollView;
//标题
@property (nonatomic,strong)UITextField *nameField;
//产品类别field
@property (nonatomic,strong)UITextField *productLeiBieField;
//一级类别id
@property (nonatomic,copy)NSString *pfirstId;
//二级类别id
@property (nonatomic,copy)NSString *psecondId;
//三级类别id
@property (nonatomic,copy)NSString *pthirdId;
//产品型号filed
@property (nonatomic,strong)UITextField *productTypeField;
//产品品牌filed
@property (nonatomic,strong)UITextField *productBrandField;
//使用年限field
@property (nonatomic,strong)UITextField *productOldField;
//工作时长field
@property (nonatomic,strong)UITextField *workTimeField;
//底价field
@property (nonatomic,strong)UITextField *minPriceField;
//数量field
@property (nonatomic,strong)UITextField *numberField;
//单位label
@property (nonatomic,strong)UILabel *productUnitLabel;

//产品状态field
@property (nonatomic,strong)UITextField *productStatusField;
//状态码0123
@property (nonatomic,copy)NSString *productStatus;
//地址field
@property (nonatomic,strong)UITextField *productAddressField;

//省市县的code
@property(nonatomic,copy)NSString *piProvince;
@property(nonatomic,copy)NSString *piCity;
@property(nonatomic,copy)NSString *piCounty;

//生产日期
@property (nonatomic,strong)UITextField *productTimeField;
@property (nonatomic,copy)NSString *createTime;

@end


//brand 品牌  type 型号  old新旧程度


/*
 
 token：登录令牌 |
 piPics：图片集合（1.jpg,2.jpg,3.jpg...）| 
 piId：主键ID（此参数修改需要，添加不需要） | 
 category.proCategoryId：对应类别ID |
 piName：品名 |
 piMinPrice：最低出售底价 | 
 piNumber：数量 | 
 piUnit：单位 |
 piWarehouse：仓库 | 
 piCch：仓储号 |
 piGlh：管理号 | 
 piKbh：捆包号 | 
 piZyh：资源号 |
 piScDate：生产日期 |
 piRkDate：入库日期 |
 piXjcd：新旧程度 | 
 piDqzt：当前状态(0,正常使用，1故障，2报废，3其它) | 
 piCpxh：产品型号 |
 piCpcd：品牌 |
 piCcgg：尺寸规格 | 
 piYyhgz：有无合格证（0、无 1、有）| 
 piCczl：产品重量 | 
 piGzxs：工作小时 |
 piYwdx：有无大修（0、无 1、有）| 
 piJjfs：计价方式 | 
 piZyms：资源描述 | 
 piKeyword：关键字 | 
 piMark：备注 | 
 piNewPrice：产品原价 |
 piProvince：省 |
 piCity：市 | 
 piCounty：县 | 
 piAddress：详细地址 |
 piCateFirst.proCategoryId：一级类别ID |
 piCateSecond.proCategoryId：二级类别ID | 
 piCateThird.proCategoryId ：三级类别ID
 
 */

