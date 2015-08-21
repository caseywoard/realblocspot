//
//  UserLocation.m
//  Blocspot
//
//  Created by Casey Ward on 8/9/15.
//  Copyright (c) 2015 Casey Ward. All rights reserved.
//

#import "UserLocation.h"


@interface UserLocation () <CLLocationManagerDelegate>



@end

@implementation UserLocation

+(instancetype) sharedLocationInstance {
    static dispatch_once_t once;
    static id sharedLocationInstance;
    dispatch_once(&once, ^{
        sharedLocationInstance = [[UserLocation alloc] init];
    });
    
    return sharedLocationInstance;
}

- (instancetype) init {
    self = [super init];
    
    if (self) {
        //getting permission to access location
        
        
        //[[self mapView] setShowsUserLocation:YES];
        
        [self startStandardUpdates];
        [self startSignificantChangeUpdates];
        
    }
    return self;
}

- (void)startStandardUpdates {
    
    // Create the location manager if this object does not
    if (nil == self.locationManager) {
        self.locationManager = [[CLLocationManager alloc] init];
        [self.locationManager requestWhenInUseAuthorization]; //use when locationmanger is made
    }
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    self.locationManager.distanceFilter = 500; // meters
    if([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
         //Or [self.locationManager requestWhenInUseAuthorization];
    }
    
    [self.locationManager startUpdatingLocation];
    
}

- (void)startSignificantChangeUpdates

{
    
    // Create the location manager if this object does not
    // already have one.
    
    if (nil == self.locationManager) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        [self.locationManager startMonitoringSignificantLocationChanges];
    }
}

//when is this method called?
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    //self.lastLocation = locations[0];
    self.lastLocation = locations.lastObject;
}



@end











