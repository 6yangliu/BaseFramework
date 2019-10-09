//
//  ElectricianCerModel.h
//  MeiXiang
//  配备的仓库信息
//  Created by Krisc.Zampono on 16/6/15.
//  Copyright © 2016年 Krisc.Zampono. All rights reserved.
//

@interface WarehousesModel : BaseModel

@property (nonatomic, assign)   long long Id;//仓库id
@property (nonatomic, assign)   long long team_id;//所属服务商id
@property (nonatomic, copy)   NSString *area;//仓库面积
@property (nonatomic, copy)   NSString *address;//仓库地址
//自定义
@property (nonatomic, copy)   NSString *name;//仓库简称

@end
