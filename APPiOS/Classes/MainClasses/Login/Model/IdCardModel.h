//
//  UserModel.h
//  MeiXiang
//  实名认证信息
//  Created by Krisc.Zampono on 16/6/15.
//  Copyright © 2016年 Krisc.Zampono. All rights reserved.
//


@interface IdCardModel : BaseModel

@property (nonatomic, copy) NSString *number;//身份证号
@property (nonatomic, copy)   NSString *realname;
@property (nonatomic, copy)   NSString *front;//身份证-正面照
@property (nonatomic, copy)   NSString *reverse;//身份证-反面照
@property (nonatomic, copy)   NSString *not_pass_why;//认证不通过原因
@end
