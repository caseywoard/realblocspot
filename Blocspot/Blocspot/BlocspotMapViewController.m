//
//  SpotMapViewController.m
//  Blocspot
//
//  Created by Casey Ward on 8/9/15.
//  Copyright (c) 2015 Casey Ward. All rights reserved.
//

#define placeHolderText @"Add note..."

#import "BlocspotMapViewController.h"
@import CoreLocation;
@import MapKit;
//@import QuartzCore;

@interface BlocspotMapViewController () <MKAnnotation, MKMapViewDelegate, UITextViewDelegate, UIAlertViewDelegate>

//@property (readonly) CLLocationCoordinate2D *coordinate;//what's up?


@property (weak, nonatomic) IBOutlet UIView *poiPopUpDetail;
@property (weak, nonatomic) IBOutlet UIView *poiPopUpDetailCloseButton;
@property (weak, nonatomic) IBOutlet UILabel *poiPopUpDetailName;
@property (weak, nonatomic) IBOutlet UIButton *saveToFavoritesBtn;
@property (weak, nonatomic) IBOutlet UIButton *poiPopUpDetailCategoryButton;
//@property (assign, nonatomic) BOOL poiPopUpDetailHasCategory;
@property (weak, nonatomic) IBOutlet UITextView *poiPopUpDetailTextView;
@property (weak, nonatomic) IBOutlet UIButton *getDirectionsButton;
@property (weak, nonatomic) IBOutlet UIButton *sharePOIbtn;
@property (weak, nonatomic) IBOutlet UIButton *deletePOIbtn;

@end

@implementation BlocspotMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setMapView:self.mapView];

    
    [self.poiPopUpDetail setHidden:YES];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    self.poiPopUpDetailTextView.delegate = self;
    if (self.selectedPOIFavorite == nil || [self.selectedPOIFavorite.poiNote isEqual:nil]) {
        self.poiPopUpDetailTextView.text = placeHolderText;
        self.poiPopUpDetailTextView.textColor = [UIColor lightGrayColor];
    } else {
        self.poiPopUpDetailTextView.text = self.selectedPOIFavorite.poiNote;
        self.poiPopUpDetailTextView.textColor = [UIColor blackColor];
    }
 
}

- (void) viewDidLayoutSubviews {
    self.poiPopUpDetail.layer.cornerRadius = 5;
    self.poiPopUpDetail.layer.masksToBounds = YES;
    
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if ([self.poiPopUpDetailTextView.text isEqual:placeHolderText]) {
        self.poiPopUpDetailTextView.text = nil;
        self.poiPopUpDetailTextView.textColor = [UIColor blackColor];
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (self.poiPopUpDetailTextView.text == nil) {
        self.poiPopUpDetailTextView.text = placeHolderText;
        self.poiPopUpDetailTextView.textColor = [UIColor lightGrayColor];
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    if (self.poiPopUpDetailTextView == nil) {
        self.poiPopUpDetailTextView.text = placeHolderText;
        self.poiPopUpDetailTextView.textColor = [UIColor lightGrayColor];
    }
}

-(void) setMapView:(MKMapView *)mapView {
    _mapView = mapView; //whats with using _mapView vs. self.mapView??
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    
    [self.mapView showAnnotations:self.pointAnnotationsArray animated:YES];
//    NSMutableArray *tempArray = [NSMutableArray new];
//    for (MKPointAnnotation *pointAnnotations in self.pointAnnotationsArray) {
//        CustomAnnotation *customAnnoation = [[CustomAnnotation alloc] initWithTitle:pointAnnotations.title Location:pointAnnotations.coordinate];
//        [tempArray addObject:customAnnoation];
//    }
//    [self.mapView addAnnotations:tempArray];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
//    CLLocationCoordinate2D coord = self.mapView.userLocation.coordinate;
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 500.0, 500.0);
//    [self.mapView setRegion:region animated:YES];
//
//}

- (void)dismissKeyboard{
    [self.poiPopUpDetailTextView resignFirstResponder];
    self.poiPopUpDetailTextView.editable = NO;
}
-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    //set this up later
}

-(CLLocationCoordinate2D)coordinate {
    CLLocationCoordinate2D coordinate;
    
    coordinate.latitude = [UserLocation sharedLocationInstance].locationManager.location.coordinate.latitude;
    coordinate.longitude = [UserLocation sharedLocationInstance].locationManager.location.coordinate.longitude;
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 1000.0, 1000.0);
    [self.mapView setRegion:region animated:YES];
    
    
    return coordinate;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    //original blcok
    if([annotation isKindOfClass: [MKUserLocation class]]) {
        return nil;
    }
//    self.annotationView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"customAnnoation"];
//    //new block
//    if ([annotation isKindOfClass:[CustomAnnotation class]]) {
//        NSLog(@"This IF block about Custom Annotations is being called.");
//        if (self.annotationView == nil) {
//            CustomAnnotation *newAnnotation = (CustomAnnotation *)annotation;
//            MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:newAnnotation reuseIdentifier:@"POIannotation"];
//            self.annotationView = annotationView;
//        } else {
//            self.annotationView.annotation = annotation;
//        }
//    return self.annotationView;
//    }
//    return self.annotationView;
    
    //original block
    self.annotationView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"POIannotation"];
    
    if(self.annotationView == nil) {
        self.mapView.delegate = self;
       MKAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"POIannotation"];
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        
    } else {
        self.annotationView.annotation = annotation;
    }
    return self.annotationView;
    
}

