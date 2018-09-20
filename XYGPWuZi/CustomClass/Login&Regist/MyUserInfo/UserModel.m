//
//  UserModel.m
//  YLuxury
//
//  Created by Lzy on 2017/6/8.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "UserModel.h"

#import "NSObject+Property.h"
@implementation UserModel
//归档（序列化）
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [self enumerateProperties:^(id key) {
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }];
}
//解归档（反序列化）
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        __weak typeof(self) weakSelf = self;
        [self enumerateProperties:^(id key) {
            id value = [aDecoder decodeObjectForKey:key];
            [weakSelf setValue:value forKey:key];
        }];
    }
    return self;
}
@end


#define KUserArchivePathKey @"userInfo.archive"
#define KEY @"userInfo"
@implementation UserManager
#pragma mark 保存用户信息
+ (void)saveUserInfo:(UserModel *)model {
    BOOL success = [ArchiveTool archiveModel:model toPath:[ArchiveTool pathWithKey:KUserArchivePathKey] withKey:KEY];
    if (!success) {
        NSLog(@"存储用户信息失败");
    }
}
#pragma mark 取出用户信息
+ (UserModel *)readUserInfo {
    UserModel *model = [ArchiveTool unarchiveFromPath:[ArchiveTool pathWithKey:KUserArchivePathKey] withKey:KEY];
    if (!model) {
        model = [[UserModel alloc] init];
    }
    return model;
}
+ (void) clearUserInfo {
    UserModel *model = [[UserModel alloc] init];
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    [userInfo setValue:@"" forKey:kToken];
    [userInfo synchronize];
    [self saveUserInfo:model];
}
@end




@implementation ArchiveTool
+ (BOOL)archiveModel:(id)aModel toPath:(NSString *)path withKey:(NSString *)archivingDataKey{
    //归档
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    // archivingDate的encodeWithCoder方法被调用
    [archiver encodeObject:aModel forKey:archivingDataKey];
    [archiver finishEncoding];
    //写入文件
    return [data writeToFile:path atomically:YES];
}
+ (id)unarchiveFromPath:(NSString *)path withKey:(NSString *)archivingDataKey{
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    //获得类
    //initWithCoder方法被调用
    id archivingData = [unarchiver decodeObjectForKey:archivingDataKey];
    [unarchiver finishDecoding];
    return archivingData;
}
+ (NSString *)pathWithKey:(NSString *)pathKey{
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:pathKey];
    //NSLog(@"%@",filePath);
    return filePath;
}
@end

