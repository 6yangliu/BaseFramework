//
//  XYSegmentView.m
//  CLFZS
//  自定义分段控件
//  Created by jysd on 14/12/12.
//  Copyright (c) 2014年 jysd. All rights reserved.
//

//scrollview 背景色
#define Color_ScrollviewBg [UIColor colorWithRed:236.0/255.0 green:237.0/255.0 blue:239.0/255.0 alpha:1.0]
//分割线的颜色
#define Color_line [UIColor colorWithRed:222.0f/255.0f green:223.0f/255.0f blue:225.0f/255.0f alpha:1.0f]
//默认文字颜色
#define Color_TextDefault [UIColor colorWithRed:112.0f/255.0f green:112.0f/255.0f blue:112.0f/255.0f alpha:1.0f]
//改变后的文字颜色（项目需求:无变化 同默认文字颜色）
#define Color_TextChanged [UIColor colorWithRed:112.0f/255.0f green:112.0f/255.0f blue:112.0f/255.0f alpha:1.0f]
//滑动横线的颜色
#define Color_SepratorView [UIColor colorWithRed:28.0f/255.0f green:141.0f/255.0f blue:255.0f/255.0f alpha:1.0f]

#define KDefaultFontSize 14.0f
#define KSelectFontSize 16.0f

#import "XYSegmentView.h"
#import <QuartzCore/QuartzCore.h>

@implementation XYSegmentView
{
    int currentIndex;//当前选中
    int lastSelectIndex;//上一次选中
    int showCount;//当前显示的菜单个数
    int baseTag; //tag定义规则
    int paddingSize;
}
//初始化参数
-(void)initParam{
    itemStyle=XYSegmentViewItemStyle1;
    baseTag=1000;
    currentIndex=0;
    lastSelectIndex=1+baseTag;
    showCount=3;
    itembackColor=[UIColor clearColor];
    titleSelectColor=Color_TextChanged;
    titleColor=Color_TextDefault;
    defaultFontSize=KDefaultFontSize;
    selectFontSize=KSelectFontSize;
    defaultSepratorColor=Color_SepratorView;
    
}
@synthesize itemStyle,scrollView,titleArr,titleWidthArr,currentIndex,delegate,showCount,itembackColor,titleColor,titleSelectColor,sepratorView,sepratorViewMode,sepratorViewHeight,itemBoardView,titleHeightArr,isFontBiger,defaultFontSize,selectFontSize,defaultSepratorColor;
- (id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
        [self initParam];
        CGRect tmpRC=self.bounds;
        tmpRC.size.width=self.bounds.size.width;
        tmpRC.size.height=self.bounds.size.height;
        scrollView=[[UIScrollView alloc] initWithFrame:tmpRC];
        [scrollView setDirectionalLockEnabled:YES];//滚动方向锁定
        [scrollView setBounces:YES];
        [scrollView setShowsHorizontalScrollIndicator:NO];
        [scrollView setShowsVerticalScrollIndicator:NO];
        self.backgroundColor=Color_ScrollviewBg;
        [self addSubview:scrollView];
        
        UIView *line=[[UIView alloc] initWithFrame:CGRectMake(0, scrollView.frame.size.height-1, scrollView.frame.size.width, 1)];
        line.backgroundColor=[UIColor clearColor];
        [self addSubview:line];
        [self bringSubviewToFront:line];
        
        //底部滑动横线
        sepratorView=[[UIView alloc] init];
        sepratorView.backgroundColor=defaultSepratorColor;
        [scrollView addSubview:sepratorView];
        sepratorView.layer.cornerRadius=2;
        sepratorView.hidden=YES;//根据需求是否需要下面滑动的线
        [scrollView bringSubviewToFront:sepratorView];
        sepratorViewMode=0;//0：横线自适应文字宽度 1：横线与item宽度一样 2:固定宽度
        sepratorViewHeight=3;
        _sepratorViewWidth=24;
        //移动的滑块
        itemBoardView=[[UIView alloc] init];
        itemBoardView.backgroundColor=[UIColor blackColor];
        [scrollView sendSubviewToBack:itemBoardView];
        [scrollView addSubview:itemBoardView];
        isFontBiger=NO;
    }
    return self;
}