- (void) mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    self.poiPopUpDetailTextView.editable = YES;
    
    if (self.selectedPOIFavorite != nil) {
        if (self.selectedPOIFavorite.assignedCategory != nil) {
            self.poiPopUpDetailCategoryButton.backgroundColor = self.selectedPOIFavorite.assignedCategory.categoryColor;
            self.poiPopUpDetailCategoryButton.titleLabel.text = self.selectedPOIFavorite.assignedCategory.categoryName;
            NSLog(@"POI favorite Lat: %f and Long: %f", self.selectedPOIFavorite.latitude, self.selectedPOIFavorite.longitude);
        } else {
            self.poiPopUpDetailCategoryButton.backgroundColor = [UIColor colorWithRed:127.0/255.0 green:127.0/255.0 blue:127.0/255.0 alpha:1.0f];
            self.poiPopUpDetailCategoryButton.titleLabel.text = @"Unknown Category";
        }
        
        self.poiPopUpDetailName.text = self.selectedPOIFavorite.name;
       
        
        NSLog(@"passing in existing POI to popUpVC");
        NSLog(@"self.selectedPOIFavorite assigned category is: %@", self.selectedPOIFavorite.assignedCategory.categoryName);
    
      
        
    } else {
        NSLog(@"NO existing POI. Not passing anything to popUpVC");
        self.selectedAnnotation = view.annotation;//change this prp to selected annotation
        
        //not sure if purposefully setting button text & bgcolor here is necessary. already done in storybuilder...
        //self.poiPopUpDetailCategoryButton.backgroundColor = [UIColor colorWithRed:127.0/255.0 green:127.0/255.0 blue:127.0/255.0 alpha:1.0f];
        
        //self.poiPopUpDetailCategoryButton.titleLabel.text = @"Unkown Category";
        self.poiPopUpDetailName.text = self.selectedAnnotation.title;
    }
    
//    POI *poi = [[POI alloc] initWithAnnotation:self.selectedPOI];
//    for (POI *aPOI in [DataSource2 sharedInstance].poiFavorites) {
//        if (aPOI.name == poi.name) {
//            NSLog(@"we have a match with POI names...");
//            self.poiPopUpDetailCategoryButton.backgroundColor = aPOI.assignedCategory.categoryColor;
//            self.poiPopUpDetailCategoryButton.titleLabel.text = aPOI.assignedCategory.categoryName;
//        } else {
//
//            
//        }
//    }
    
    self.poiPopUpDetailName.adjustsFontSizeToFitWidth = YES;
    [self.poiPopUpDetail setHidden:NO];
   
    
