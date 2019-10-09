//
//  XYPageContainer.m
//  CLFZS
//
//  Created by jysd on 15/1/13.
//  Copyright (c) 2015年 jysd. All rights reserved.
//

#import "XYPageContainer.h"
@implementation XYPageContainer{
    int lastIndex;
}
@synthesize m_scrollView,viewsDic;
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
- (void)StartCreate{
    [self instanceScrollView];
}

//初始化ScrollView
- (void)instanceScrollView{
    viewsDic=[NSMutableDictionary dictionaryWithCapacity:0];
    m_scrollView=[[UIScrollView alloc] initWithFrame:self.bounds];
    m_scrollView.pagingEnabled=YES;
    m_scrollView.delegate=self;
    m_scrollView.showsHorizontalScrollIndicator=NO;
    [self addSubview:m_scrollView];
}


#pragma mark- scrollViewdelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if([self.delegate respondsToSelector:@selector(XYPageContainerScrollViewDidEndDecelerating:)]){
            [self.delegate XYPageContainerScrollViewDidEndDecelerating:scrollView];
    }
}

- (void)loadViewFromPageContainerWithView:(UIViewController *)viewCtrl index:(NSInteger)selectindex totalPage:(NSInteger)totalPage{
    UIView *m_view=viewCtrl.view;
    m_scrollView.contentSize=CGSizeMake(m_scrollView.frame.size.width*totalPage, 0);
    UIViewController *viewController=nil;//父视图
    if([viewsDic objectForKey:[NSString stringWithFormat:@"%i",(int)selectindex]]){
        
        [UIView animateWithDuration:.25 animations:^
         {
            m_scrollView.contentOffset=CGPointMake(m_scrollView.frame.size.width*(int)selectindex, 0);
         }];
        //保证子控制器的 正常生命周期
        [viewCtrl beginAppearanceTransition:YES animated:NO];
        [viewCtrl endAppearanceTransition];
        [viewCtrl didMoveToParentViewController:viewController];
        
        
        return;
    }else{
        CGRect viewRC=m_view.bounds;
        viewRC.origin.x=m_scrollView.frame.size.width*(int)selectindex;
        m_view.frame=viewRC;
        m_view.userInteractionEnabled=YES;
        [m_scrollView addSubview:m_view];
        
        //获取UIView 所在的UIViewController
        for (UIView *next=[self superview]; next ;next=[next superview]) {
            UIResponder *responder=[next nextResponder];
            if([responder isKindOfClass:[UIViewController class]]){
                viewController=(UIViewController *)responder;
                break;
            }
        }
        [viewController addChildViewController:viewCtrl];
     
        
        [UIView animateWithDuration:.25 animations:^
         {
             m_scrollView.contentOffset=CGPointMake(m_scrollView.frame.size.width*(int)selectindex, 0);
         }];
        
        [viewsDic setObject:viewCtrl forKey:[NSString stringWithFormat:@"%i",(int)selectindex]];
    }
    //保证子控制器的 正常生命周期
    [viewCtrl beginAppearanceTransition:YES animated:YES];
    [viewCtrl endAppearanceTransition];
    [viewCtrl didMoveToParentViewController:viewController];
    
    
}



@end
