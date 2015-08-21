//
//  BlocspotHomeCollectionViewController.m
//  Blocspot
//
//  Created by Casey Ward on 8/9/15.
//  Copyright (c) 2015 Casey Ward. All rights reserved.
//

#import "BlocspotHomeCollectionViewController.h"
#import "UserLocation.h"

@interface BlocspotHomeCollectionViewController ()

@property (nonatomic,strong) NSMutableArray     *defaultCategories;
@property (nonatomic,strong) NSArray            *dataSourceForSearchResult;
@property (nonatomic,strong) UISearchBar        *searchBar;
@property (nonatomic,strong) UIRefreshControl   *refreshControl;
@end

@implementation BlocspotHomeCollectionViewController

static NSString * const reuseIdentifier = @"default_category";


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //creating searchbar
    int navBarYPosition = self.navigationController.navigationBar.frame.size.height + 20;
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,navBarYPosition,[UIScreen mainScreen].bounds.size.width, 44)];
    [self.view addSubview:searchBar];
    
    //configure collectionview
    self.defaultCategories = [NSMutableArray arrayWithObjects:@"Banks/ATM", @"Gas Stations", @"Movie Theaters", @"Pubs", @"Coffee Shops", @"Hotels", @"Parking", @"Pharmacies", @"Restaurants", nil];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//#warning Incomplete method implementation -- Return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [self.defaultCategories count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    /*
    for (int i= 0; i < self.categories.count; i++) {
    
        UILabel *categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, cell.bounds.size.width, 40)];
        categoryLabel.text = self.categories[i];
        [cell.contentView addSubview:categoryLabel];
    }
     */
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
