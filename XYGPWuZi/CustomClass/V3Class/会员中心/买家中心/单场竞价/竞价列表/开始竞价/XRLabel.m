//
//  XRLabel.m
//  WebSocketTest
//
//  Created by 河北熙元科技有限公司 on 2017/5/29.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "XRLabel.h"

@implementation XRLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//可以成为第一响应者
-(BOOL)canBecomeFirstResponder{
    
    return YES;
    
}
//可以响应的方法
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    
    return (action == @selector(customCopy:));
    
    
}
//实现方法
-(void)customCopy:(id)sender
{
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = self.text;

}
//UILabel默认是不接收事件的,需要我们自己添加touch事件
-(void)attachTapHadler{
    
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longTouch = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:longTouch];
    
    
    
}
//实现touch响应的事件
-(void)handleTap:(UIGestureRecognizer *)recongizer{
    
    
    [self becomeFirstResponder];
    UIMenuItem *copyLink = [[UIMenuItem alloc]initWithTitle:@"复制" action:@selector(customCopy:)];
    [[UIMenuController sharedMenuController]setMenuItems:[NSArray arrayWithObjects:copyLink, nil]];
    [[UIMenuController sharedMenuController]setTargetRect:self.frame inView:self.superview];
    [[UIMenuController sharedMenuController]setMenuVisible:YES animated:YES];
    
    
}

//初始化方法
-(id)initWithFrame:(CGRect)frame{
    
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self attachTapHadler];
        
    }
    return self;
    
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self attachTapHadler];
    
}



@end
