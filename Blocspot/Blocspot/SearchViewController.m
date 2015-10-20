//
//  SearchViewController.m
//  Blocspot
//
//  Created by Casey Ward on 8/12/15.
//  Copyright (c) 2015 Casey Ward. All rights reserved.
//

#import "SearchViewController.h"

#import "BlocspotListTableViewController.h"
#import "BlocspotMapViewController.h"

@import CoreLocation;
@import MapKit;

@interface SearchViewController () <UISearchBarDelegate, UITextFieldDelegate>

@property (nonatomic,strong) IBOutlet UISearchBar *searchBar;
@property (nonatomic,strong) NSString *selectedTableViewCellString;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UIBarButtonItem *addCategoryBtn;
@property (nonatomic, strong) UIBarButtonItem *filterByCategoryBtn;
@property (nonatomic, strong) NSArray *filteredPOIs;

@property (nonatomic, assign) BOOL categoryFilterSet;

//- (void) filterByCategoryBtnPressed;e

@end


@implementation SearchViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.categories = [DataSource2 sharedInstance].categories;
    
    [self.tableView reloadData];

    

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //test my BOOL value
    NSLog(@"Value of BOOL property is: %d", self.categoryFilterSet);
    
    self.filteredPOIs = [DataSource2 sharedInstance].poiFavorites;
    if (self.searchBar.text == nil){
        
        self.categoryFilterSet = NO;
        self.filteredPOIs = [DataSource2 sharedInstance].poiFavorites;
        [self.tableView reloadData];
        NSLog(@"My text view is clear and I should be reloading tableview");
    }
    
    [UserLocation sharedLocationInstance];
    
    
    
    //2self.filteredPOIs = [DataSource2 sharedInstance].poiFavorites;
    
    UIColor *colorTheme = [UIColor colorWithRed:52.0/255.0 green:73.0/255.0 blue:94.0/255.0 alpha:1.0f];
    //setting up searchBar
    self.searchBar.barTintColor = colorTheme;
    self.searchBar.layer.borderColor = colorTheme.CGColor;
    self.searchBar.layer.borderWidth = 1;
    self.searchBar.delegate = self;//making delegate of [blank] protocols
    
    self.segmentedControl.backgroundColor = colorTheme;
    self.segmentedControl.tintColor = [UIColor whiteColor];
    
    self.view.backgroundColor = colorTheme;
    
    //bar button items...
    self.addCategoryBtn = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCategoryBtnPressed)];
    
    UIImage *btnImage = [UIImage imageNamed:@"Filter-50-2.png"];
    
    self.filterByCategoryBtn.width = 10;
    self.filterByCategoryBtn = [[UIBarButtonItem alloc] initWithImage:btnImage style:UIBarButtonItemStylePlain target:self action:@selector(filterByCategoryBtnPressed)];

    
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        self.navigationItem.rightBarButtonItem = self.addCategoryBtn;
    } else if (self.segmentedControl.selectedSegmentIndex == 1) {
        self.navigationItem.rightBarButtonItem = self.filterByCategoryBtn;

    }
    
  

//    [[DataSource2 sharedInstance] saveData];
}


- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"searchBar:textDidChange was called");
    if (self.categoryFilterSet == 1) {
        self.categoryFilterSet = 0;
        self.filteredPOIs = [DataSource2 sharedInstance].poiFavorites;
        [self.searchBar resignFirstResponder];
        [self.tableView reloadData];
        NSLog(@"searchBar:TextDidChange and now self.category equals: %d", self.categoryFilterSet);

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (IBAction)segmentedControlDidChange:(id)sender {
    [self.tableView reloadData];
    [self.searchBar resignFirstResponder];
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        self.navigationItem.rightBarButtonItem = self.addCategoryBtn;
    } else if (self.segmentedControl.selectedSegmentIndex == 1) {
        NSLog(@"barbuttonitem should change");
        self.navigationItem.rightBarButtonItem = self.filterByCategoryBtn;

    }
   

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [self.searchBar resignFirstResponder];
    
    //MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    self.request = [[MKLocalSearchRequest alloc] init];
    self.request.naturalLanguageQuery = self.searchBar.text;
    
    self.request.region = MKCoordinateRegionMakeWithDistance([UserLocation sharedLocationInstance].locationManager.location.coordinate, 1000, 1000); //should understand what paramter to pass here.
    
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:self.request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        
        //dsNSLog(@"Map Items: %@", response.mapItems);
        self.searchResults = response.mapItems;
        [self performSegueWithIdentifier:@"SearchMade" sender:self.searchBar];
       
    }];
}

