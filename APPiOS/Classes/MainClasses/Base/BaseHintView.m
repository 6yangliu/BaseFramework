//
//  BaseHintView.m
//  APPiOS
//
//  Created by 凌海龙 on 2018/6/12.
//  Copyright © 2018年 shengxi. All rights reserved.
//

#import "BaseHintView.h"

@implementation BaseHintView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)initWithTitleString:(NSString *)titleString withHintString:(NSString *)hintString{
    
    UILabel *titleLabel = [UILabel createLabelWithText:titleString withTextColor:[UIColor blackColor] withFont:16 withAlignment:NSTextAlignmentCenter];
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(FitCount(16));
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.offset(FitCount(30));
    }];
    
    UILabel *hintLabel = [UILabel createLabelWithText:titleString withTextColor:[UIColor blackColor] withFont:13 withAlignment:NSTextAlignmentCenter];
    CGRect rec = [hintString boundingRectWithSize:CGSizeMake(self.width-FitCount(30), CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil];
    hintLabel.frame = CGRectMake(FitCount(16), FitCount(54), self.width-FitCount(32), rec.size.height);
    [self addSubview:hintLabel];
    
    UIImageView *lineImgView1 = [[UIImageView alloc] init];
    lineImgView1.backgroundColor = BIGER_GRAY_COLOR;
    [self addSubview:lineImgView1];
    [lineImgView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(hintLabel.mas_bottom).offset(16);
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.offset(1);
    }];
    
    UIButton *sureButton = [[UIButton alloc] init];
    [sureButton setTitle:@"" forState:UIControlStateNormal];
    [sureButton setTitleColor:BIGER_BACKGROUND_COLOR forState:UIControlStateNormal];
    sureButton.titleLabel.font = FONT(17);
    self.sureButton = sureButton;
    [self addSubview:sureButton];
    [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineImgView1.mas_bottom).offset(10);
        make.left.mas_equalTo(self.mas_left).offset(100);
        make.right.mas_equalTo(self.mas_right).offset(100);
        make.height.offset(24);
    }];
    
}

@end
