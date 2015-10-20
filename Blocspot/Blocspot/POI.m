//
//  POI.m
//  Blocspot
//
//  Created by Casey Ward on 8/23/15.
//  Copyright (c) 2015 Casey Ward. All rights reserved.
//

#import "POI.h"
#import "BlocSpotCategory.h"

@implementation POI

-(instancetype) initWithAnnotation:(id <MKAnnotation>)mapItem{
    self.name = mapItem.title;
    //self.placeMark = mapItem.subtitle;
    self.latitude = mapItem.coordinate.latitude;
    self.longitude = mapItem.coordinate.longitude;
    return self;
}

#pragma mark - NSCoding

-(instancetype) initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    
    if (self) {
        
        self.name = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(name))];
        self.placeMark = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(placeMark))];
        self.latitude = [aDecoder decodeFloatForKey:NSStringFromSelector(@selector(latitude))];
        self.longitude = [aDecoder decodeFloatForKey:NSStringFromSelector(@selector(longitude))];
        self.wasFavorited = [aDecoder decodeBoolForKey:NSStringFromSelector(@selector(wasFavorited))];
        self.assignedCategory = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(assignedCategory))];
        self.poiNote = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(poiNote))];
        
//        self.assignedCategory.categoryColor = [self.assignedCategory convertStringToColor:self.assignedCategory.categoryColorString];
        
    }
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:NSStringFromSelector(@selector(name))];
    [aCoder encodeObject:self.placeMark forKey:NSStringFromSelector(@selector(placeMark))];
    [aCoder encodeFloat:self.latitude forKey:NSStringFromSelector(@selector(latitude))];
    [aCoder encodeFloat:self.longitude forKey:NSStringFromSelector(@selector(longitude))];
    [aCoder encodeBool: self.wasFavorited forKey:NSStringFromSelector(@selector(wasFavorited))];
    [aCoder encodeObject:self.assignedCategory forKey:NSStringFromSelector(@selector(assignedCategory))];
    [aCoder encodeObject:self.poiNote forKey:NSStringFromSelector(@selector(poiNote))];
}

- (void)addPOIToFavorites {
    [self createGeoRegionForNotification];//creating CLCircularRegion
    [[DataSource2 sharedInstance].poiFavorites addObject:self];
    [[DataSource2 sharedInstance] saveData];
}

- (void)addCategoryToPOI:(BlocSpotCategory *) someCategory {
    self.assignedCategory = someCategory;
}

- (void)createGeoRegionForNotification {
    NSLog(@"This create region stuff is being called.");
    CLLocationCoordinate2D coordinate2D = CLLocationCoordinate2DMake(self.latitude, self.longitude);
    CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:coordinate2D radius:50 identifier:self.name];
    self.region = region;
    
    UILocalNotification *enteredGeoRegionNotification = [[UILocalNotification alloc] init];
    enteredGeoRegionNotification.region = self.region;
    enteredGeoRegionNotification.alertBody = @"You're close to one of your favorite spots";
    enteredGeoRegionNotification.alertAction = @"Check it out in Blocspot";
    enteredGeoRegionNotification.alertTitle = @"Something cool nearby";
    enteredGeoRegionNotification.category = @"This is the category prop";
    
    //I wondered if this would have worked instead of calling the same methond within implementation of th location mgr
    [[UserLocation sharedLocationInstance].locationManager startMonitoringForRegion:self.region];
    
}



@end