- (void)searchForCategory {
    self.request = [[MKLocalSearchRequest alloc] init];
    if (self.selectedTableViewCellString != nil) {
        self.request.naturalLanguageQuery = self.selectedTableViewCellString;
    }
    
    self.request.region = MKCoordinateRegionMakeWithDistance([UserLocation sharedLocationInstance].locationManager.location.coordinate, 1000, 1000); //should understand what paramter to pass here.
    
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:self.request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        
    self.searchResults = response.mapItems;
    [self performSegueWithIdentifier:@"SearchMade" sender:nil];
        
    }];
}

- (void) clearFilterBtnPressed {
    self.filteredPOIs = [DataSource2 sharedInstance].poiFavorites;
    self.categoryFilterSet = 0;
    self.searchBar.text = nil;
     NSLog(@"Clear btn pressed. self.category equals: %d", self.categoryFilterSet);
    [self viewWillAppear:YES];
    [self.tableView reloadData];
}

- (void) poiFavoriteSelected {
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"searchForFavoriteSegue"]){
        if ([segue.destinationViewController isKindOfClass:[BlocspotMapViewController class]]) {
            
            //create array of pointAnnotations that will be used for populating resutls in tablevView and eventually the map
           
            NSMutableArray *pointAnnotationsArray = [[NSMutableArray alloc] init];
            MKPointAnnotation *pointAnnotation = [[MKPointAnnotation alloc] init];
            pointAnnotation.coordinate = CLLocationCoordinate2DMake(self.selectedFavoritePOI.latitude, self.selectedFavoritePOI.longitude);
            pointAnnotation.title = self.selectedFavoritePOI.name;
            [pointAnnotationsArray addObject:pointAnnotation];
            
            BlocspotMapViewController *mapMVC = (BlocspotMapViewController *)segue.destinationViewController;
            mapMVC.pointAnnotationsArray = pointAnnotationsArray;
            
            //and pass single POI in addition
            
            mapMVC.selectedPOIFavorite = self.selectedFavoritePOI;
        }
    } else if ([segue.identifier isEqualToString:@"SearchMade"]){
        if ([segue.destinationViewController isKindOfClass:[BlocspotListTableViewController class]]) {
            BlocspotListTableViewController *destinationTVC = segue.destinationViewController;
            destinationTVC.searchResults = self.searchResults;
            //destinationTVC.tempMap.region = self.request.region;
            
        }
    }
        else if ([segue.identifier isEqualToString:@"filterByCategorySegue"]) {
            
            FilterByCategoryViewController *filterByCategoryVC = segue.destinationViewController;
            NSMutableArray *tempArray = [NSMutableArray new];
            for (POI *poi in [DataSource2 sharedInstance].poiFavorites) {
                [tempArray addObject:poi.assignedCategory];
            }
            filterByCategoryVC.categories = tempArray;
            
            //filterByCategoryVC.categories = [DataSource2 sharedInstance].categories;
            filterByCategoryVC.categoryFilterWasChosen = ^(BlocSpotCategory *chosenCategoryForFilter) {
                NSString *predicateString = [chosenCategoryForFilter.categoryName stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"];
//                NSPredicate *categoryPredicate = [NSPredicate predicateWithFormat:@"assignedCategory.categoryName CONTAINS[c] '%@'",predicateString];
                NSLog(@"Predicate string = %@", predicateString);
//                self.filteredPOIs = [[DataSource2 sharedInstance].poiFavorites filteredArrayUsingPredicate:categoryPredicate];
                
                NSMutableArray *filteredPOIs = [NSMutableArray array];
                for (POI *poi in [DataSource2 sharedInstance].poiFavorites) {
                    if ([poi.assignedCategory.categoryName containsString:predicateString]) {
                        [filteredPOIs addObject:poi];
                    }
                }
                self.filteredPOIs = filteredPOIs;
                
                //and finally set BOOL property to YES.
                self.categoryFilterSet = YES;
                NSLog(@"category filter chosen. self.category equals: %d", self.categoryFilterSet);
                self.searchBar.text = chosenCategoryForFilter.categoryName;
                
                [self.tableView reloadData];
                
                
            };
    }
        else if ([segue.identifier isEqualToString:@"addACategorySegue"]) {
            //AddCategoryModalViewController *addCategoryVC = segue.destinationViewController;
            NSLog(@"my new add category segue works!");
        }
}

