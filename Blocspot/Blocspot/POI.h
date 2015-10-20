//
//  POI.h
//  Blocspot
//
//  Created by Casey Ward on 8/23/15.
//  Copyright (c) 2015 Casey Ward. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserLocation.h"
#import "DataSource2.h"
@class BlocSpotCategory;


@interface POI : NSObject <NSCoding, CLLocationManagerDelegate>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *placeMark;
@property (nonatomic, assign) CGFloat latitude;
@property (nonatomic, assign) CGFloat longitude;
@property (nonatomic, assign) bool wasFavorited;
@property (nonatomic, strong) BlocSpotCategory *assignedCategory;
@property (nonatomic, strong) NSString *assignedCategoryString;
@property (nonatomic, strong) NSString *poiNote;
@property (nonatomic, strong) CLCircularRegion *region;

- (instancetype) initWithAnnotation: (id <MKAnnotation>)  mapItem;
- (void) addPOIToFavorites;
- (void)createGeoRegionForNotification;

- (void) addCategoryToPOI:(BlocSpotCategory *) someCategory;


@end