- (void)startCreate{
    
    titleWidthArr=[NSMutableArray arrayWithCapacity:0];
    titleHeightArr=[NSMutableArray arrayWithCapacity:0];
    float height=scrollView.frame.size.height;
    int x=0;
    for (int i=0; i<titleArr.count; i++) {
        UIFont *font=[UIFont fontWithName:self.isBoldFont? @"Helvetica-Bold":@"Helvetica" size:[XYStringOperate GetFontSizeByScreenWithPrt:defaultFontSize]];
        
        
        
        imagebutton=[[UIView alloc] init];
        if(i==0){
            imagebutton.backgroundColor=itembackColor;
        }
        imagebutton.tag=baseTag+(i+1);
        imagebutton.frame=CGRectMake(x,0,scrollView.frame.size.width/showCount,height);
        x+=scrollView.frame.size.width/showCount;
        label=[[UILabel alloc] initWithFrame:imagebutton.bounds];
        label.font=font;
        //计算文字宽度
        CGFloat textWith=[titleArr[i] sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, height)].width;
//        NSLog(@"textWith:%f",textWith);
        
        CGFloat textHeight=[XYStringOperate getLabelSizeWithText:titleArr[i] Size:CGSizeMake(textWith, MAXFLOAT) font:font].height;
        [titleWidthArr addObject:[NSNumber numberWithFloat:textWith]];//文字宽度值数组
        [titleHeightArr addObject:[NSNumber numberWithFloat:textHeight]];//文字高度值数组
        //默认色
        label.textColor=titleColor;
        if(i==0){
             //改变后的颜色
            label.textColor=titleSelectColor;
            if(isFontBiger){
                label.font=[UIFont fontWithName:self.isBoldFont? @"Helvetica-Bold":@"Helvetica" size:[XYStringOperate GetFontSizeByScreenWithPrt:selectFontSize]];
            }
            //滑动横线的默认位置
            if(sepratorViewMode==0){
                sepratorView.frame=CGRectMake(0, scrollView.frame.size.height-sepratorViewHeight, [titleWidthArr[0] floatValue], sepratorViewHeight);
                CGPoint s_center;
                if(itemStyle==XYSegmentViewItemStyle1){//默认风格
                     s_center=CGPointMake(imagebutton.center.x, sepratorView.center.y);
                }else if (itemStyle==XYSegmentViewItemStyle2){
                    if(i==0){
                        s_center=CGPointMake(imagebutton.x+sepratorView.frame.size.width/2, sepratorView.center.y);
                    }
                    else if(i==titleArr.count-1){
                        s_center=CGPointMake(CGRectGetMaxX(imagebutton.frame)-sepratorView.frame.size.width/2, sepratorView.center.y);
                    }else{
                        s_center=CGPointMake(imagebutton.center.x, sepratorView.center.y);
                    }
                }else{
                    s_center=CGPointMake(imagebutton.center.x, sepratorView.center.y);
                }
                sepratorView.center=s_center;
            }else if (sepratorViewMode==1){
                sepratorView.frame=CGRectMake(0, scrollView.frame.size.height-sepratorViewHeight, scrollView.frame.size.width/showCount, sepratorViewHeight);
                CGPoint s_center=CGPointMake(imagebutton.center.x, sepratorView.center.y);
                sepratorView.center=s_center;
            }else if (sepratorViewMode==2){
                sepratorView.frame=CGRectMake(0, scrollView.frame.size.height-sepratorViewHeight, self.sepratorViewWidth, sepratorViewHeight);
                CGPoint s_center=CGPointMake(imagebutton.center.x, sepratorView.center.y);
                sepratorView.center=s_center;
            }
            //滑块
            itemBoardView.frame=CGRectMake(0, 0, [titleWidthArr[0] floatValue]+15, [titleHeightArr[0] floatValue]+10);
            itemBoardView.layer.cornerRadius=itemBoardView.height/2;
            CGPoint itemBoardView_center;
            if(itemStyle==XYSegmentViewItemStyle1){
                itemBoardView_center=CGPointMake(imagebutton.center.x, imagebutton.center.y);
            }else if (itemStyle==XYSegmentViewItemStyle2){
                if(i==0){
                    itemBoardView_center=CGPointMake(0+itemBoardView.frame.size.width/2, imagebutton.center.y);
                }else if (i==titleArr.count-1){
                     itemBoardView_center=CGPointMake(CGRectGetMaxX(imagebutton.frame)-itemBoardView.frame.size.width/2, imagebutton.center.y);
                }else{
                   itemBoardView_center=CGPointMake(imagebutton.center.x, imagebutton.center.y);
                }
            }else{
                itemBoardView_center=CGPointMake(imagebutton.center.x, imagebutton.center.y);
            }
            
            itemBoardView.center=itemBoardView_center;
        }
        label.textAlignment=NSTextAlignmentCenter;

        if (itemStyle==XYSegmentViewItemStyle2){
            
            if(i==0){
                label.textAlignment=NSTextAlignmentLeft;
            }
            if(i==titleArr.count-1){
                label.textAlignment=NSTextAlignmentRight;
            }
            
        }
       
        label.text=titleArr[i];
        [imagebutton addSubview:label];
        [scrollView addSubview:imagebutton];
        [self addTapGestureRecognizer:imagebutton];
    }
    UIView *tmpView = [scrollView viewWithTag:titleArr.count+baseTag];
    scrollView.contentSize=CGSizeMake(tmpView.frame.origin.x+tmpView.frame.size.width, 0);
}