//NSPredicate *predicate = [NSPredicate predicateWithFormat:@"department.name like %@", departmentName];


- (void) filterByCategoryBtnPressed {
    [self performSegueWithIdentifier:@"filterByCategorySegue" sender:self.filterByCategoryBtn];
    
}

- (void) addCategoryBtnPressed {
    [self performSegueWithIdentifier:@"addACategorySegue" sender:self.addCategoryBtn];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        return [self.categories count];
    } else if (self.segmentedControl.selectedSegmentIndex == 1) {
        if ([self.filteredPOIs count] > 0) {
            return [self.filteredPOIs count];
        }
    }
    
    UIAlertView *noFavoritesAlert = [[UIAlertView alloc] initWithTitle:@"No Favorties"
                                                               message:@"You don't have any saved favorites yet."
                                                              delegate:self
                                                     cancelButtonTitle:@"OK"
                                                     otherButtonTitles:nil];
    [noFavoritesAlert show];
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.searchBar resignFirstResponder];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        self.selectedTableViewCellString = nil;
        self.selectedTableViewCellString = cell.textLabel.text;
        [self searchForCategory];
        
    } else if (self.segmentedControl.selectedSegmentIndex == 1) {
        self.selectedFavoritePOI = self.filteredPOIs[indexPath.row];
        [self performSegueWithIdentifier:@"searchForFavoriteSegue" sender:nil];
    }
    
    return cell;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.editing = YES;
    //my attempt to set cell style to have subtitle
    if (cell == nil) {
        //NSLog(@"this black about cell style is being called.");
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    } else {
        //NSLog(@"this black about cell style is NOT being called.");
    }
    
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        if ([[DataSource2 sharedInstance].categories count] > 0) {
            BlocSpotCategory *categories = [DataSource2 sharedInstance].categories[indexPath.row];
            cell.textLabel.text = categories.categoryName;
            cell.backgroundColor = categories.categoryColor;
            //NSLog(@"Your fast enumeration block is being called to set UIColors to cells...");

        } else {
            cell.textLabel.text = @"";
            cell.backgroundColor = [UIColor whiteColor];
            NSLog(@"somethings wrong. default categories aren't being called");
        }
        
        
    } else if (self.segmentedControl.selectedSegmentIndex == 1) {
        
        if ([self.filteredPOIs count] > 0) {
            POI *pois = self.filteredPOIs[indexPath.row];
            cell.textLabel.text = pois.name;
            cell.backgroundColor = [UIColor whiteColor];
//            if (pois.assignedCategory.categoryName != nil) {
//                NSLog(@"assigned category name = %@",pois.assignedCategory.categoryName);
//            }
                    } else {
            cell.textLabel.text = @"";

        }
        
//        MKPointAnnotation *fakeAnnotation = [[MKPointAnnotation alloc] init];
//        fakeAnnotation.title = @"fake annotation name";
//        POI *testPOI = [[POI alloc] initWithAnnotation:fakeAnnotation];
        
        
    }
    
  return cell;
    
}

- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //remove the deleted object from your data source.
        //If your data source is an NSMutableArray, do this
        if (self.segmentedControl.selectedSegmentIndex == 0) {
            [[DataSource2 sharedInstance].categories removeObjectAtIndex:indexPath.row];
        } else if (self.segmentedControl.selectedSegmentIndex == 1) {
            [[DataSource2 sharedInstance].poiFavorites removeObjectAtIndex:indexPath.row];
        }
        [[DataSource2 sharedInstance] saveData];
        [tableView reloadData]; // tell table to refresh now
    }
}




@end
