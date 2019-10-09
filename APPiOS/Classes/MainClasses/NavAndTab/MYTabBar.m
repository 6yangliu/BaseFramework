//
//  HMTabBar.m
//  
//
//  Created by apple on 15/3/24.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "MYTabBar.h"
#import "SXToolsMacro.h"

@implementation MYTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = [UIColor clearColor];
        line.frame = CGRectMake(0, 0, kMainScreenWidth, 0.5);
        [self addSubview:line];
        
        MYTabBarButton *tabBtn01 = [[MYTabBarButton alloc] init];
        tabBtn01.backgroundColor=[UIColor clearColor];
        [tabBtn01 setImage:IMAGENAMED(@"tab01_s") forState:UIControlStateNormal];
        [tabBtn01 setImage:IMAGENAMED(@"tab01_n") forState:UIControlStateSelected];
        [tabBtn01 setTitle:ALS(@"钱包") forState:UIControlStateNormal];
        self.tabBtn01 = tabBtn01;
        
        MYTabBarButton *tabBtn02= [[MYTabBarButton alloc] init];
        tabBtn02.backgroundColor=[UIColor clearColor];
        [tabBtn02 setImage:IMAGENAMED(@"tab02_s") forState:UIControlStateNormal];
        [tabBtn02 setImage:IMAGENAMED(@"tab02_n") forState:UIControlStateSelected];
        [tabBtn02 setTitle:ALS(@"糖果") forState:UIControlStateNormal];
        self.tabBtn02 = tabBtn02;
  
        MYTabBarButton *tabBtn03 = [[MYTabBarButton alloc] init];
        tabBtn03.backgroundColor=[UIColor clearColor];
        [tabBtn03 setImage:IMAGENAMED(@"tab03_s") forState:UIControlStateNormal];
        [tabBtn03 setImage:IMAGENAMED(@"tab03_n") forState:UIControlStateSelected];
        [tabBtn03 setTitle:ALS(@"应用") forState:UIControlStateNormal];
        self.tabBtn03 = tabBtn03;
        
        MYTabBarButton *tabBtn04 = [[MYTabBarButton alloc] init];
        tabBtn04.backgroundColor=[UIColor clearColor];
        [tabBtn04 setImage:IMAGENAMED(@"tab04_s") forState:UIControlStateNormal];
        [tabBtn04 setImage:IMAGENAMED(@"tab04_n") forState:UIControlStateSelected];
        [tabBtn04 setTitle:ALS(@"我的") forState:UIControlStateNormal];
        self.tabBtn04 = tabBtn04;
        
        [self addSubview:tabBtn01];
        [self addSubview:tabBtn02];
        [self addSubview:tabBtn03];
        [self addSubview:tabBtn04];
    }
    return self;
}

-(void)layoutSubviews {
    
    CGFloat W = self.frame.size.width / 4;
    CGFloat H = self.frame.size.height;
    
    self.tabBtn01.frame = CGRectMake(0, 0.5, W, H-0.5);
    self.tabBtn01.tag = 1000;

    
    self.tabBtn02.frame = CGRectMake(W*1, 0.5, W, H-0.5);
    self.tabBtn02.tag = 1001;
    
    self.tabBtn03.frame = CGRectMake(W*2, 0.5, W, H-0.5);
    self.tabBtn03.tag = 1002;
    
    self.tabBtn04.frame = CGRectMake(W*3, 0.5, W, H-0.5);
    self.tabBtn04.tag = 1003;
    
    for (id vw in self.subviews) {
        if (![vw isKindOfClass:[MYTabBarButton class]]
            && ![vw isKindOfClass:[UILabel class]]) {
            [vw removeFromSuperview];
        }
    }
}

@end
