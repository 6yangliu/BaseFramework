//
//  OrderSchemo.h
//  APPiOS
//
//  Created by ly on 2019/3/16.
//  Copyright © 2019年 shengxi. All rights reserved.
//

#ifndef OrderSchemo_h
#define OrderSchemo_h


typedef NS_ENUM(NSUInteger, OrderState) {
    
    ORDER_WAITING_RECEIVER=102,//订单已分配 等待接收
    ORDER_WAITING_CONTACT_STORE=103,//订单已接收 等待联系门店
    ORDER_NOT_PASSED=104,//审核不通过
    ORDER_WAITING_CONTACT_DEPARTURE=105,//门店已联系 工程师已联系门店等待出发
    
    ORDER_DEPARTED=106,//工程师已出发
    ORDER_CONSTRUCTION=107,//工程师已到店 并开始施工
    ORDER_LEAVED_STORE=108,//工程师已离店 施工已结束
    ORDER_WAITING_REVIEW=109,//已申请订单完成 等待审核
    
    ORDER_FINISHED=110,//订单已完成
    ORDER_GENERATING_COST=111,//订单已评价 正在生产全部费用
    ORDER_COST_GENERATED=112,//订单费用已生成
};

//订单类型

//第一类 OrderDesOneController 维修详情页
#define WEIYI_CHACHECHANG @"G"
#define WEI_XIU @"H"
#define TI_SONG_HUO @"I"
#define CANG_CHU @"J"

//第二类 OrderDesTwoController 培训指导详情页
#define PEIXUN_ZHIDAO_HUODONG @"F"

//第三类 OrderDesThreeController 测量详情页
#define CE_LIANG @"A"

//第四类 OrderDesFourController 安装详情页
#define AN_ZhUANG @"D"

//流程分两类
//1:安装类订单操作(a)测量、安装、维修、移位\拆撤场、提送货、仓储（接单-预约-出发-到店-作业中-待验收、验收通过|不通过）)
//2:监理类订单操作(b) 培训\指导\活动（接单-作业中-待验收-验收通过|不通过）)
#define OrderProcess_A @"a"

#define OrderProcess_B @"b"





#endif /* OrderSchemo_h */
