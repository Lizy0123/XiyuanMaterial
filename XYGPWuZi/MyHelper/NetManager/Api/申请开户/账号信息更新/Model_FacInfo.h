//
//  Model_FacInfo.h
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/5/3.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "JSONModel.h"

@interface Model_FacInfo : JSONModel

@property (copy, nonatomic) NSString<Optional>
*facId/*公司id*/,
*unitsFull/*单位全称*/,
*unitsAbd/*单位简称*/,
*unitsEn/*英文名称*/,
*regNo/* 注册执照号*/,
*regAdd/* 注册地址*/,
*corporation/* 法人代表*/,
*corpCard/* 法人身份证号*/,
*corpReg/* 法人登记号*/,
*regCaptial/* 注册资本*/,
*taxNo/* 税务登记号*/,
*accountName/* 开户人姓名*/,
*faceInfo_initBank/* 开户行*/,
*faceInfo_initAccount/* 开户帐户*/,
*transAccount/* 转帐帐号*/,
*transBank/* 转帐银行*/,
*organizationCode/* 组织机构代码证号*/,
*creUser/* 创建用户*/,
*modUser/* 修改用户*/,
*creTime/* 创建时间*/,
*modTime/* 修改时间*/,
*unitsAdd/* 公司地址*/,
*unitsType/* 公司性质*/,
*unitsScale/* 公司规模*/,
*logo/* 公司logo*/,
*unitsGrade/* 企业等级*/,
*category/* 经营类型范围*/,
*brands/* 经营品牌范围*/,
*phone/* 电话*/,
*chuanzhen/* 传真*/,
*zipcode /* 邮编*/,
/** 2016-5-16 新增闲置物资邮箱以下、身份证以上六个字段 **/
*email/* 电子邮箱*/,
*infoSqwtsFile/* 授权委托书*/,
*infoSwdjzFile/* 税务登记证*/,
*infoYyzzFile/* 营业执照*/,
*infoJgdmzFile/* 组织机构代码证*/,
*infoSszFile/* 身份证*/,
*infoSzhyStatus/* 三证合一（0、否 1、是）*/

;


@end
