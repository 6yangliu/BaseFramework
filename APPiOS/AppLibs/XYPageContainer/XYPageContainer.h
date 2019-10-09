//
//  XYPageContainer.h
//  CLFZS
//  滑动tab page (懒加载)
//  Created by jysd on 15/1/13.
//  Copyright (c) 2015年 jysd. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XYPageContainerDelegate <NSObject>
- (void)XYPageContainerScrollViewDidEndDecelerating:(UIScrollView *)scrollView;
@end

@interface XYPageContainerItem : NSObject


@end
@interface XYPageContainer : UIView<UIScrollViewDelegate>

@property(nonatomic,strong)NSMutableDictionary *viewsDic;//储存view


@property(nonatomic,strong)UIScrollView *m_scrollView;
@property(nonatomic,strong)XYPageContainerItem *pageContainerItem;
@property(nonatomic,weak)id<XYPageContainerDelegate> delegate;

- (void)StartCreate;


- (void)loadViewFromPageContainerWithView:(UIViewController *)viewCtrl index:(NSInteger)selectindex totalPage:(NSInteger)totalPage;


@end




