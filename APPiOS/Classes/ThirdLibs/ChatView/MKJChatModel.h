//
//  MKJChatModel.h
//  纯代码气泡聊天
//
//  Created by 宓珂璟 on 16/6/3.
//  Copyright © 2016年 宓珂璟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKJChatModel : NSObject
@property (nonatomic,copy) NSString *Id;
@property (nonatomic,copy) NSString *msg;
@property (nonatomic,assign) BOOL isRight;
@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *leftUserAvtar;
@property (nonatomic, copy) NSString *rightUserAvtar;


@end
