//
//  DataSource.h
//  Blocspot
//
//  Created by Casey Ward on 8/23/15.
//  Copyright (c) 2015 Casey Ward. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "POI.h"
#import "BlocSpotCategory.h"

//#import "AFNetworking.h"

@interface DataSource : NSObject

+ (instancetype) sharedInstance;

@property (nonatomic, strong) NSMutableArray *poiFavorites; //objects of class POI
@property (nonatomic, strong) NSMutableArray *categories; //objects of class Category

//methods:

- (void) saveData:(MKMapItem *)POI;

//create a new category
//-(BlocSpotCategory) createCategory: (NSString *) submittedCategory;
//get all points of interest
//get categories
//assign category to point of interest

@end
