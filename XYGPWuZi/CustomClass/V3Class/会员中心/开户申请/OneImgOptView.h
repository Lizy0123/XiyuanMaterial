//
//  OneImgOptView.h
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2018/4/9.
//  Copyright © 2018年 河北熙元科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface OneImgOptViewModel :NSObject
@property(nonatomic, copy) NSString *imageUrlStr;

@property(nonatomic, copy) NSString *imageNameStr;
@property(nonatomic, copy) NSString *descStr;
@property(nonatomic, strong) UIImage *image;
@end


@interface OneImgOptView : UIView
@property(copy, nonatomic) void(^selectedBlock)(UIImage *selectImage);
@property(strong, nonatomic)OneImgOptViewModel *oneImgViewM;
@property(strong, nonatomic)UIViewController *parentVC;

@end
