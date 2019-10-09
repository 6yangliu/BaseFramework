//
//  XYDataPickerView
//  AppleDP
//
//  Created by ly on 15/6/4.
//  Copyright (c) 2015年 kedll. All rights reserved.
//

#import "XYDataPickerView.h"
@implementation XYDataPickerView
@synthesize handerView,toolBar,CancleBtn,ConfirmBtn,dataPicker,dataListArray;
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        dataListArray=[NSArray array];
        [self initSubView];
    }
    return self;
}

-(void)initToolBarView{
    toolBar=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 44)];
    toolBar.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    [self addSubview:toolBar];
    
    CancleBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, toolBar.height)];
    [CancleBtn setTitle:ALS(@"取消") forState:0];
    [CancleBtn setTitleColor:[UIColor colorWithRed:48.0/255.0 green:146.0/255.0 blue:252.0/255.0 alpha:1] forState:0];
    [CancleBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [CancleBtn addTarget:self action:@selector(onToolBarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:CancleBtn];
    
    
    ConfirmBtn=[[UIButton alloc] initWithFrame:CGRectMake(toolBar.width-80, 0, 80, toolBar.height)];
    [ConfirmBtn setTitle:ALS(@"完成") forState:0];
    [ConfirmBtn setTitleColor:[UIColor colorWithRed:48.0/255.0 green:146.0/255.0 blue:252.0/255.0 alpha:1] forState:0];
    [ConfirmBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [ConfirmBtn addTarget:self action:@selector(onToolBarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:ConfirmBtn];
    
    self.titleLB=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, ConfirmBtn.left-CancleBtn.right, toolBar.height)];
    self.titleLB.textColor=[UIColor colorWithRed:15.0/255.0 green:54.0/255.0 blue:82.0/255.0 alpha:1];
    self.titleLB.font=[UIFont systemFontOfSize:16];
    self.titleLB.centerX=self.centerX;
    self.titleLB.textAlignment=1;
    [toolBar addSubview:self.titleLB];
}

-(void)initSubView{
    [self initToolBarView];
    
    handerView = [UIButton buttonWithType:UIButtonTypeCustom];
    [handerView setFrame:[UIScreen mainScreen].bounds];
    handerView.hidden=YES;
    handerView.backgroundColor=[UIColor colorWithWhite:0.5 alpha:0.4];
    [handerView addTarget:self action:@selector(dissmiss) forControlEvents:UIControlEventTouchUpInside];
  
    self.frame=CGRectMake(0, handerView.height, self.width, self.height);
    [handerView addSubview:self];
    
    dataPicker = [[UIPickerView alloc] init];
    // 显示选中框
    dataPicker.showsSelectionIndicator=YES;
    dataPicker.dataSource = self;
    dataPicker.delegate = self;
    
    dataPicker.frame=CGRectMake(0, toolBar.bottom, self.width ,self.height-toolBar.height);
    [self addSubview:dataPicker];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:handerView];
    
}

-(void)show{
      handerView.hidden=NO;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame=CGRectMake(0, handerView.height-self.height, self.width, self.height);
    }];
}

-(void)dissmiss{
    handerView.hidden=YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.frame=CGRectMake(0, handerView.height, self.width, self.height);
    }];
}

#pragma mark-UIPickerViewDelegate
// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return  dataListArray.count;
}

// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    if (component == 1) {
        return pickerView.width;
    }
    return 250;
}
// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectRow=row;
    
}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return  dataListArray[row];
}

#pragma mark-onToolBarBtnClick
-(void)onToolBarBtnClick:(UIButton *)btn{
    if(btn==ConfirmBtn){
        if(self.dataListArray.count){
            if([self.delegate respondsToSelector:@selector(didDataPickerItemClick::)]){
                [self.delegate didDataPickerItemClick:self.selectRow :self];
            }
        }
    }
    [self dissmiss];
}

@end
