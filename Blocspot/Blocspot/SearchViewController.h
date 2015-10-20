//
//  SearchViewController.h
//  Blocspot
//
//  Created by Casey Ward on 8/12/15.
//  Copyright (c) 2015 Casey Ward. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserLocation.h"
#import "DataSource2.h"
#import "BlocSpotCategory.h"
#import "FilterByCategoryViewController.h"

@interface SearchViewController : UIViewController <UISearchBarDelegate, UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *searchResults;
@property (nonatomic, strong) MKLocalSearchRequest *request;
@property (nonatomic, strong) NSMutableArray *categories;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) BOOL categoryListViewChosen;
@property (nonatomic, strong) POI *selectedFavoritePOI;

@end
