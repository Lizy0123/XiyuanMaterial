//
//  XianZhiQiuGouModel.h
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/10/20.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XianZhiQiuGouModel : NSObject

@property (nonatomic,copy)NSString *facUserid;
@property (nonatomic,copy)NSString *riAddress;
@property (nonatomic,copy)NSString *riCityId;
@property (nonatomic,copy)NSString *riCode;
@property (nonatomic,copy)NSString *riCompanyName;
@property (nonatomic,copy)NSString *riContent;
@property (nonatomic,copy)NSString *riCount;
@property (nonatomic,copy)NSString *riCountyId;
@property (nonatomic,copy)NSString *riCretime;
@property (nonatomic,copy)NSString *riCreuser;
@property (nonatomic,copy)NSString *riEmail;
@property (nonatomic,copy)NSString *riId;
@property (nonatomic,copy)NSString *riIsAdmin;
@property (nonatomic,copy)NSString *riIsPc;
@property (nonatomic,copy)NSString *riKeyword;
@property (nonatomic,copy)NSString *riModtime;
@property (nonatomic,copy)NSString *riModuser;
@property (nonatomic,copy)NSString *riPerson;
@property (nonatomic,copy)NSString *riProvinceId;
@property (nonatomic,copy)NSString *riStatus;
@property (nonatomic,copy)NSString *riTel;
@property (nonatomic,copy)NSString *riTitle;

+(XianZhiQiuGouModel *)analysisWithDic:(NSDictionary *)aDic;

/*
{
    facUserid = 4028809e5561a8c5015561b3b7260002;
    riAddress = "\U5317\U4eac\U5e02, \U5317\U4eac\U5e02, \U897f\U57ce\U533a";
    riCityId = 1;
    riCode = 10000018;
    riCompanyName = "\U6cb3\U5317\U7199\U5143\U79d1\U6280\U6709\U9650\U516c\U53f8";
    riContent = 1;
    riCount = 0;
    riCountyId = 2;
    riCretime = "2017-08-08 10:41:13";
    riCreuser = hbxykj;
    riEmail = "111@111.com";
    riId = 402880a05dbfa1d1015dbfb7b3ff0004;
    riIsAdmin = 0;
    riIsPc = 0;
    riKeyword = 111;
    riModtime = "2017-08-08 10:41:13";
    riModuser = hbxykj;
    riPerson = "\U8c22\U5b8f\U4f1f";
    riProvinceId = 1;
    riStatus = 0;
    riTel = 13363285555;
    riTitle = "\U6c42\U8d2d\U9ed1\U73cd\U73e05\U514b";
},
*/
@end
