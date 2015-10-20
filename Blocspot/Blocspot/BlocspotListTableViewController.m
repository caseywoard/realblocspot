//
//  SpotListTableViewController.m
//  Blocspot
//
//  Created by Casey Ward on 8/9/15.
//  Copyright (c) 2015 Casey Ward. All rights reserved.
//

#import "BlocspotListTableViewController.h"
#import "SearchViewController.h"
#import "BlocspotMapViewController.h"
@import CoreLocation;
@import MapKit;

@interface BlocspotListTableViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *mapViewButton;


@end

@implementation BlocspotListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return [self.searchResults count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    // cell.textLabel.text = (NSString *)self.searchResults[indexPath.row][@"name"];
    MKMapItem *item = self.searchResults[indexPath.row];
    cell.textLabel.text = item.name;
    
    
    //NSLog(@"cellforrowatindexpath was called");
    return cell;

}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"selectedSearchResultSegue"]) {
        UITableViewCell *cell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
        
        MKMapItem *item = self.searchResults[indexPath.row];
        
        NSMutableArray *pointAnnotationsArray = [[NSMutableArray alloc] init];
        
        MKPointAnnotation *pointAnnotation = [[MKPointAnnotation alloc] init];
        pointAnnotation.coordinate = item.placemark.coordinate;
        pointAnnotation.title = item.name; //what about using item.placemark.name instead? what's the diff?
        
        [pointAnnotationsArray addObject:pointAnnotation];
        
        BlocspotMapViewController *mapMVC = (BlocspotMapViewController *)segue.destinationViewController;
        mapMVC.pointAnnotationsArray = pointAnnotationsArray;
    
        
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
}




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
