//
//  HKAlertView.m
//  AppleDP
//
//  Created by ly on 15/6/4.
//  Copyright (c) 2015年 kedll. All rights reserved.
//

#import "HKAlertView.h"


@implementation HKAlertView



-(instancetype)initWithTarget:(id)target title:(NSString *)title Message:(NSString *)msg cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle :(AlertViewTouchAction)block{
    self=[super init];
    if(self){
        titleStr=title;
        msgStr=msg;
        cancelButtonTitleStr=cancelButtonTitle;
        otherButtonTitleStr=otherButtonTitle;
        touchblock=block;
        [self initSubview];
    }
    return self;
}

-(void)initSubview{
    
    
    _backView = [UIButton buttonWithType:UIButtonTypeCustom];
    _backView.backgroundColor=[UIColor colorWithWhite:0 alpha:0.5];
   
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:_backView];
     [_backView setFrame:window.bounds];
    _backView.alpha=0;
    
    self.frame=CGRectMake(0, 0, KScreenPrt(280), KScreenPrt(165));
    self.backgroundColor=[UIColor whiteColor];
    self.layer.cornerRadius=KScreenPrt(4);
    self.layer.shadowOffset = CGSizeMake(4, 4);
    self.layer.shadowOpacity = 0.4;
    self.layer.shadowColor = UIColorFromRGB(0x999999).CGColor;
    self.center=_backView.center;
    [_backView addSubview:self];
    self.alpha=0;
    
    titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(KScreenPrt(31), KScreenPrt(32), self.width-KScreenPrt(31)*2, 0)];
    titleLabel.font=[UIFont boldSystemFontOfSize:KScreenPrt(18)];
    titleLabel.textColor=UIColorFromRGB(0x0F3652);
    titleLabel.text=titleStr;
    titleLabel.textAlignment=1;
    
    CGSize titleLabelSize=CGSizeMake(titleLabel.width, 0);
    titleLabelSize=[XYStringOperate getLabelSizeWithText:titleLabel.text Size:titleLabelSize font:titleLabel.font];
    titleLabel.height=titleLabelSize.height;
    [self addSubview:titleLabel];
    
    msgLabel=[[UILabel alloc] initWithFrame:CGRectMake(KScreenPrt(31), titleLabel.bottom+KScreenPrt(8), self.width-KScreenPrt(31)*2, 0)];
    msgLabel.font=[UIFont systemFontOfSize:KScreenPrt(14)];
    msgLabel.textColor=UIColorFromRGB(0x647E94);
    msgLabel.numberOfLines=0;
    msgLabel.text=msgStr;
    msgLabel.textAlignment=1;
    
    CGSize msgLabelSize=[XYStringOperate getLabelSizeWithText:msgLabel.text Size:msgLabel.size font:msgLabel.font];
    msgLabel.height=msgLabelSize.height;
    if(msgLabel.height<=KScreenPrt(34)){//控制最小高度
        msgLabel.height=KScreenPrt(34);
    }
    [self addSubview:msgLabel];
    
    
    UIView *sep1=[[UIView alloc] initWithFrame:CGRectMake(0, msgLabel.bottom+KScreenPrt(23), self.width, KScreenPrt(1))];
    sep1.backgroundColor=UIColorFromRGB(0xEEEEEE);
    [self addSubview:sep1];
    
    
    if(cancelButtonTitleStr&&otherButtonTitleStr){
        cancleBtn=[self getCommonBtn];
        [cancleBtn setTitle:cancelButtonTitleStr forState:0];
        cancleBtn.frame=CGRectMake(0, sep1.bottom, self.width/2,KScreenPrt(49));
        [self addSubview:cancleBtn];
        UIView *sep2=[[UIView alloc] initWithFrame:CGRectMake(cancleBtn.right, cancleBtn.top, KScreenPrt(1), cancleBtn.height)];
        sep2.backgroundColor=UIColorFromRGB(0xEEEEEE);
        [self addSubview:sep2];
        
        otherBtn=[self getCommonBtn];
        [otherBtn setTitle:otherButtonTitleStr forState:0];
        otherBtn.frame=CGRectMake(sep2.right, sep1.bottom, self.width/2, KScreenPrt(49));
        [self addSubview:otherBtn];
    }else{
        if(cancelButtonTitleStr){
            cancleBtn=[self getCommonBtn];
            [cancleBtn setTitle:cancelButtonTitleStr forState:0];
            cancleBtn.frame=CGRectMake(0, sep1.bottom, self.width,KScreenPrt(49));
            [self addSubview:cancleBtn];
        }
        if(otherButtonTitleStr){
            cancleBtn=[self getCommonBtn];
            [cancleBtn setTitle:otherButtonTitleStr forState:0];
            cancleBtn.frame=CGRectMake(0, sep1.bottom, self.width,KScreenPrt(49));
            [self addSubview:cancleBtn];
        }
    }

    if(cancleBtn){
        [cancleBtn addTarget:self action:@selector(didAlertBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    if(otherBtn){
        [otherBtn addTarget:self action:@selector(didAlertBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if(cancleBtn){
        self.height=cancleBtn.bottom;
    }else{
        if(otherBtn){
            self.height=otherBtn.bottom;
        }else{
            self.height=sep1.bottom+KScreenPrt(49);
        }
    }
    
     self.center=_backView.center;
}
#pragma mark-本类方法

-(XYButton *)getCommonBtn{
    XYButton *btn=[[XYButton alloc] init];
    [btn setTitleColor:UIColorFromRGB(0x3092FC) forState:0];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:KScreenPrt(18)]];
    return btn;
}


#pragma mark-消失
-(void)show{
    [UIView animateWithDuration:0.1 animations:^{
        _backView.alpha=1;
        self.alpha=1;
    }];
//    CAKeyframeAnimation *animation = [[CAKeyframeAnimation alloc] init];
//    [animation setDelegate:self];
//    animation.values = @[@(M_PI/64),@(-M_PI/64),@(M_PI/64),@(0)];
//    animation.duration = 0.5;
//    [animation setKeyPath:@"transform.rotation"];
//    animation.removedOnCompletion = NO;
//    animation.fillMode = kCAFillModeForwards;
//    [self.layer addAnimation:animation forKey:@"shake"];

}

-(void )dismiss{
    [UIView animateWithDuration:0.25 animations:^{
        _backView.alpha=0;
        [_backView removeFromSuperview];
        _backView = nil;
        [self removeFromSuperview];
    } completion:^(BOOL finished) {
        
    }];
}

-(void)didAlertBtnClick:(UIButton *)btn{
    if(btn==cancleBtn){
        if(touchblock){
            touchblock(0);
        }
    }
    if(btn==otherBtn){
        if(touchblock){
            touchblock(1);
        }
    }
    [self dismiss];
}


@end
