//
//  SearchViewController.h
//  Blocspot
//
//  Created by Casey Ward on 8/12/15.
//  Copyright (c) 2015 Casey Ward. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;

@interface SearchViewController : UIViewController <UISearchBarDelegate>

@property (nonatomic, strong) NSArray *searchResults;
@property (nonatomic, strong) MKLocalSearchRequest *request;
@end
