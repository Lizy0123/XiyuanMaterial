//
//  Model_FacUser.h
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/5/3.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "JSONModel.h"
#import "Model_FacInfo.h"

@interface Model_Account : JSONModel
@property (copy, nonatomic) NSString<Optional>
*jixibz/**/,
*zizhanghao/**/,
*zizhanghmc/**/,
*zhuzhanghao/**/,
*zizhanghzt/**/,
*jixlv/**/,
*fbaObjId/**/,
*jixizq/**/,
*zizhsxh/**/,
*bizhong/**/,
*gengxinrq/**/,
*zhanghumc/**/,
*fbaBalanceLock/**/,
*touzhibz/**/,
*danweidm/**/,
*fbaObjType/**/,
*fbaIsClean/**/,
*fbaBalance/**/,
*fbaCretime/**/,
*fbaId/**/,
*fbaModtime/**/,
*jianlirq/**/,
*fbaBankBd/**/,
*fbaLoginName/**/,
*fbaBankName/**/,
*fbaBankNo/**/,
*fbaBankHm
;
@end

@protocol Model_Account
@end

@interface Model_FacUser : JSONModel
@property (copy, nonatomic) NSString<Optional>
*facUserid/*用户id*/,
*facId/*公司id*/,
*facRroleid/**/,
*loginName/*登录名*/,
*password/*密码*/,
*pwdQuestion/*密码问题*/,
*pwdAnswer/*密码答案*/,
*email/*电子邮件*/,
*mobil/*手机*/,
*status/*状态(0未验证，1邮箱验证，2手机验证，3邮箱手机都验证，默认为0)*/,
*modUser/*创建用户*/,
*creUser/*修改用户*/,
*creTime/*创建时间*/,
*modTime/*修改时间*/,
*facType/*商家类型（1采，2供，3物流）*/,
*isCai/*是否采购商（1是，0否）*/,
*isLock/*是否锁定（1是，0否）*/,
*caseName/*真实姓名*/,
*isAdmin/*是否是超级管理员（0非，1是）*/,
*code/*手机验证码*/,
*sign/*令牌号*/,
/** 2016-5-16 新增闲置物资企业类型、账户类型两个字段 **/
*facCountryType/*企业类型（0、境内企业 1、境外企业）*/,
*facUserType/*账户类型（0、企业 1、个人）*/,
*facCard/*身份证号*/,
*facIsTrade/*交易会员 1.认证通过，信息不能更改  3.认证中*/,
*facIsTradeReson/*交易会员不通过原因*/,
/** 20176-06-03 新增闲置物资APP端字段 **/
*facHeadPic/*头像*/,
*facSex/*性别（1、男 2、女）*/,
*facProvince/*省*/,
*facCity/*市*/,
*facCounty/*县*/,
*facAddress/*地址*/,
*facQrcodeUrl/*二维码URL*/,
*facQrcodePic/*二维码PIC*/,
*FacInfo /*/2015-05-22 新增账户表*/,
/**2018-04-27 新增支付版本的字段 wxc*/
*facPayName/*支付手机姓名*/,
*facPayMobil/*支付手机号码*/,
*loginUser/*登录的角色 1业务员2财务人员3通用（拥有前两者的权限）*/
;
@property(strong, nonatomic) NSArray<Model_Account> *accounts/*用户的子账户信息*/;
@property(strong, nonatomic) Model_FacInfo<Optional> *fi;
@end
