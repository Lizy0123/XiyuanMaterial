//
//  Api_UploadImage.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/5/3.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "Api_UploadImage.h"
#import "AFNetworking.h"

@implementation Api_UploadImage {
    UIImage *_image;
}

- (id)initWithImage:(UIImage *)image {
    self = [super init];
    if (self) {
        _image = image;
    }
    return self;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"xy/upload/pic.json";
}

- (AFConstructingBlock)constructingBodyBlock {
    return ^(id<AFMultipartFormData> formData) {
        NSData *data = UIImageJPEGRepresentation(_image, 0.5);
        NSString *name = @"uploadPic";
        NSString *fileName = @"uploadPic.jpg";
        NSString *type = @"image/jpg";
        
        [formData appendPartWithFileData:data name:name fileName:fileName mimeType:type];
    };
}

- (NSString *)responseImageId {
    NSDictionary *dict = self.responseJSONObject;
    return dict[@"object"][@"saveUrl"];
}


@end
