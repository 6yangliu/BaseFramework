//
//  YBAreaPickerView.m
//  XHGY_Agent
//
//  Created by 尚往文化 on 17/6/9.
//  Copyright © 2017年 YBing. All rights reserved.
//

#import "YBPickerTool.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

@interface YBPickerTool ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *toolBar;

@property (nonatomic, copy) YBPickerDidSelectBlock didSelectBlock;
@property (nonatomic, strong) NSArray<NSArray<NSString *> *> *datas;
@property (nonatomic, assign) NSIndexPath *indexPath;

@end

@implementation YBPickerTool

- (void)dealloc
{
    NSLog(@"%s", __FUNCTION__);
}

- (UIView *)bgView
{
    if (_bgView==nil) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
        [_bgView addGestureRecognizer:tap];
        
        [_bgView addSubview:self];
        [_bgView addSubview:self.toolBar];
        
        
    }
    return _bgView;
}

- (UIView *)toolBar
{
    if (_toolBar==nil) {
        _toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenH-self.bounds.size.height-34, kScreenW, 34)];
        _toolBar.backgroundColor = [UIColor whiteColor];
        
        UIButton *finishBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
        finishBtn.frame = CGRectMake(kScreenW-60, 0, 60, _toolBar.bounds.size.height);
        [finishBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        finishBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [finishBtn addTarget:self action:@selector(finishClick:) forControlEvents:UIControlEventTouchUpInside];
        [_toolBar addSubview:finishBtn];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        cancelBtn.frame = CGRectMake(0, 0, 60, _toolBar.bounds.size.height);
        [cancelBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [cancelBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [_toolBar addSubview:cancelBtn];
    }
    return _toolBar;
}

- (void)finishClick:(UIButton *)btn
{
    if (self.didSelectBlock) {
        if (self.datas.count) {
            self.didSelectBlock(self.indexPath);
        }
    }
    [self close];
}

- (void)close
{
    [self.bgView removeFromSuperview];
    [self removeFromSuperview];
    [self.toolBar removeFromSuperview];
    self.toolBar = nil;
    self.bgView = nil;
}

- (void)show
{
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    [window addSubview:self.bgView];
}

+ (void)show:(NSArray<NSArray<NSString *> *> *)datas didSelectBlock:(YBPickerDidSelectBlock)didSelectBlock
{
    YBPickerTool *pickerView = [[YBPickerTool alloc] initWithFrame:CGRectMake(0, kScreenH-220, kScreenW, 220)];
    pickerView.didSelectBlock = didSelectBlock;
    pickerView.datas = datas;
    pickerView.backgroundColor = [UIColor whiteColor];
    pickerView.delegate = pickerView;
    pickerView.dataSource = pickerView;
    
    [pickerView show];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.datas.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.datas[component].count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.datas[component][row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.indexPath = [NSIndexPath indexPathForRow:row inSection:component];
}

@end
