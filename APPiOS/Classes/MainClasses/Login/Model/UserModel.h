//
//  UserModel.h
//  MeiXiang
//
//  Created by Krisc.Zampono on 16/6/15.
//  Copyright © 2016年 Krisc.Zampono. All rights reserved.
//

#import "BaseModel.h"
#import "IdCardModel.h"
#import "InsuranceModel.h"
#import "ElectricianCerModel.h"
#import "SkillsModel.h"
#import "ServiceTypeModel.h"
#import "ServiceCityModel.h"
#import "TeamModel.h"
#import "CarsModel.h"
#import "WarehousesModel.h"

@interface UserModel : BaseModel

@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, assign) NSInteger is_legal;//是否是法人 允许值: 1为法人
@property (nonatomic, assign) NSInteger is_leader;//是否是负责人 允许值: 1为负责人, 2为普通成员
@property (nonatomic, copy)   NSString *realname;
@property (nonatomic, copy)   NSString *mobile;
@property (nonatomic, copy)   NSString *email;
@property (nonatomic, copy)   NSString *avatar;
@property (nonatomic, assign) NSInteger is_receive;//是否接单 允许值: 1是, 0否
@property (nonatomic, copy)   NSString *census;//户籍地
@property (nonatomic, copy)   NSString *service_star;//星级
@property (nonatomic, assign) NSInteger status;//状态（忽略）
@property (nonatomic, assign) NSInteger auth_status;//认证状态 允许值: 0未认证, 1认证中, 2已认证, 3认证失败
@property (nonatomic, copy)   NSString *join_team_time;//加入服务商时间
@property (nonatomic, strong) IdCardModel *id_card;//实名认证信息
@property (nonatomic, strong) InsuranceModel *insurance;//保单信息
@property (nonatomic, strong) ElectricianCerModel *electrician_certifi;//成员电工证信息
@property (nonatomic, strong) NSArray<SkillsModel*> *skills;//成员技能信息
@property (nonatomic, strong) NSArray<ServiceTypeModel *> *service_type;//服务能力
@property (nonatomic, strong) NSArray<ServiceCityModel *> *service_city;//服务区域
@property (nonatomic, strong) TeamModel *team;//所属服务商信息

@end
