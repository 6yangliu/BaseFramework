//
//  ElectricianCerModel.h
//  MeiXiang
//  配备的车辆信息
//  Created by Krisc.Zampono on 16/6/15.
//  Copyright © 2016年 Krisc.Zampono. All rights reserved.
//

@interface CarsModel : BaseModel

@property (nonatomic, assign)   long long Id;//车辆id
@property (nonatomic, assign)   long long team_id;//所属服务商id
@property (nonatomic, assign)   long long type;//车辆类型
@property (nonatomic, copy)   NSString *number;//车牌号

@property (nonatomic, copy)   NSString *carName;//自定义

@end
