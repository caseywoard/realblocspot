//
//  AddCategoryModalViewController.h
//  Blocspot
//
//  Created by Casey Ward on 9/7/15.
//  Copyright (c) 2015 Casey Ward. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlocSpotCategory.h"
#import "POI.h"
#import "DataSource2.h"

//@protocol addCategoryDelegate <NSObject>
//-(void) assignCategoryToPOI:(BlocSpotCategory *)assignedCategory;
//@end

@interface AddCategoryModalViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *categories;
//@property (nonatomic, strong) BlocSpotCategory *assignedCategory;
@property (nonatomic, strong) POI *selectedPOIFavorite;

//@property (nonatomic, assign) id<addCategoryDelegate>  delegate;

@property (nonatomic, copy) void (^categoryWasAssignedToPOI)(BlocSpotCategory *assignedCategory);

- (void)setupAppearance;

@end