//    [self launchModal];
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"addCategorySegue2"]) {
        
        AddCategoryModalViewController *addCategoryViewController = (AddCategoryModalViewController *)segue.destinationViewController;
       
        //this block is called within AddCategoryModalVC when the user selects a category, assigns given category name/color to button
        addCategoryViewController.categoryWasAssignedToPOI = ^(BlocSpotCategory *assignedCategory) {
            self.poiPopUpDetailCategoryButton.backgroundColor = assignedCategory.categoryColor;
            //enabled = FALSE/True was suggested it resolves issue I was expereincing with button label text not updating correctly (stackoverflow suggestion)
            self.poiPopUpDetailCategoryButton.enabled = FALSE;
            [self.poiPopUpDetailCategoryButton setTitle:assignedCategory.categoryName forState:UIControlStateNormal];
            self.poiPopUpDetailCategoryButton.enabled = TRUE;//and this...
           
            if (self.selectedPOIFavorite != nil) {
                NSLog(@"setting selectedPOIFavorite.assignedCategory equal to: %@", assignedCategory.categoryName);
                self.selectedPOIFavorite.assignedCategory = self.assignedCategory;
            } else {
                NSLog(@"creating brand new POI and setting assignedCategory equal to: %@", assignedCategory.categoryName);
                POI *poi = [[POI alloc] initWithAnnotation:self.selectedAnnotation];
                poi.assignedCategory = assignedCategory;
                self.selectedPOIFavorite = poi;
            }
        };
    }
    else if ([segue.identifier isEqualToString:@"listViewFlipSegue"]) {
        
        NSMutableArray *searchResultsArray = [[NSMutableArray alloc] init];
        
        //for (MKMapItem *item in self.searchResults) {
        for (MKPointAnnotation *pointAnnotation in self.pointAnnotationsArray) {
            MKMapItem *mapItem = [[MKMapItem alloc] init];
            mapItem.placemark.coordinate = pointAnnotation.coordinate;
            mapItem.name = pointAnnotation.title;
            [searchResultsArray addObject:mapItem];
        }

        BlocspotListTableViewController *listViewMVC = (BlocspotListTableViewController *)segue.destinationViewController;
        listViewMVC.searchResults = searchResultsArray;
    }
}

/*
} else if ([segue.identifier isEqualToString:@"mapViewFlipSegue"]) {
    NSMutableArray *pointAnnotationsArray = [[NSMutableArray alloc] init];
    
    for (MKMapItem *item in self.searchResults) {
        
        MKPointAnnotation *pointAnnotation = [[MKPointAnnotation alloc] init];
        pointAnnotation.coordinate = item.placemark.coordinate;
        pointAnnotation.title = item.name;
        
        [pointAnnotationsArray addObject:pointAnnotation];
        
    }
    
    BlocspotMapViewController *mapMVC = (BlocspotMapViewController *)segue.destinationViewController;
    mapMVC.pointAnnotationsArray = pointAnnotationsArray;
    
}
 */
- (IBAction)poiPopUpCategoryButtonSelected:(id)sender {
    [self performSegueWithIdentifier:@"addCategorySegue2" sender:nil];
}

- (IBAction)poiPopUpCloseButtonSelected:(id)sender {
    [self.poiPopUpDetail setHidden:YES];
}

- (IBAction)saveToFavoritesSelected:(id)sender {
    
    if (self.selectedPOIFavorite == nil) {
        POI *poi = [[POI alloc] initWithAnnotation:self.selectedAnnotation];
        poi.assignedCategory.categoryColorString = [poi.assignedCategory convertColorToString:poi.assignedCategory.categoryColor];
        if ([self.poiPopUpDetailTextView.text isEqual:placeHolderText] || self.poiPopUpDetailTextView.text == nil) {
            poi.poiNote = nil;
        } else {
            poi.poiNote = self.poiPopUpDetailTextView.text;
        }
        [poi addPOIToFavorites];
        NSLog(@"creating fresh poi to save with the category of: %@", poi.assignedCategory.categoryName);
    } else {
        NSLog(@"poi exists in the self.selectedPOIFavorite property. saving it now with the category of: %@", self.selectedPOIFavorite.assignedCategory.categoryName);
        if ([self.poiPopUpDetailTextView.text isEqual:placeHolderText] || self.poiPopUpDetailTextView.text == nil) {
           self.selectedPOIFavorite.poiNote = nil;
        } else {
            self.selectedPOIFavorite.poiNote = self.poiPopUpDetailTextView.text;
        }
        [self.selectedPOIFavorite addPOIToFavorites];
    }
    
    [self.poiPopUpDetail setHidden:YES];
    [self.poiPopUpDetailTextView resignFirstResponder];
    //self.selectedPOIFavorite = nil;
}