- (void)addTapGestureRecognizer:(UIView *)view{
    UITapGestureRecognizer *single=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapRecognizer:)];
    single.numberOfTapsRequired=1;
    single.numberOfTouchesRequired=1;
    [view addGestureRecognizer:single];
}

- (void)handleTapRecognizer:(UITapGestureRecognizer *)recognizer{
    if((int)recognizer.view.tag==lastSelectIndex){
        return;
    }
    int selectIndex=(int)recognizer.view.tag-baseTag-1;
    currentIndex=(int)recognizer.view.tag-baseTag-1;
    [self changeSegmentItemState:selectIndex];
    if([delegate respondsToSelector:@selector(SegmentOnitemCLick:segement:)]){
        [delegate SegmentOnitemCLick:selectIndex segement:self];
    }
}


- (void)changeSegmentItemState:(NSInteger)selectIndex{
    NSLog(@"%li",selectIndex);
    if(selectIndex==(lastSelectIndex-baseTag-1)){
        return;
    }
    
    UIView *view=[scrollView viewWithTag:selectIndex+baseTag+1];
    view.backgroundColor=itembackColor;
    //=======================字体颜色改变=======================
    for ( UIView *subview in [view subviews] ) {
        if([subview isKindOfClass:[UILabel class]]){
            UILabel *lab=(UILabel *)subview;
            //改变后的颜色
            lab.textColor=titleSelectColor;
            if(isFontBiger){
                lab.font=[UIFont fontWithName:self.isBoldFont? @"Helvetica-Bold":@"Helvetica" size:[XYStringOperate GetFontSizeByScreenWithPrt:selectFontSize]];
            }
        }
    }
    UIView *lastSelectView=[scrollView viewWithTag:lastSelectIndex];
    lastSelectView.backgroundColor=[UIColor clearColor];
    for ( UIView *subview in [lastSelectView subviews] ) {
        if([subview isKindOfClass:[UILabel class]]){
            UILabel *lab=(UILabel *)subview;
            //默认色
            lab.textColor=titleColor;
            lab.font=[UIFont fontWithName:self.isBoldFont? @"Helvetica-Bold":@"Helvetica" size:[XYStringOperate GetFontSizeByScreenWithPrt:defaultFontSize]];
        }
    }
    //=======================================================
    lastSelectIndex=selectIndex+baseTag+1;
    
    //=========================横线移动==============================
    
    [UIView animateWithDuration:0.2f animations:^{
        if(sepratorViewMode==0){
            sepratorView.frame=CGRectMake(0, scrollView.frame.size.height-sepratorViewHeight, [titleWidthArr[selectIndex] floatValue], sepratorViewHeight);
            
            CGPoint s_center;
            if(itemStyle==XYSegmentViewItemStyle1){//默认风格
                s_center=CGPointMake(view.center.x, sepratorView.center.y);
            }else if (itemStyle==XYSegmentViewItemStyle2){
                if(selectIndex==0){
                    s_center=CGPointMake(view.x+sepratorView.frame.size.width/2, sepratorView.center.y);
                }
                else if(selectIndex==titleArr.count-1){
                    s_center=CGPointMake(CGRectGetMaxX(view.frame)-sepratorView.frame.size.width/2, sepratorView.center.y);
                }else{
                    s_center=CGPointMake(view.center.x, sepratorView.center.y);
                }
            }else{
                s_center=CGPointMake(view.center.x, sepratorView.center.y);
            }
            
            sepratorView.center=s_center;
            
        }else if (sepratorViewMode==1){
            sepratorView.frame=CGRectMake(0, scrollView.frame.size.height-sepratorViewHeight, scrollView.frame.size.width/showCount, sepratorViewHeight);
            CGPoint s_center=CGPointMake(view.center.x, sepratorView.center.y);
            sepratorView.center=s_center;
        }else if (sepratorViewMode==2){
            sepratorView.frame=CGRectMake(0, scrollView.frame.size.height-sepratorViewHeight, self.sepratorViewWidth, sepratorViewHeight);
            CGPoint s_center=CGPointMake(view.center.x, sepratorView.center.y);
            sepratorView.center=s_center;
        }
    } completion:^(BOOL finished) {
        
    }];
     //=========================滑块移动==============================
    [UIView animateWithDuration:0.2f animations:^{
        itemBoardView.frame=CGRectMake(0, 0, [titleWidthArr[selectIndex] floatValue]+15, [titleHeightArr[selectIndex] floatValue]+10);
        itemBoardView.layer.cornerRadius=itemBoardView.height/2;
        CGPoint itemBoardView_center;
        
        if(itemStyle==XYSegmentViewItemStyle1){
            itemBoardView_center=CGPointMake(view.center.x, imagebutton.center.y);
        }else if (itemStyle==XYSegmentViewItemStyle2){
            if(selectIndex==0){
                itemBoardView_center=CGPointMake(0+itemBoardView.frame.size.width/2, imagebutton.center.y);
            }else if (selectIndex==titleArr.count-1){
                itemBoardView_center=CGPointMake(CGRectGetMaxX(view.frame)-itemBoardView.frame.size.width/2, imagebutton.center.y);
            }else{
                itemBoardView_center=CGPointMake(view.center.x, imagebutton.center.y);
            }
        }else{
            itemBoardView_center=CGPointMake(view.center.x, imagebutton.center.y);
        }
        
        itemBoardView.center=itemBoardView_center;
    } completion:^(BOOL finished) {
        
    }];
    //==============================================================
    
    //==============================================================
    //设置偏移(数量多于一屏时的情况)
    int contentSizewidth=scrollView.contentSize.width;
    int scrollViewWith=scrollView.frame.size.width;
    int ofset=contentSizewidth-scrollViewWith;
    if(ofset>=0){
        int ofsetX=view.frame.origin.x-view.frame.size.width;
        if(ofsetX>=-view.frame.size.width/2&&ofsetX<=(ofset+view.frame.size.width/2)){
            [scrollView setContentOffset:CGPointMake(ofsetX,0) animated:YES];
        }else if (ofsetX<=-view.frame.size.width/2){
            [scrollView setContentOffset:CGPointMake(0,0) animated:YES];
        }else if (ofsetX>(ofset+view.frame.size.width/2)){
            [scrollView setContentOffset:CGPointMake(ofset,0) animated:YES];
        }
    }

    
    currentIndex=selectIndex;
    
}
-(void)reloadSegmentData{
    for (UIView *view in scrollView.subviews) {
        if(view!=sepratorView&&view!=itemBoardView){
            [view removeFromSuperview];
        }
    }
    [self startCreate];
    if(self.titleArr.count){
        [self changeSegmentItemState:0];
    }
}



@end
