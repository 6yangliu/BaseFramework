//
//  YBAreaPickerView.h
//  XHGY_Agent
//
//  Created by 尚往文化 on 17/6/9.
//  Copyright © 2017年 YBing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^YBPickerDidSelectBlock)(NSIndexPath *indexPath);

@interface YBPickerTool : UIPickerView

+ (void)show:(NSArray<NSArray<NSString *> *> *)datas didSelectBlock:(YBPickerDidSelectBlock)didSelectBlock;

@end
