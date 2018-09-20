//
//  ProductDetailModel.h
//  XYGPWuZi
//
//  Created by Lzy on 2017/12/25.
//  Copyright © 2017年 xiaoRan. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ProductDetailModel : JSONModel

@property(nonatomic, copy)NSString<Optional> *piId, *piName, *piModtime, *piAddress, *picUrl, *piCpxh, *piNumber, *piUnit, *piCpcd, *piCczl, *piCczlUnit, *piXjcd, *piMinPrice, *piNewPrice, *piCch, *piGlh, *piKbh, *cateSecond, *piZyh, *piScDate, *piRkDate, *piDqzt, *piCcgg, *piYyhgz, *piGzx, *piYwdxs, *piJjfs, *cateFirst, *cateThird, *piGzxs, *piYwdx;
@property(nonatomic,strong)NSArray<Optional> *picUrls;
/*
 piId：产品id
 piName：产品名称
 piModtime：发布时间
 piCpxh：产品型号
 piNumber：数量
 piUnit：数量单位
 piCpcd：产地
 piCczl：产品重量
 piCczlUnit：重量单位
 piXjcd：新旧程度
 piMinPrice：最低出售低价
 piNewPrice：原价
 piCch：仓储号
 piGlh：内部管理号
 piKbh：捆包号
 piZyh：资源号
 piScDate：生产日期
 piRkDate：入库日期
 piDqzt：当前状态（0正常使用1故障2报废）
 piCcgg：尺寸规格
 piYyhgz：有无合格证（0无1有）
 piGzxs：工作小时
 piYwdx：有无大修（0无1有）
 piJjfs：废旧资材计价方式
 cateFirst：一级类别
 cateSecond：二级类别
 cateThird：三级类别
 piAddress：所在地区
 picUrls：产品的轮播图图片地址
 
 */

@end
