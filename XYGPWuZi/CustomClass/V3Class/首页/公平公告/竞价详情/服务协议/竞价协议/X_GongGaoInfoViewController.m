//
//  X_GongGaoInfoViewController.m
//  XYGPWuZi
//
//  Created by 河北熙元科技有限公司 on 2017/6/28.
//  Copyright © 2017年 河北熙元科技有限公司. All rights reserved.
//

#import "X_GongGaoInfoViewController.h"

@interface X_GongGaoInfoViewController ()<UITextViewDelegate>

@property (nonatomic ,strong)UITextView *textView;

@end

@implementation X_GongGaoInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"竞价公告";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(15, 0, S_W-30, S_H-64)];
    [_textView setDelegate:self];
    _textView.editable = NO;
    _textView.showsVerticalScrollIndicator = NO;
    
   NSAttributedString *attrStr = [[NSAttributedString alloc] initWithData:[self.string dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    _textView.attributedText = attrStr;
    [self.view addSubview:_textView];
}
-(void)textViewDidChange:(UITextView *)textView{
    
    CGFloat maxHeight =S_H;
    CGRect frame = textView.frame;
    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
    CGSize size = [textView sizeThatFits:constraintSize];
    if (size.height<=frame.size.height) {
        size.height=frame.size.height;
    }else{
        if (size.height >= maxHeight)
        {
            size.height = maxHeight;
            textView.scrollEnabled = YES;   // 允许滚动
        }
        else
        {
            textView.scrollEnabled = NO;    // 不允许滚动
        }
    }
    textView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, size.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
