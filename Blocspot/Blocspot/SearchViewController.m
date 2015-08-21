//
//  SearchViewController.m
//  Blocspot
//
//  Created by Casey Ward on 8/12/15.
//  Copyright (c) 2015 Casey Ward. All rights reserved.
//

#import "SearchViewController.h"
#import "UserLocation.h"
#import "BlocspotListTableViewController.h"

@interface SearchViewController () <UISearchBarDelegate>

@property (nonatomic,strong) IBOutlet UISearchBar *searchBar;

@end


@implementation SearchViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.searchBar.delegate = self;
    
    //[[self mapView] setShowsUserLocation:YES];
    
    //[UserLocation sharedLocationInstance].locationManager = [[CLLocationManager alloc] init];
    
    //[[UserLocation sharedLocationInstance].locationManager setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [self.searchBar resignFirstResponder];
    
    //MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    self.request = [[MKLocalSearchRequest alloc] init];
    self.request.naturalLanguageQuery = self.searchBar.text;
    
    self.request.region = MKCoordinateRegionMakeWithDistance([UserLocation sharedLocationInstance].locationManager.location.coordinate, 100, 100); //should understand what paramter to pass here.
    
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:self.request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        
        NSLog(@"Map Items: %@", response.mapItems);
        self.searchResults = response.mapItems;
        [self performSegueWithIdentifier:@"SearchMade" sender:self.searchBar];
       
    }];
    
    
}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"SearchMade"]){
        BlocspotListTableViewController *destinationTVC = segue.destinationViewController;
        destinationTVC.searchResults = self.searchResults;
        destinationTVC.tempMap.region = self.request.region;
        NSLog(@"segue worked!!!!");
       
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
