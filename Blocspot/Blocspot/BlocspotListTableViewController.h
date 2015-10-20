//
//  SpotListTableViewController.h
//  Blocspot
//
//  Created by Casey Ward on 8/9/15.
//  Copyright (c) 2015 Casey Ward. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserLocation.h"
#import "DataSource2.h"
#import "POI.h"


@import MapKit;

@interface BlocspotListTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *searchResults;
//@property (nonatomic, strong) MKMapView *tempMap;

@end
