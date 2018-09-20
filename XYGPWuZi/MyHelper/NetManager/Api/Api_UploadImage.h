//
//  Api_UploadImage.h
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/5/3.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import "MyRequest.h"

@interface Api_UploadImage : MyRequest
- (id)initWithImage:(UIImage *)image;

- (NSString *)responseImageId;

@end
