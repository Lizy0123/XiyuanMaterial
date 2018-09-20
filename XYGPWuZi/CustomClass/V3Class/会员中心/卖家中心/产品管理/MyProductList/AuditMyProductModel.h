//
//  AuditProductModel.h
//  XYGPWuZi
//
//  Created by Lzy on 2017/12/15.
//  Copyright © 2017年 xiaoRan. All rights reserved.
//
/*
 "piId": "4028809e5dd43c8a015dd441f3620001",
 "piName": "振动平筛",
 "piNumber": "0",
 "piUnit": "台",
 "piXjcd": "8成新",
 "piCpxh": "LVMS-8858",
 "piCpcd": "中国",
 "piGzxs": "2年",
 "piSj": "1",
 "piStatus": "1",
 "piIsuse": "1",
 "piModtime": "2017-08-12 10:35:14",
 "piAddress": "河北省, 石家庄市, 长安区",
 "picUrl": "upload/xzwz/images/user/201708121008140002.jpg"
 */
#import <JSONModel/JSONModel.h>

@interface AuditMyProductModel : JSONModel
@property (nonatomic,copy)NSString <Optional>*piId, *piName, *piNumber, *piUnit, *piXjcd, *piCpxh, *piCpcd, *piGzxs, *piStatus, *piIsuse, *piModtime, *piAddress, *picUrl, *piSj;

@end
