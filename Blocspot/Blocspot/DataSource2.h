//
//  DataSource2.h
//  Blocspot
//
//  Created by Casey Ward on 8/30/15.
//  Copyright (c) 2015 Casey Ward. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "POI.h"
#import "BlocSpotCategory.h"

//#import "AFNetworking.h"

@interface DataSource2 : NSObject

+ (instancetype) sharedInstance;

@property (nonatomic, strong) NSMutableArray *poiFavorites; //objects of class POI
@property (nonatomic, strong) NSMutableArray *categories; //objects of class Category
@property (nonatomic, strong) NSMutableArray *defaultCategories;
@property (nonatomic, strong) NSMutableArray *categoryStrings;
//methods:

- (void) saveData;


@end