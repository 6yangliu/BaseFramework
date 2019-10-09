//
//  didSinglePickerViewSelected
//  AppleDP
//  单列数据选择器 底部菜单
//  Created by ly on 15/6/4.
//  Copyright (c) 2015年 kedll. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface HKSingleBottomMenuItem :UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *titleImageView;



@end




@class HKSingleBottomMenu;
typedef void(^MenuSelectedBlock)(HKSingleBottomMenu *menu);

@interface HKSingleBottomMenu : UIView<UITableViewDelegate,UITableViewDataSource>
{

}

@property (strong, nonatomic) NSArray *dataSource;
@property (nonatomic, copy) MenuSelectedBlock selectBlock;
@property(nonatomic,assign)NSInteger selectRow;
@property (nonatomic,strong) UIButton *handerView;
@property (nonatomic,strong) UITableView *dataPicker;
@property(nonatomic,strong)UIView *toolBar;
@property(nonatomic,strong)UIButton *CancleBtn;
@property(nonatomic,strong)UIButton *ConfirmBtn;
@property(nonatomic,strong)UILabel *titleLabel;

@property (strong, nonatomic) UIColor *titleBackgroundColor;
@property (strong, nonatomic) UIColor *confirmButtonColor;
@property (strong, nonatomic) UIColor *cancelButtonColor;
@property (strong, nonatomic) UIColor *pickerBackgroundColor;

@property (strong, nonatomic) NSString *keyName;
@property (strong, nonatomic) NSString *imgKeyName;


- (instancetype)initWithHeight:(CGFloat)height parentBounds:(CGRect)parentBounds;
-(void)show;

@end
