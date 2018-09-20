//
//  SideSlipTimeTableViewCell.m
//  ZYSideSlipFilter
//
//  Created by zhiyi on 16/10/14.
//  Copyright © 2016年 zhiyi. All rights reserved.
//

#import "SideSlipTimeTableViewCell.h"
#import "PriceRangeModel.h"
#import "UIColor+hexColor.h"
#import "ZYSideSlipFilterConfig.h"
#import "STPickerDate.h"
#import "BRDatePickerView.h"
//#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

#define TEXTFIELD_MAX_LENGTH 6

#define ACCESSORY_VIEW_HEIGHT 34
#define ACCESSORY_BUTTON_WIDTH 50
#define ACCESSORY_BUTTON_LEADING_TRAILING 0

@interface SideSlipTimeTableViewCell () <UITextFieldDelegate, STPickerDateDelegate>
@property (weak, nonatomic) IBOutlet UITextField *minTextField;
@property (weak, nonatomic) IBOutlet UITextField *maxTextField;
@property (weak, nonatomic) IBOutlet UILabel *time_TitileLabel;
@property (weak, nonatomic) IBOutlet UIButton *time_LeftBtn;

@property (weak, nonatomic) IBOutlet UIButton *time_RightBtn;
@property (nonatomic,strong)PriceRangeModel *priceModel;
@property (strong, nonatomic) ZYSideSlipFilterRegionModel *regionModel;
@end

@implementation SideSlipTimeTableViewCell
+(CGFloat)cellHeight{
    
    return 140;
}
+ (NSString *)cellReuseIdentifier {
    return @"SideSlipTimeTableViewCell";
}

+ (instancetype)createCellWithIndexPath:(NSIndexPath *)indexPath {
    SideSlipTimeTableViewCell *cell = [[NSBundle mainBundle] loadNibNamed:@"SideSlipTimeTableViewCell" owner:nil options:nil][0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.priceModel = [[PriceRangeModel alloc] init];
    return cell;
}
- (void)updateCellWithModel:(ZYSideSlipFilterRegionModel *__autoreleasing *)model
                  indexPath:(NSIndexPath *)indexPath {
    self.regionModel = *model;
    self.time_TitileLabel.text = self.regionModel.regionTitle;
    [_time_LeftBtn setTitle:@"请选择时间>>" forState:UIControlStateNormal];
    [_time_RightBtn setTitle:@"请选择时间>>" forState:UIControlStateNormal];

}

- (void)resetData {
    [_time_LeftBtn setTitle:@"请选择时间>>" forState:UIControlStateNormal];
    [_time_RightBtn setTitle:@"请选择时间>>" forState:UIControlStateNormal];
    
    _priceModel.firstTime = @"";
    _priceModel.secondTime = @"";
    NSMutableDictionary *mutDict = [NSMutableDictionary dictionaryWithDictionary:_regionModel.customDict];
    [mutDict setValue:_priceModel forKey:PRICE_RANGE_MODEL];
    _regionModel.customDict = [mutDict copy];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)btnSelected:(UIButton *)sender {
    
    __weak typeof(self)weakSelf = self;
    [BRDatePickerView showDatePickerWithTitle:@"时间" dateType:UIDatePickerModeDate defaultSelValue:nil minDateStr:nil maxDateStr:nil isAutoSelect:YES resultBlock:^(NSString *selectValue) {
        NSLog(@"-----%@",selectValue);
        
        [sender setTitle:selectValue forState:UIControlStateNormal];
       
        if (sender.tag == 0) {
            weakSelf.priceModel.firstTime = weakSelf.time_LeftBtn.currentTitle;
        }
        if (sender.tag == 1) {
            weakSelf.priceModel.secondTime = weakSelf.time_RightBtn.currentTitle;
        }
        NSMutableDictionary *mutDict = [NSMutableDictionary dictionaryWithDictionary:_regionModel.customDict];
        [mutDict setValue:weakSelf.priceModel forKey:PRICE_RANGE_MODEL];
        weakSelf.regionModel.customDict = [mutDict copy];
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
