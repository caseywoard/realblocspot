//
//  SpotMapViewController.h
//  Blocspot
//
//  Created by Casey Ward on 8/9/15.
//  Copyright (c) 2015 Casey Ward. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface BlocspotMapViewController : UIViewController

@property (nonatomic, strong) NSArray *searchResults;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
