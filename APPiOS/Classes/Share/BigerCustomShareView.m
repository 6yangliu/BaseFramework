//
//  BigerCustomShareView.m
//  APPiOS
//
//  Created by 刘吉星 on 2018/6/22.
//  Copyright © 2018年 shengxi. All rights reserved.
//

#import "BigerCustomShareView.h"
#import "Masonry.h"
#import "AppDelegate.h"
#import "UIView+Extensions.h"
#import "UIViewController+loadingAnimation.h"
@interface BigerCustomShareView ()
@property(nonatomic,strong) UIView * infoView;

@property(nonatomic,assign)   EShareType shareType;
@property (nonatomic, strong) UIView * bgView;

@property (nonatomic, strong) NSArray * titleArray;
@property (nonatomic, strong) NSArray * imageArray;
@property (nonatomic, strong) NSArray * shareTagArray;

@end

@implementation BigerCustomShareView


+ (instancetype)createCustomShareViewWithShareType:(EShareType)type{
    BigerCustomShareView * view = [[BigerCustomShareView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight)];
    view.shareType=type;
    [view menuConfig];
    [view setupViews];
    return view;
}

- (void)setupViews {
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    for (UIView *view in window.subviews) {
        if([view isKindOfClass:[self class]]){
            [self removeFromSuperview];
        }
    }
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    if(self.shareType==EShareType_fastnews){
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    }
    
    [window addSubview:self];
    
    [self creatShareView];
    [self addSubview:self.bgView];
    [self addSubview:self.infoView];
}
- (void)creatShareView
{
    CGFloat imageWidth = 50;
    CGFloat imageSpaceH = 50;
    CGFloat imageSpaceW = (kMainScreenWidth - imageWidth * 3)/4;
    
    for ( NSInteger i = 0; i <_imageArray.count; i++) {
        UIImageView * view = [[UIImageView alloc] initWithFrame:CGRectMake(imageSpaceW + i % 3 * (imageSpaceW + imageWidth), 20 + i / 3 * (imageWidth + imageSpaceH), imageWidth, imageWidth)];
        view.image = [UIImage imageNamed:_imageArray[i]];
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareBtnClick:)];
        
        view.tag = [self.shareTagArray[i] integerValue];//分享类型
        
        [view addGestureRecognizer:tap];
        [self.infoView addSubview:view];
        
        UILabel * label = [[UILabel alloc] init];
        label.text = _titleArray[i];
        label.textColor = UIColorFromRGB(0x0F3652);
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        
        [self.infoView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(60));
            make.height.equalTo(@20);
            make.centerX.equalTo(view);
            make.top.equalTo(view.mas_bottom).offset(5);
        }];
    }
    
    UILabel *lineLabel = [[UILabel alloc]init];
    [self.infoView addSubview:lineLabel];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(kMainScreenWidth));
        make.height.equalTo(@0.5);
        make.top.equalTo(self.infoView.mas_bottom).offset(-48);
        make.left.equalTo(self.infoView);
    }];
    lineLabel.backgroundColor = UIColorFromRGB(0xeff3f5);
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.infoView addSubview:cancleBtn];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(kMainScreenWidth));
        make.bottom.equalTo(self.infoView);
        make.top.equalTo(lineLabel.mas_bottom);
        make.left.equalTo(self.infoView);
    }];
    [cancleBtn setTitle:ALS(@"取消") forState:UIControlStateNormal];
    [cancleBtn setTitleColor:UIColorFromRGB(0x3092FC) forState:UIControlStateNormal];
    cancleBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [cancleBtn addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [self hide];
    }];
    
}

-(void)menuConfig{
    if(self.shareType==EShareType_default){
//        _shareTagArray=@[[NSNumber numberWithInteger:EShareButtonCopy],
//                         [NSNumber numberWithInteger:EShareButtonWechat],
//                         [NSNumber numberWithInteger:EShareButtonWechatSocial],
//                         [NSNumber numberWithInteger:EShareButtonQQ],
//                         [NSNumber numberWithInteger:EShareButtonEmail],
//                         [NSNumber numberWithInteger:EShareButtonTwitter]
//                         ];
//        _titleArray = @[ALS(@"复制"),ALS(@"微信好友"),ALS(@"朋友圈"),ALS(@"QQ"),ALS(@"邮件"),ALS(@"Twitter")];
//        _imageArray   = @[@"copy_image",@"wxIcon",@"wxFriendIcon",@"qqIcon",@"EmailIcon",@"TwitterIcon"];
        
        _shareTagArray=@[[NSNumber numberWithInteger:EShareButtonCopy],
                         [NSNumber numberWithInteger:EShareButtonWechat],
                         [NSNumber numberWithInteger:EShareButtonQQ],
                         ];
        _titleArray = @[ALS(@"复制"),ALS(@"微信好友"),ALS(@"QQ")];
        _imageArray   = @[@"copy_image",@"wxIcon",@"qqIcon"];
    }else  if(self.shareType==EShareType_fastnews){
        
        _shareTagArray=@[[NSNumber numberWithInteger:EShareButtonSaveImage],
                         [NSNumber numberWithInteger:EShareButtonWechat],
                         [NSNumber numberWithInteger:EShareButtonWechatSocial],
                         [NSNumber numberWithInteger:EShareButtonQQ],
                         [NSNumber numberWithInteger:EShareButtonEmail],
                         [NSNumber numberWithInteger:EShareButtonTwitter]
                         ];
        _titleArray = @[ALS(@"保存图片"),ALS(@"微信好友"),ALS(@"朋友圈"),ALS(@"QQ"),ALS(@"邮件"),ALS(@"Twitter")];
        _imageArray   = @[@"save_image",@"wxIcon",@"wxFriendIcon",@"qqIcon",@"EmailIcon",@"TwitterIcon"];
        
    }
    
}

- (void)show {
    self.infoView.y = self.height;
    [UIView animateWithDuration:0.35 animations:^{
        self.infoView.y = self.height - self.infoView.height;
    }];
}
- (void)hide {
    [UIView animateWithDuration:0.35 animations:^{
        self.infoView.y = self.height;
    } completion:^(BOOL finished) {
        
        if([self.shareDelegate respondsToSelector:@selector(didShareViewHide)]){
            [self.shareDelegate didShareViewHide];
        }
        [self removeFromSuperview];
    }];
}


#pragma mark 选择分享按钮点击
- (void)shareBtnClick:(UITapGestureRecognizer *)tap
{
    if (self.shareDelegate
        && [_shareDelegate respondsToSelector:@selector(shareWithType:)]) {
        [self.shareDelegate  shareWithType:tap.view.tag];
        
    }
    [self hide];
    
}



#pragma mark - getter
- (UIView *)infoView {
    if (_infoView == nil) {
        _infoView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height, self.width, 150)];
        _infoView.backgroundColor = [UIColor whiteColor];
        [self creatShareView];
    }
    return _infoView;
}
- (UIView *)bgView {
    if (_bgView == nil) {
        _bgView = [[UIView alloc] initWithFrame:self.bounds];
        _bgView.userInteractionEnabled = YES;
        [_bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)]];
    }
    return _bgView;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
