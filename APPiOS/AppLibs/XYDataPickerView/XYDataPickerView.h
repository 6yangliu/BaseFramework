//
//  XYDataPickerView
//  AppleDP
//
//  Created by ly on 15/6/4.
//  Copyright (c) 2015年 kedll. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XYDataPickerView;

@protocol XYDataPickerViewDelegate <NSObject>


-(void)didDataPickerItemClick:(NSInteger)index :(XYDataPickerView *)picker;

@end

@interface XYDataPickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic,assign)NSInteger selectRow;
@property(nonatomic,weak)id<XYDataPickerViewDelegate> delegate;
@property(nonatomic,strong)NSArray *dataListArray;
@property (nonatomic,strong) UIButton *handerView;
@property (nonatomic,strong) UIPickerView *dataPicker;
@property(nonatomic,strong)UIView *toolBar;
@property(nonatomic,strong)UILabel *titleLB;
@property(nonatomic,strong)UIButton *CancleBtn;
@property(nonatomic,strong)UIButton *ConfirmBtn;
-(void)show;

@end
