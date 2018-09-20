//
//  Api_UpdateUserInfo.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/5/3.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "Api_UpdateUserInfo.h"

@implementation Api_UpdateUserInfo{
    Model_FacInfo *_facInfoM;
    Model_FacUser *_facUserM;
    NSString *_phoneCode;
}

-(instancetype)initWithFacUser:(Model_FacUser *)facUser withFacInfo:(Model_FacInfo *)facInfo phoneCode:(NSString *)phoneCode{
    if (self = [super init]) {
        _facUserM = facUser;
        _facInfoM = facInfo;
        _phoneCode = phoneCode;
    }return self;
}
-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}
-(NSString *)requestUrl{
    return @"xy/user/token/modify/info";
}
-(id)requestArgument{
    
    if ([_facUserM.facUserType isEqualToString:@"0"]) {/*账户类型（0、企业 1、个人）*/
        if ([_facUserM.fi.infoSzhyStatus isEqualToString:@"0"]) {
            return @{
                     @"token":[UserManager readUserInfo].token,
                     @"facCountryType":_facUserM.facCountryType,
                     @"unitsFull":_facInfoM.unitsFull,
                     @"unitsAbd":_facInfoM.unitsAbd,
                     @"infoSzhyStatus":_facInfoM.infoSzhyStatus,
                     @"infoYyzzFile":_facInfoM.infoYyzzFile,
                     @"infoSwdjzFile":_facInfoM.infoSwdjzFile,
                     @"infoJgdmzFile":_facInfoM.infoJgdmzFile,
                     @"infoSqwtsFile":_facInfoM.infoSqwtsFile,
                     @"infoSszFile":_facInfoM.infoSszFile,
//                     @"caseName":_facUserM.caseName,
//                     @"facCard":_facUserM.facCard,
                     @"phoneCode":_phoneCode,
                     };

        }else{
            return @{
                     @"token":[UserManager readUserInfo].token,
                     @"facCountryType":_facUserM.facCountryType,
                     @"unitsFull":_facInfoM.unitsFull,
                     @"unitsAbd":_facInfoM.unitsAbd,
                     @"infoSzhyStatus":_facInfoM.infoSzhyStatus,
                     @"infoYyzzFile":_facInfoM.infoYyzzFile,
                     @"infoSqwtsFile":_facInfoM.infoSqwtsFile,
                     @"infoSszFile":_facInfoM.infoSszFile,
                     @"facPayName":_facUserM.facPayName,
                     @"facPayMobil":_facUserM.facPayMobil,
//                     @"caseName":_facUserM.caseName,
//                     @"facCard":_facUserM.facCard,
                     @"phoneCode":_phoneCode,
                     };
        }
    }else{
        return @{
                 @"token":[UserManager readUserInfo].token,
//                 @"infoSqwtsFile":_facInfoM.infoSqwtsFile,
                 @"infoSszFile":_facInfoM.infoSszFile,
                 @"facPayName":_facUserM.facPayName,
                 @"facPayMobil":_facUserM.facPayMobil,
                 @"caseName":_facUserM.caseName,
                 @"facCard":_facUserM.facCard,
                 @"phoneCode":_phoneCode,
                 };
    }
//    return @{
//             @"token":[UserManager readUserInfo].token,
//             @"facCountryType":_facUserM.facCountryType,
//             @"unitsFull":_facInfoM.unitsFull,
//             @"unitsAbd":_facInfoM.unitsAbd,
//             @"infoSzhyStatus":_facInfoM.infoSzhyStatus,
//             @"infoYyzzFile":_facInfoM.infoYyzzFile,
//             @"infoSwdjzFile":_facInfoM.infoSwdjzFile,
//             @"infoJgdmzFile":_facInfoM.infoJgdmzFile,
//             @"infoSqwtsFile":_facInfoM.infoSqwtsFile,
//             @"infoSszFile":_facInfoM.infoSszFile,
//             @"facPayName":_facUserM.facPayName,
//             @"facPayMobil":_facUserM.facPayMobil,
//             @"caseName":_facUserM.caseName,
//             @"facCard":_facUserM.facCard,
//             @"phoneCode":_phoneCode,
//             };
}
@end
