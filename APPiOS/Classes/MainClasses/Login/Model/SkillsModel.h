//
//  ElectricianCerModel.h
//  MeiXiang
//  技能信息
//  Created by Krisc.Zampono on 16/6/15.
//  Copyright © 2016年 Krisc.Zampono. All rights reserved.
//


@interface SkillsModel : BaseModel

@property (nonatomic, copy)   NSString *Id;//技能id
@property (nonatomic, copy)   NSString *name;//技能名称
@property (nonatomic, copy)   NSString *photo_front;//技能照片1
@property (nonatomic, copy)   NSString *photo_reverse;//技能照片2
@property (nonatomic, copy)   NSString *dateline;//技能创建时间

@end
