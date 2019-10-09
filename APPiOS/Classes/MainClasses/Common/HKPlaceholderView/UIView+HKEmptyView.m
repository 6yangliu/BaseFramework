//
//  UIScrollView+PlaceholderView.m
//  UIScrollViewPlaceholderView
//
//  Created by 蔡强 on 2017/9/17.
//  Copyright © 2017年 kuaijiankang. All rights reserved.
//

#import "UIView+HKEmptyView.h"
#import <ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import <objc/runtime.h>

@interface UIView ()

/** 用来记录UIScrollView最初的scrollEnabled */
@property (nonatomic, assign) BOOL originalScrollEnabled;

@property (nonatomic, copy) ReloadBlock reloadBlock;


@end

@implementation UIView (HKEmptyView)

static void *placeholderViewKey = &placeholderViewKey;
static void *originalScrollEnabledKey = &originalScrollEnabledKey;
static void *reloadBlockKey = &reloadBlockKey;
static void *loadingViewKey = &loadingViewKey;
- (UIView *)placeholderView {
    return objc_getAssociatedObject(self, &placeholderViewKey);
}

- (void)setPlaceholderView:(UIView *)placeholderView {
    objc_setAssociatedObject(self, &placeholderViewKey, placeholderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)originalScrollEnabled {
    return [objc_getAssociatedObject(self, &originalScrollEnabledKey) boolValue];
}

- (void)setOriginalScrollEnabled:(BOOL)originalScrollEnabled {
    objc_setAssociatedObject(self, &originalScrollEnabledKey, @(originalScrollEnabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ReloadBlock)reloadBlock{
    
    return objc_getAssociatedObject(self, &reloadBlockKey);
}
- (void)setReloadBlock:(ReloadBlock)reloadBlock{
     objc_setAssociatedObject(self, &reloadBlockKey, reloadBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (UIView *)loadingView {
    return objc_getAssociatedObject(self, &loadingViewKey);
}

- (void)setLoadingView:(UIView *)loadingView{
    objc_setAssociatedObject(self, &loadingViewKey, loadingView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark - 展示UIView或其子类的占位图
/**
 展示UIView或其子类的占位图
 
 @param type 占位图类型
 @param reloadBlock 重新加载回调的block
 */
- (void)showPlaceholderViewWithType:(HKPlaceholderViewType)type msg:(NSString *)msg :(ReloadBlock)reloadBlock{
    self.reloadBlock =reloadBlock;
    CGFloat y_offset=0;
    if ([self isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)self;
        self.originalScrollEnabled = scrollView.scrollEnabled;
    }
    UITableView *tableView=nil;
    if ([self isKindOfClass:[UITableView class]]) {
        tableView = (UITableView *)self;
        y_offset=tableView.tableHeaderView.height;
    }
    if (self.placeholderView) {
        [self.placeholderView removeFromSuperview];
        self.placeholderView = nil;
    }
    self.placeholderView = [[UIView alloc] initWithFrame:CGRectMake(0, y_offset, self.width, self.height+y_offset)];
    self.placeholderView.userInteractionEnabled=YES;
    [self addSubview:self.placeholderView];
    self.placeholderView.backgroundColor = [UIColor whiteColor];
   
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.placeholderView addSubview:imageView];
   
    
    //------- 描述 -------//
    UILabel *descLabel = [[UILabel alloc] init];
    descLabel.font=[UIFont boldSystemFontOfSize:KScreenPrt(18)];
    descLabel.textColor = UIColorFromRGB(0x0F3652);
    descLabel.numberOfLines=0;
    descLabel.textAlignment=1;
    [self.placeholderView addSubview:descLabel];
    
    UILabel *subdescLabel = [[UILabel alloc] init];
    subdescLabel.font=[UIFont systemFontOfSize:KScreenPrt(14)];
    subdescLabel.textColor = UIColorFromRGB(0x647E94);
    subdescLabel.numberOfLines=0;
    subdescLabel.textAlignment=1;
    [self.placeholderView addSubview:subdescLabel];
    
    //按钮
    UIButton *btn=[[UIButton alloc] init];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:KScreenPrt(18)]];
    [btn setTitleColor:UIColorFromRGB(0x3092FC) forState:0];
    btn.hidden=NO;
    [self.placeholderView addSubview:btn];
    
    self.loadingView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.loadingView.hidden=YES;
    [self.placeholderView addSubview:self.loadingView];
    //------- 根据type设置不同UI -------//
    if(msg.length){
        descLabel.text = msg;
    }
    switch (type) {
        case HKPlaceholderViewTypeNoNetwork: // 网络不好
        {
            imageView.image =[UIImage imageNamed:@"Image_NoNetwork"];
            descLabel.text = ALS(@"网络异常");
            subdescLabel.text=ALS(@"无网络链接，请检查网络设置");
            [btn setTitle:ALS(@"重新加载") forState:0];
        }
            break;
            
        case HKPlaceholderViewTypeNoData: // 无数据
        {
            imageView.image = [UIImage imageNamed:@"Image_NoData"];
            descLabel.text = ALS(@"暂无数据");
        }
            break;
        
        case HKPlaceholderViewTypeStopService: // 暂停业务
        {
            imageView.image = [UIImage imageNamed:@"Image_Notice"];
        }
            break;
        default:
            break;
        case HKPlaceholderViewTeam: 
        {
            imageView.image =[UIImage imageNamed:@"Image_NoRecord"];
            descLabel.text = ALS(@"提示");
            subdescLabel.text=ALS(@"您还未归属任何服务商,请先加入或者创建服务商");
            [btn setTitle:ALS(@"立即加入或创建") forState:0];
        }
            
            break;
            
        case HKPlaceholderViewTeamRefuse:
        {
            imageView.image =[UIImage imageNamed:@"Image_NoRecord"];
            descLabel.text = ALS(@"服务商审核不通过");
            descLabel.textColor=[UIColor redColor];
            subdescLabel.text=[NSString stringWithFormat:@"原因:%@",msg];;
            subdescLabel.textAlignment=0;
            [btn setTitle:ALS(@"立即加入或创建") forState:0];
        }
            
            break;
            
        case HKPlaceholderViewAuthorized:
        {
            imageView.image =[UIImage imageNamed:@"Image_NoRecord"];
            descLabel.text = ALS(@"提示");
            subdescLabel.text=ALS(@"您还未实名认证,请先进行实名认证");
            [btn setTitle:ALS(@"立即完善") forState:0];
        }
            break;
        case HKPlaceholderViewAuthorizing:
        {
            imageView.image =[UIImage imageNamed:@"Image_NoRecord"];
            descLabel.text = ALS(@"账号认证中");
            subdescLabel.text=ALS(@"您的实名认证正在审核中");
            btn.hidden=YES;
        }
            break;
        case HKPlaceholderViewAuthorizRefuse:
        {
            imageView.image =[UIImage imageNamed:@"Image_NoRecord"];
            descLabel.text = ALS(@"账号认证不通过");
            descLabel.textColor=[UIColor redColor];
            subdescLabel.textAlignment=0;
            subdescLabel.text=[NSString stringWithFormat:@"原因:%@",msg];
        }
            break;
         
    }
    
    imageView.width=KScreenPrt(60);
    imageView.height=KScreenPrt(60);
    imageView.centerX=self.placeholderView.centerX;
    imageView.top=KScreenPrt(130);
    
    if(tableView){
        tableView.contentSize=CGSizeMake(0, tableView.height+tableView.tableHeaderView.height);
        imageView.top=KScreenPrt(130);
    }
    
    
    descLabel.width=KScreenPrt(186);
    descLabel.height=[XYStringOperate getLabelSizeWithText:descLabel.text Size:descLabel.size font:descLabel.font].height;
    descLabel.centerX=imageView.centerX;
    descLabel.top=imageView.bottom+KScreenPrt(10);
    
    subdescLabel.width=KScreenPrt(186);
    subdescLabel.height=[XYStringOperate getLabelSizeWithText:subdescLabel.text Size:subdescLabel.size font:subdescLabel.font].height;
    subdescLabel.centerX=imageView.centerX;
    subdescLabel.top=descLabel.bottom+KScreenPrt(8);
    
    [btn sizeToFit];
    btn.centerX=imageView.centerX;
    btn.top=subdescLabel.bottom+KScreenPrt(18);
    [btn addTarget:self action:@selector(didReloadBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.loadingView.center=btn.center;
}

#pragma mark-代理
-(void)didReloadBtnClick:(UIButton *)btn{
    if(self.reloadBlock){
        btn.hidden=YES;
        self.loadingView.hidden=NO;
        [self.loadingView startAnimating];
        self.reloadBlock(nil);
    }
}
#pragma mark - 主动移除占位图
/**
 主动移除占位图
 占位图会在你点击“重新加载”按钮的时候自动移除，你也可以调用此方法主动移除
 */
- (void)removePlaceholderView {
    if (self.placeholderView) {
        [self.placeholderView removeFromSuperview];
        self.placeholderView = nil;
    }
//    // 复原UIScrollView的scrollEnabled
//    if ([self isKindOfClass:[UIScrollView class]]) {
//        UIScrollView *scrollView = (UIScrollView *)self;
//        scrollView.scrollEnabled = self.originalScrollEnabled;
//    }
}

@end
