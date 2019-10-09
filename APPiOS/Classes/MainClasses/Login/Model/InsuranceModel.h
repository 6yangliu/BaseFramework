//
//  UserModel.h
//  MeiXiang
//  保单信息
//  Created by Krisc.Zampono on 16/6/15.
//  Copyright © 2016年 Krisc.Zampono. All rights reserved.
//


@interface InsuranceModel : BaseModel
@property (nonatomic, copy)   NSString *image;//保单照
@property (nonatomic, copy)   NSString *expire_start;//保单生效日期
@property (nonatomic, copy)   NSString *expire_end;//保单失效日期
@property (nonatomic, copy)   NSString *safe_fee;//保单金额（单位：万元）
@end
