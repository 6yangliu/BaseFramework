//
//  HKADPageControl.m
//  APPiOS
//
//  Created by liuy on 2018/11/22.
//  Copyright © 2018 shengxi. All rights reserved.
//

#import "HKADPageControl.h"

@implementation HKADPageControl


//重写setCurrentPage方法，可设置圆点大小
- (void) setCurrentPage:(NSInteger)page {
    [super setCurrentPage:page];
    
    for (NSUInteger subviewIndex = 0; subviewIndex < [self.subviews count]; subviewIndex++) {
        UIImageView* subview = [self.subviews objectAtIndex:subviewIndex];
        CGSize size;
        size.height = 3;
        size.width = 10;
        subview.layer.cornerRadius=1.5;
        [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y,
                                     size.width,size.height)];
    }
}

@end
