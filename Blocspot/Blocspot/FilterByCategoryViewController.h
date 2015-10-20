//
//  FilterByCategoryViewController.h
//  
//
//  Created by Casey Ward on 10/9/15.
//
//

#import <UIKit/UIKit.h>
#import "BlocSpotCategory.h"
#import "DataSource2.h"

@interface FilterByCategoryViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *categories;

@property (nonatomic, copy) void (^categoryFilterWasChosen)(BlocSpotCategory *chosenCategoryForFilter);

@end
