//
//  UserModel.h
//  YLuxury
//
//  Created by Lzy on 2017/6/8.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//
/*
 账号：wangxuechun 密码：123456
账号：wangxuechunshouji 密码：123456
 */
#import <JSONModel/JSONModel.h>
#import "JSONModel.h"

@interface UserModel : JSONModel
/*
 {
 object =     {
 facHeadPic = "upload/xzwz/app/user/20170812150882002.png",
 facIsTrade = "1",
 facUserType = "1",
 loginName = "17731556096",
 caseName = "1111",
 mobil = "17731556096",
 },
 status = "200",
 codeId = "4028809e5c62c5ae015c62d36fcd0001",
 code = 200,
 success = 1,
 token = "c72f608fe0f56c09cd17b09a7e6a0ba4",
 facId = "4028809e5c62c5ae015c62d36f210000",
 }
 */
@property (copy, nonatomic) NSString<Optional>
*token/*登录返回的令牌*/,
*codeId/*账号主键ID*/,
*facId,
*caseName/*真实姓名*/,
*facIsTrade/*交易会员*/,
*facUserType/*账户类型（0、企业 1、个人）*/,
*loginName,
*mobil,
*email,
*facIsTradeReson/*交易会员不通过原因*/,
*facHeadPic,
*facSex,
*facProvince,
*facCity,
*facCounty,
*facAddress,
*status,
*facUserid

;

@end



@interface UserManager : NSObject
+(void)saveUserInfo:(UserModel *)model;
+(UserModel *)readUserInfo;
+(void)clearUserInfo;
@end



@interface ArchiveTool : NSObject
//归档
+ (BOOL)archiveModel:(id)aModel toPath:(NSString *)path withKey:(NSString *)archivingDataKey;
//从指定位置解档
+ (id)unarchiveFromPath:(NSString *)path withKey:(NSString *)archivingDataKey;
//根据key获得存储地址
+ (NSString *)pathWithKey:(NSString *)pathKey;
@end
