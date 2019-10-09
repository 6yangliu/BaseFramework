//
//  TokenViewController.m
//  APPiOS
//
//  Created by liuy on 2018/6/20.
//  Copyright © 2018年 shengxi. All rights reserved.
//

#import "ECOViewController.h"

@interface ECOViewController (){
    
}

@end

@implementation ECOViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title=ALS(@"应用");
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self initData];
    [self reloadUIData];
    
   
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}
-(void)initUI{
    
}
-(void)initData{
    
}
-(void)baseNetStateChanged:(NSInteger)state{
    [super baseNetStateChanged:state];
    if(state!=HKNetWorkStatusNoInternet){
        
    }
}
-(void)reloadUIData{
    
}

#pragma mark-UI区

#pragma mark-数据区

#pragma mark  网络数据回调
-(void)OnHttpErrorBack:(NSMutableDictionary*)api response:(NSURLResponse*)rep{
    
}
- (void)OnHttpDataBack:(NSString *)api responseDWay:(int)dw data:(NSData *)data userInfo:(id)userInfo response:(NSURLResponse *)rep{
}

#pragma mark 代理区

- (void)dealloc {
}

@end
