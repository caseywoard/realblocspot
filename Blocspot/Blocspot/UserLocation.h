//
//  UserLocation.h
//  Blocspot
//
//  Created by Casey Ward on 8/9/15.
//  Copyright (c) 2015 Casey Ward. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "DataSource2.h"

@interface UserLocation : NSObject <CLLocationManagerDelegate>

+ (instancetype) sharedLocationInstance;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic) CLLocation *lastLocation;

//- (void)startShowingNotifications;

@end
