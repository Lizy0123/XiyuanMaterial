//
//  XianZhiGongYingModel.h
//  XYGPWuZi
//
//  Created by Lzy on 2017/12/26.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface XianZhiGongYingModel : JSONModel
@property(nonatomic,copy)NSString<Optional> *piId;
@property(nonatomic,copy)NSString<Optional> *piName;
@property(nonatomic,copy)NSString<Optional> *piNumber;
@property(nonatomic,copy)NSString<Optional> *piUnit;
@property(nonatomic,copy)NSString<Optional> *piXjcd;
@property(nonatomic,copy)NSString<Optional> *piCpxh;
@property(nonatomic,copy)NSString<Optional> *piCpcd;
@property(nonatomic,copy)NSString<Optional> *piGzxs;
@property(nonatomic,copy)NSString<Optional> *piSj;
@property(nonatomic,copy)NSString<Optional> *piStatus;
@property(nonatomic,copy)NSString<Optional> *piIsuse;
@property(nonatomic,copy)NSString<Optional> *piModtime;
@property(nonatomic,copy)NSString<Optional> *piAddress;
@property(nonatomic,copy)NSString<Optional> *picUrl;
@property(nonatomic,copy)NSString<Optional> *userId;




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
@end