#pragma mark - PopUp View elements

- (IBAction)getDirectionsButtonPressed:(id)sender {
    
    UIAlertView *getDirectionsConfirmationAlert = [[UIAlertView alloc] initWithTitle:@"Want Directions?"
                                                               message:@"please confirm"
                                                              delegate:self
                                                     cancelButtonTitle:@"NO"
                                                     otherButtonTitles:@"YES",nil];
    [getDirectionsConfirmationAlert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([alertView.title isEqualToString:@"Want Directions?"]) {
        if (buttonIndex == 1) {
            [self getDirections];
        }
    } else if ([alertView.title isEqualToString:@"Delete POI from Favorites List?"]){
        if (buttonIndex == 1) {
            [self deletePOI];
        }
 }
}

- (void) getDirections {
    CLLocationCoordinate2D destinationCoordinate;
    MKPlacemark *destinationPlaceMark;
    
    if (self.selectedPOIFavorite == nil) {
        destinationCoordinate.latitude = self.selectedAnnotation.coordinate.latitude;
        destinationCoordinate.longitude = self.selectedAnnotation.coordinate.longitude;
        
        destinationPlaceMark = [[MKPlacemark alloc] initWithCoordinate:destinationCoordinate addressDictionary:nil];
        
    } else {
        destinationCoordinate.latitude = self.selectedPOIFavorite.latitude;
        destinationCoordinate.longitude = self.selectedPOIFavorite.longitude;
        
        destinationPlaceMark = [[MKPlacemark alloc] initWithCoordinate:destinationCoordinate addressDictionary:nil];
    }

    MKMapItem *destinationMapItem = [[MKMapItem alloc] initWithPlacemark:destinationPlaceMark];
    destinationMapItem.name = self.selectedAnnotation.title;
    
    [destinationMapItem openInMapsWithLaunchOptions:@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving}];
}
- (IBAction)sharePOIBtnPressed:(id)sender {
    
    NSString *text = [NSString stringWithFormat:@"Check out this cool spot: %@", self.selectedPOIFavorite.name];
    //pulling the coordinates from annotation in order to create apple maps link
    CGFloat latitude = self.selectedAnnotation.coordinate.latitude;
    CGFloat longitude = self.selectedAnnotation.coordinate.longitude;
    NSString *urlString = [NSString stringWithFormat:@"http://maps.apple.com/?ll=%f,%f", latitude,longitude];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSArray *arrayToShare = [[NSArray alloc] initWithObjects:text, url, nil];
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:arrayToShare  applicationActivities:nil];
    
    [self presentViewController:activityController animated:YES completion:nil];
}

- (IBAction)deletePOIBtnPressed:(id)sender {
    UIAlertView *deleteConfirmationAlert = [[UIAlertView alloc] initWithTitle:@"Delete POI from Favorites List?" message:@"please confirm" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete",nil];
    
    UIAlertView *notSavedYetAlert = [[UIAlertView alloc] initWithTitle:@"Not a saved POI" message:@"nothing to delete" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    if (self.selectedPOIFavorite != nil){
        [deleteConfirmationAlert show];
    } else {
        [notSavedYetAlert show];
    }
}

- (void)deletePOI {
    [[DataSource2 sharedInstance].poiFavorites removeObject:self.selectedPOIFavorite];
    [[DataSource2 sharedInstance] saveData];
    self.selectedPOIFavorite = nil;
    [self.navigationController popViewControllerAnimated:YES];
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
