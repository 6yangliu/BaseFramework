//
//  YBAreaPickerView.h
//  XHGY_Agent
//  二级联动
//  Created by 尚往文化 on 17/6/9.
//  Copyright © 2017年 YBing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^YBPickerDidSelectBlock)(NSDictionary *data);

@interface YBPickerTool : UIPickerView

+ (void)show:(NSArray<NSArray<NSString *> *> *)datas didSelectBlock:(YBPickerDidSelectBlock)didSelectBlock;

@end
