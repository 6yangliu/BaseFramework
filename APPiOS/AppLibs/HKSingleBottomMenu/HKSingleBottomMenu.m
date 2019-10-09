//
//  didSinglePickerViewSelected
//  AppleDP
//
//  Created by ly on 15/6/4.
//  Copyright (c) 2015年 kedll. All rights reserved.
//

#import "HKSingleBottomMenu.h"

@implementation HKSingleBottomMenuItem 


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self){
        [self initSubview];
    }
    
    return self;
}

-(void)initSubview{
    
    _titleLabel=[[UILabel alloc] init];
    _titleLabel.font=[UIFont systemFontOfSize:17];
    _titleLabel.textColor=[UIColor colorWithRed:15.0/255.0 green:54.0/255.0 blue:82.0/255.0 alpha:1];
    [self.contentView addSubview:_titleLabel];
    
    _titleImageView =[[UIImageView alloc] init];
    _titleImageView.contentMode=2;
    [self.contentView addSubview:_titleImageView];
    
}


- (void)layoutSubviews{
    [super layoutSubviews];
    _titleImageView.frame=CGRectMake(15, (self.height-44)/2, 44, 44);
    
    _titleLabel.frame=CGRectMake(_titleImageView.right+30, (self.height-44)/2, self.width-40-_titleImageView.right-30, 44);
    
}



@end


@implementation HKSingleBottomMenu

@synthesize handerView,toolBar,CancleBtn,ConfirmBtn,dataPicker,dataSource;

- (instancetype)initWithHeight:(CGFloat)height parentBounds:(CGRect)parentBounds
{
    return [self initWithFrame:CGRectMake(0, parentBounds.size.height - height, parentBounds.size.width, height)];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        dataSource=[NSArray array];
        [self initSubView];
    }
    return self;
}

-(void)initToolBarView{
    toolBar=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 55)];
    [self addSubview:toolBar];
   
    
    CancleBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, toolBar.height)];
    [CancleBtn setTitle:ALS(@"取消") forState:0];
    [CancleBtn setTitleColor:[UIColor colorWithRed:33.0f/255.0f green:172.0f/255.0f blue:107.0f/255.0f alpha:1.0f] forState:0];
    [CancleBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [CancleBtn addTarget:self action:@selector(onToolBarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:CancleBtn];
    
    
    ConfirmBtn=[[UIButton alloc] initWithFrame:CGRectMake(toolBar.width-80, 0, 80, toolBar.height)];
    [ConfirmBtn setTitle:ALS(@"确定") forState:0];
    [ConfirmBtn setTitleColor:[UIColor colorWithRed:33.0f/255.0f green:172.0f/255.0f blue:107.0f/255.0f alpha:1.0f] forState:0];
    [ConfirmBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [ConfirmBtn addTarget:self action:@selector(onToolBarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:ConfirmBtn];
    
    
    _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(self.width/2-(ConfirmBtn.left-CancleBtn.right)/2, 0, ConfirmBtn.left-CancleBtn.right,  toolBar.height)];
    _titleLabel.font=[UIFont systemFontOfSize:17];
    _titleLabel.textAlignment=1;
    _titleLabel.textColor=[UIColor colorWithRed:74.0/255.0 green:147.0/255.0 blue:244.0/255.0 alpha:1];
    [self addSubview:_titleLabel];
    
    UIView *sep=[[UIView alloc] initWithFrame:CGRectMake(0, toolBar.height-0.75, toolBar.width, 0.75)];
    sep.backgroundColor=HKUIColorFromRGB(0x3A4459, 1);
    sep.hidden=YES;
    [toolBar addSubview:sep];
}
-(void)initData{
    
}
-(void)initSubView{
    [self initToolBarView];
    
    handerView = [UIButton buttonWithType:UIButtonTypeCustom];
    [handerView setFrame:[UIScreen mainScreen].bounds];
    handerView.backgroundColor=[UIColor colorWithWhite:0 alpha:0.5];
    [handerView addTarget:self action:@selector(dissmiss) forControlEvents:UIControlEventTouchUpInside];
   
    self.frame=CGRectMake(0, handerView.height, self.width, self.height);
    [handerView addSubview:self];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:handerView];
    
    dataPicker = [[UITableView alloc]initWithFrame:CGRectMake(0, toolBar.bottom, self.width ,self.height-toolBar.height) style:1];
    dataPicker.backgroundColor = [UIColor clearColor];
    dataPicker.separatorStyle = UITableViewCellSeparatorStyleNone;
    dataPicker.delegate = self;
    dataPicker.dataSource = self;
    dataPicker.estimatedRowHeight=0;
    dataPicker.estimatedSectionFooterHeight=0;
    dataPicker.estimatedSectionHeaderHeight=0;
    [self addSubview:dataPicker];
}


-(void)show{
    [self initData];
    [self setTheme];
    __weak typeof(self) weakSelf=self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.handerView.hidden=NO;
        weakSelf.frame=CGRectMake(0, weakSelf.handerView.height-weakSelf.height, weakSelf.width, weakSelf.height);;
        
    } completion:^(BOOL finished) {
         [weakSelf.dataPicker reloadData];
    }];
 
    
}

-(void)dissmiss{
    
    __weak typeof(self) weakSelf=self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.frame=CGRectMake(0, weakSelf.handerView.height, weakSelf.width, weakSelf.height);;
    } completion:^(BOOL finished) {
        weakSelf.handerView.hidden=YES;
    }];
}
-(void)onToolBarBtnClick:(UIButton *)btn{
    if(btn==CancleBtn){
        
        [self dissmiss];
    }
    if(btn==ConfirmBtn){
        
        [self dissmiss];
    }
}
#pragma mark-tableViewDelegate
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.height/3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *idf=@"cell";
    HKSingleBottomMenuItem *cell = [tableView dequeueReusableCellWithIdentifier:idf];
    
    if(!cell){
        cell=[[HKSingleBottomMenuItem alloc] initWithStyle:0 reuseIdentifier:idf];
        cell.backgroundColor=[UIColor clearColor];
    }
    cell.titleLabel.text=dataSource[indexPath.row][self.keyName];
    cell.titleImageView.image=[UIImage imageNamed:dataSource[indexPath.row][self.imgKeyName]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    self.selectRow=indexPath.row;
    
    if(self.selectBlock){
        self.selectBlock(self);
    }
    [self dissmiss];
}

- (void)setTheme
{
    if (!self.titleBackgroundColor) {
        self.titleBackgroundColor = [UIColor clearColor];
    }
    toolBar.backgroundColor = self.titleBackgroundColor;
    if (!self.cancelButtonColor) {
        self.cancelButtonColor = [UIColor colorWithRed:33.0f/255.0f green:172.0f/255.0f blue:107.0f/255.0f alpha:1.0f];
    }
    [CancleBtn setTitleColor:self.cancelButtonColor forState:0];

    if (!self.confirmButtonColor) {
        self.confirmButtonColor = [UIColor colorWithRed:33.0f/255.0f green:172.0f/255.0f blue:107.0f/255.0f alpha:1.0f];
    }
    [ConfirmBtn setTitleColor:self.confirmButtonColor  forState:0];

    if (!self.pickerBackgroundColor) {
        self.pickerBackgroundColor=[UIColor colorWithRed:247.0f/255.0f green:247.0f/255.0f blue:247.0f/255.0f alpha:1.0f] ;
    }
    self.backgroundColor = self.pickerBackgroundColor;
}
@end
