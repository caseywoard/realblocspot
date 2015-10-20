//
//  SpotMapViewController.h
//  Blocspot
//
//  Created by Casey Ward on 8/9/15.
//  Copyright (c) 2015 Casey Ward. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserLocation.h"
#import "BlocSpotCategory.h"
#import "POI.h"
#import "DataSource2.h"
#import "AddCategoryModalViewController.h"
#import "BlocspotListTableViewController.h"

@interface BlocspotMapViewController : UIViewController //<addCategoryDelegate>

@property (strong, nonatomic) NSArray *pointAnnotationsArray;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (assign, nonatomic) MKAnnotationView *annotationView;
@property (nonatomic, strong) id <MKAnnotation> selectedAnnotation;
@property (nonatomic, strong) POI *poiWithAssignedCategory;//poaaibly don't need this

@property (nonatomic, strong) POI *selectedPOIFavorite;//new stuff 10/6
@property (nonatomic, strong) BlocSpotCategory *assignedCategory;

@property (nonatomic, assign) CLLocationCoordinate2D *userCoordinate;

@end
