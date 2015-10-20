//
//  UserLocation.m
//  Blocspot
//
//  Created by Casey Ward on 8/9/15.
//  Copyright (c) 2015 Casey Ward. All rights reserved.
//

#import "UserLocation.h"


@interface UserLocation ()



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
        
        [self startStandardUpdates];
//        [self startSignificantChangeUpdates];
        
        
    }
    return self;
}

- (void)startStandardUpdates { //this was missing. jsut added it back.
   
    self.locationManager = [[CLLocationManager alloc] init];
  
    self.locationManager.delegate = self;
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    
    // Set a movement threshold for new events.
    
    self.locationManager.distanceFilter = 500;
    self.locationManager.pausesLocationUpdatesAutomatically = YES;
    self.locationManager.activityType = CLActivityTypeOther;
    
    [self.locationManager startUpdatingLocation];

    
}





//when is this method called?
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    //self.lastLocation = locations[0];
    self.lastLocation = locations.lastObject;
    
    
 
}

-(void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSString *errorMsg = @"Error obtaining location";
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {

    // Check status to see if the app is authorized
    
    BOOL canUseLocationNotifications = (status == kCLAuthorizationStatusAuthorizedWhenInUse);
    
    if (canUseLocationNotifications) {
        
       // [self startShowingLocationNotifications]; // Custom method defined below
        
    }
    
}



@end











