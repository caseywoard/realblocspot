//
//  FilterByCategoryViewController.m
//  
//
//  Created by Casey Ward on 10/9/15.
//
//

#import "FilterByCategoryViewController.h"

@interface FilterByCategoryViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelModalBtn;

@end

@implementation FilterByCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)cancelModalBtnPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TableView Delegate

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
    BlocSpotCategory *chosenCategoryForFilter = [DataSource2 sharedInstance].categories[indexPath.row];
    
    NSLog(@"exisiting category chosen. It's: %@", chosenCategoryForFilter.categoryName);
    self.categoryFilterWasChosen(chosenCategoryForFilter);
    [self dismissViewControllerAnimated:YES completion:nil];
    return cell;
}



@end
