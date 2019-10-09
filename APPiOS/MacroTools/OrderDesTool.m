//
//  OrderDesTool.m
//  APPiOS
//
//  Created by ly on 2019/3/16.
//  Copyright © 2019年 shengxi. All rights reserved.
//

#import "OrderDesTool.h"
#import <MapKit/MapKit.h>
@implementation OrderDesTool

+(NSString *)getOrderStateDisplayName:(OrderState)state{
    NSString *displayName=@"";
    switch (state) {
        case ORDER_WAITING_RECEIVER:
            displayName=@"待接单";
            break;
        case ORDER_WAITING_CONTACT_STORE:
            displayName=@"联系门店";
            break;
        case ORDER_NOT_PASSED:
            displayName=@"验收不通过";
            break;
        case ORDER_WAITING_CONTACT_DEPARTURE:
            displayName=@"等待出发";
            break;
        case ORDER_DEPARTED:
            displayName=@"已出发";
            break;
        case ORDER_CONSTRUCTION:
            displayName=@"作业中";
            break;
        case ORDER_LEAVED_STORE:
            displayName=@"已离店";
            break;
        case ORDER_WAITING_REVIEW:
            displayName=@"待验收";
            break;
        case ORDER_FINISHED:
            displayName=@"待评价";
            break;
        case ORDER_GENERATING_COST:
            displayName=@"正在生产全部费用";
            break;
        case ORDER_COST_GENERATED:
            displayName=@"费用已生成";
            break;
        default:
            break;
    }
    return displayName;
}
+(NSString *)getOrderProcessType:(NSString *)process_id{
   
    if([process_id isEqualToString:WEIYI_CHACHECHANG]||[process_id isEqualToString:WEI_XIU]||[process_id isEqualToString:TI_SONG_HUO]||[process_id isEqualToString:CANG_CHU]||[process_id isEqualToString:CE_LIANG]||[process_id isEqualToString:AN_ZhUANG]){
        return OrderProcess_A;
    }
    
    if([process_id isEqualToString:PEIXUN_ZHIDAO_HUODONG]){
        return OrderProcess_B;
    }
    
    return @"";
    
}
+(void)getMapWithLatitude:(float)latitude longitude:(float)longitude locationName:(NSString *)locationName{
    MKMapItem *mylocation = [MKMapItem mapItemForCurrentLocation];
    //当前经维度
    float currentLatitude=mylocation.placemark.location.coordinate.latitude;
    float currentLongitude=mylocation.placemark.location.coordinate.longitude;
    
    CLLocationCoordinate2D coords1 = CLLocationCoordinate2DMake(currentLatitude,currentLongitude);
    
    
    CLLocationCoordinate2D coords2 = CLLocationCoordinate2DMake(latitude,longitude);
    
    // ios6以下，调用google map
    if (SYSTEM_VERSION_LESS_THAN(@"6.0"))
    {
        NSString *urlString = [[NSString alloc] initWithFormat:@"http://maps.google.com/maps?saddr=%f,%f&daddr=%f,%f&dirfl=d", coords1.latitude,coords1.longitude,coords2.latitude,coords2.longitude];
        NSURL *aURL = [NSURL URLWithString:urlString];
        //打开网页google地图
        [[UIApplication sharedApplication] openURL:aURL];
    }
    else
        // 直接调用ios自己带的apple map
    {
        //当前的位置
        MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
        //起点
        //MKMapItem *currentLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coords1 addressDictionary:nil]];
        //目的地的位置
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coords2 addressDictionary:nil]];
        
        toLocation.name = @"目的地";
        NSString *myname=locationName;
        toLocation.name =myname;
        NSArray *items = [NSArray arrayWithObjects:currentLocation, toLocation, nil];
        NSDictionary *options = @{ MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving, MKLaunchOptionsMapTypeKey: [NSNumber numberWithInteger:MKMapTypeStandard], MKLaunchOptionsShowsTrafficKey:@YES };
        //打开苹果自身地图应用，并呈现特定的item
        [MKMapItem openMapsWithItems:items launchOptions:options];
    }
    
}


@end
