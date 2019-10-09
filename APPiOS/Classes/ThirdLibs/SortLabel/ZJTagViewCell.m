//
//  ZJTagViewCell.m
//  ZJTagView
//
//  Created by ZeroJ on 16/10/24.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJTagViewCell.h"

@implementation ZJTagViewCell


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.titleLabel];
        self.contentView.backgroundColor = RGB(247, 248, 250);
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.frame = self.contentView.bounds;
    self.delButton.frame = CGRectMake(self.width-FitCount(12), - FitCount(12), FitCount(24), FitCount(24));
}

- (void)setInEditState:(BOOL)inEditState {
    _inEditState = inEditState;
    if (inEditState) {
//        self.titleLabel.backgroundColor = [UIColor redColor];
        if (self.tag == 0) {
            [self.contentView addSubview:self.delButton];
        }
    }
    else {
        self.titleLabel.backgroundColor = RGB(247, 248, 250);
        if (self.tag == 0) {
            [self.delButton removeFromSuperview];
        }
    }
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = RGB(87, 104, 119);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.adjustsFontSizeToFitWidth = YES;
        titleLabel.backgroundColor = RGB(247, 248, 250);
        titleLabel.layer.cornerRadius = 4.0;
        titleLabel.layer.masksToBounds = YES;
        titleLabel.font = FONT(16);
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

- (UIButton *)delButton{
    if (_delButton == nil) {
        _delButton = [[UIButton alloc] init];
        [_delButton setBackgroundImage:IMAGENAMED(@"home_del") forState:UIControlStateNormal];
    }
    return _delButton;
}
@end
