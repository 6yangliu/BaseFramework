//
//  ViewController.m
//  ZJTagView
//
//  Created by ZeroJ on 16/9/27.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "SortLabelController.h"
#import "ZJTagView.h"
@interface SortLabelController ()<ZJTagViewDelegate>
@property (strong, nonatomic) ZJTagView *tagView;
@property (strong, nonatomic) UIButton *editBtn;

@end

@implementation SortLabelController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *selectedItems = [NSMutableArray array];
    NSMutableArray *unselectedItems = [NSMutableArray array];
    
    UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(FitCount(10), FitCount(30), FitCount(24), FitCount(24))];
    [closeButton setBackgroundImage:IMAGENAMED(@"home_close") forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeVc) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];
    
    UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectMake(FitCount(10), MaxY(closeButton)+FitCount(21), 75, 18) withText:@"所有分组" withTextColor:BIGER_TITLE_COLOR withFont:18 withAlignment:NSTextAlignmentCenter];
    [self.view addSubview:titleLabel];
    
    UILabel *contentLabel = [UILabel createLabelWithFrame:CGRectMake(MaxX(titleLabel)+FitCount(14), MaxY(closeButton)+FitCount(27), 82, 12) withText:@"拖拽可以排序" withTextColor:BIGER_SHALLOW_COLOR withFont:12 withAlignment:NSTextAlignmentCenter];
    [self.view addSubview:contentLabel];
    
    _editBtn = [[UIButton alloc] initWithFrame:CGRectMake(FitCount(313), MaxY(closeButton)+FitCount(21), FitCount(52), 24)];
    [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [_editBtn setTitle:@"完成" forState:UIControlStateSelected];
    _editBtn.layer.borderWidth = 0.5;
    _editBtn.layer.borderColor = RGB(234, 109, 67).CGColor;
    _editBtn.layer.cornerRadius = 13.5;
    _editBtn.layer.masksToBounds = YES;
    [_editBtn setTitleColor:RGB(234, 109, 67) forState:UIControlStateNormal];
    [_editBtn addTarget:self action:@selector(editBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.editBtn];

    // 初始化第一个section数据
    for (int i=0; i<20; i++) {
        ZJTagItem *item = [ZJTagItem new];
        item.name = [NSString stringWithFormat:@"选中--- %d",i];
        [selectedItems addObject:item];
    }
    // 初始化第二个section数据
    for (int i=0; i<40; i++) {
        ZJTagItem *item = [ZJTagItem new];
        item.name = [NSString stringWithFormat:@"未选中--- %d",i];
        [unselectedItems addObject:item];
    }
    // 初始化
    _tagView = [[ZJTagView alloc] initWithSelectedItems:selectedItems unselectedItems:unselectedItems];
    
    // 设置代理 可以处理点击
    _tagView.delegate = self;
    _tagView.frame = CGRectMake(0, CGRectGetMaxY(_editBtn.frame)+FitCount(18), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(_editBtn.frame)-FitCount(18));
    // 设置frame
    [self.view addSubview:_tagView];
    self.view.backgroundColor = WHITE_COLOR;
}

- (void)editBtnOnClick:(UIButton *)editBtn {
    _tagView.inEditState = !editBtn.isSelected;
}

- (void)closeVc{
     [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - ZJTagViewDelegate
- (void)tagView:(ZJTagView *)tagView didChangeInEditState:(BOOL)inEditState {
    _editBtn.selected = inEditState;

}

- (void)tagView:(ZJTagView *)tagView didSelectTagWhenNotInEditState:(NSInteger)index {
    NSLog(@"点击未处于编辑状态的第一组的第%ld个tag", index);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
