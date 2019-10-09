//
//  UserModel.m
//  MeiXiang
//
//  Created by Krisc.Zampono on 16/6/15.
//  Copyright © 2016年 Krisc.Zampono. All rights reserved.
//

#import "TeamModel.h"

@implementation TeamModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"service_type" : @"ServiceTypeModel",@"service_city" : @"ServiceCityModel",@"cars" : @"CarsModel",@"warehouses" : @"WarehousesModel"};//前边，是属性数组的名字，后边就是类名
}
@end
