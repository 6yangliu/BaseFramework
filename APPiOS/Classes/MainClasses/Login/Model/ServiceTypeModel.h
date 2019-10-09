//
//  ElectricianCerModel.h
//  MeiXiang
//  服务能力
//  Created by Krisc.Zampono on 16/6/15.
//  Copyright © 2016年 Krisc.Zampono. All rights reserved.
//


@interface ServiceTypeModel : BaseModel

@property (nonatomic, copy)   NSString *Id;//一级服务能力id
@property (nonatomic, copy)   NSString *name;//一级服务能力名称
@property (nonatomic, copy)   NSArray<ServiceTypeModel *> *children;//二级服务能力

@end
