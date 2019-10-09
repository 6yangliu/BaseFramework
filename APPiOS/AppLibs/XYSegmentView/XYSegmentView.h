//
//  XYSegmentView.h
//  CLFZS
//  自定义分段控件
//  Created by jysd on 14/12/12.
//  Copyright (c) 2014年 jysd. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XYSegmentViewItemStyle) {
    /** 默认风格，item 全部居中 */
    XYSegmentViewItemStyle1 = 0,
     /**第一个item 居坐，最后一个居右 其他居中 */
    XYSegmentViewItemStyle2
};


@class XYSegmentView;
@protocol XYSegmentDelegate <NSObject>

- (void)SegmentOnitemCLick:(NSInteger)selectedIndex segement:(XYSegmentView *)segment;

@end


@interface XYSegmentView : UIView
{
    UIView *imagebutton;
    UILabel *label;
    UIView *sepratorView;//底部横线
}
@property(nonatomic,assign)BOOL isBoldFont;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,assign)XYSegmentViewItemStyle itemStyle;
@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,assign)int showCount;
@property(nonatomic,strong)UIColor *itembackColor;
@property(nonatomic,strong)UIColor *titleColor;//标题颜色
@property(nonatomic,strong)UIColor *titleSelectColor;//标题选中颜色
@property(nonatomic,strong)NSMutableArray *titleWidthArr;//文字宽度
@property(nonatomic,strong)NSMutableArray *titleHeightArr;//文字高度
@property(nonatomic,assign)int currentIndex;
@property(weak,nonatomic)id<XYSegmentDelegate> delegate;
@property(assign,nonatomic)BOOL isFontBiger;//选中后字体是否变大

@property(assign,nonatomic)CGFloat defaultFontSize;//默认字体大小
@property(assign,nonatomic)CGFloat selectFontSize;//选中字体大小

@property(strong,nonatomic)UIView *sepratorView;//底部横线
@property(assign,nonatomic)int sepratorViewMode;//底部横线 0：横线自适应文字宽度 1：横线与item宽度一样 2:固定宽度
@property(assign,nonatomic)int sepratorViewHeight;//底部横线 高度
@property(assign,nonatomic)int sepratorViewWidth;//底部横线 宽度
@property(strong,nonatomic)UIView *itemBoardView;//滑块
@property(strong,nonatomic)UIColor *defaultSepratorColor;//滑块
- (void)startCreate;
- (void)changeSegmentItemState:(NSInteger)selectIndex;

-(void)reloadSegmentData;

@end
