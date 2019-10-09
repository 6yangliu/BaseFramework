//
//  OrderDesTool.h
//  APPiOS
//
//  Created by ly on 2019/3/16.
//  Copyright © 2019年 shengxi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderSchemo.h"
@interface OrderDesTool : NSObject

+(NSString *)getOrderStateDisplayName:(OrderState)state;

+(NSString *)getOrderProcessType:(NSString *)process_id;

+(void)getMapWithLatitude:(float)latitude longitude:(float)longitude locationName:(NSString *)locationName;
@end
