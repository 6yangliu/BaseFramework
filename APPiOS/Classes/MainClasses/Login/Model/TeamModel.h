//
//  ElectricianCerModel.h
//  MeiXiang
//  所属服务商信息
//  Created by Krisc.Zampono on 16/6/15.
//  Copyright © 2016年 Krisc.Zampono. All rights reserved.
//

#import "ServiceTypeModel.h"
#import "ServiceCityModel.h"
#import "CarsModel.h"
#import "WarehousesModel.h"
@interface TeamModel : BaseModel

@property (nonatomic, assign)   long long d;//服务商id
@property (nonatomic, copy)   NSString *name;//服务商名称

@property (nonatomic, copy)   NSString *type;//服务商类型 允许值: admin为高级服务商团队, normal为普通服务商

@property (nonatomic, copy)   NSString *company_name;//公司名称

@property (nonatomic, copy)   NSString *company_nature;//公司性质

@property (nonatomic, copy)   NSString *company_leader;//公司负责人名称

@property (nonatomic, copy)   NSString *business_license;//公司营业执照

@property (nonatomic, copy)   NSString *idcard_front;//法人身份证-正面照

@property (nonatomic, copy)   NSString *idcard_reverse;//法人身份证-反面照

@property (nonatomic, copy)   NSString *legal_realname;//法人名称

@property (nonatomic, copy)   NSString *account;//对公账号

@property (nonatomic, copy)   NSString *bank_name;//银行名称

@property (nonatomic, copy)   NSString *branch_name;//支行名称

@property (nonatomic, copy)   NSString *account_owner;//开户人名称

@property (nonatomic, assign)   NSInteger status;//服务商状态 允许值: 0为待认证, 1为已认证, 2为已停用, 3认证不通过

@property (nonatomic, copy)   NSString *not_pass_why;//服务认证不同原因

@property (nonatomic, copy)   NSArray<ServiceTypeModel *> *service_type;//服务能力

@property (nonatomic, copy)   NSArray<ServiceCityModel *> *service_city;//服务地区

@property (nonatomic, copy)   NSArray<CarsModel *> *cars;//配备的车辆信息

@property (nonatomic, copy)   NSArray<WarehousesModel *> *warehouses;//配备的仓库信息

@end
