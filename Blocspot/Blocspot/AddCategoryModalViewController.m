//
//  AddCategoryModalViewController.m
//  Blocspot
//
//  Created by Casey Ward on 9/7/15.
//  Copyright (c) 2015 Casey Ward. All rights reserved.
//

#import "AddCategoryModalViewController.h"

@interface AddCategoryModalViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelAddCategoryModalButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveAddCategoryModalButton;
@property (weak, nonatomic) IBOutlet UITextField *addCategoryModalLabel;
@property (nonatomic,strong) NSString *selectedTableViewCellString;

@end

@implementation AddCategoryModalViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.categories = [DataSource2 sharedInstance].categories;
    [self setBackGroundColor];
    [self setupAppearance];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupAppearance {
    UIColor *colorTheme = [UIColor colorWithRed:52.0/255.0 green:73.0/255.0 blue:94.0/255.0 alpha:1.0f];
    
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    navigationBarAppearance.barTintColor = colorTheme;
    navigationBarAppearance.tintColor = [UIColor whiteColor];
    navigationBarAppearance.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    //    navigationBarAppearance.layer.borderColor = colorTheme.CGColor;
    //    navigationBarAppearance.layer.borderWidth = 1;
    
    
}

- (void)setBackGroundColor {
    UIColor *colorTheme = [UIColor colorWithRed:52.0/255.0 green:73.0/255.0 blue:94.0/255.0 alpha:1.0f];
    self.view.backgroundColor = colorTheme;
    
    NSLog(@"setBG color called");
}

- (IBAction)saveAddCategoryModalPressed:(id)sender {
    NSString *newCategoryString = self.addCategoryModalLabel.text;
    BlocSpotCategory *newCategory = [[BlocSpotCategory alloc] initWithName:newCategoryString];
    
    newCategory.categoryColor = [BlocSpotCategory createRandomColor];
    
    //only want to call this method when a user opens the addCategory VC from selecting addCategoryButton//maybe not true
    if (self.selectedPOIFavorite != nil) {
        self.categoryWasAssignedToPOI(newCategory);
        //this helps ensure the block is only called if this VC is called when adding category to POI object.
        //and not when adding a fresh category from the SearchViewVC.
    }
    
    
    newCategory.categoryColorString = [newCategory convertColorToString:newCategory.categoryColor];
    [[DataSource2 sharedInstance].categories addObject:newCategory];
    
    [[DataSource2 sharedInstance] saveData];
    
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelAddCategoryModalPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.categories count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.editing = YES;
    
    if ([[DataSource2 sharedInstance].categories count] > 0) {
    BlocSpotCategory *categories = [DataSource2 sharedInstance].categories[indexPath.row];
    cell.textLabel.text = categories.categoryName;
    cell.backgroundColor = categories.categoryColor;
        
    }else{
        cell.textLabel.text = @"";
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    BlocSpotCategory *existingCategory = [DataSource2 sharedInstance].categories[indexPath.row];
    
//        if (self.selectedPOIFavorite != nil) {
//            NSLog(@"the poi is NOT nil on the addCategoryVC");
//            self.categoryWasAssignedToPOI(existingCategory);
//           // [newCategory addPOItoCategory:self.selectedPOIFavorite];
//            }
    NSLog(@"exisiting category chosen. It's: %@", existingCategory.categoryName);
    self.categoryWasAssignedToPOI(existingCategory);
    [self dismissViewControllerAnimated:YES completion:nil];
    return cell;
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
