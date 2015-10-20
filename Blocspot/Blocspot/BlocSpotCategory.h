//
//  Category.h
//  Blocspot
//
//  Created by Casey Ward on 8/25/15.
//  Copyright (c) 2015 Casey Ward. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DataSource2.h"
@class POI;


@interface BlocSpotCategory : NSObject <NSCoding>

@property (nonatomic, strong) NSString *categoryName;
@property (nonatomic, strong) UIColor *categoryColor;
@property (nonatomic, strong) NSString *categoryColorString;
@property (nonatomic, strong) NSMutableArray *assignedPOIs;


//+ (NSArray *) convertColorToString:(NSMutableArray *)categories; //- method that converts uicolor to string vice verse

- (NSString *) convertColorToString:(UIColor *)categoryColorUIColor;
- (UIColor *)convertStringToColor:(NSString *)categoryColorString;

+ (UIColor *) createRandomColor;

- (instancetype) initWithName:(NSString *) name;
//- (instancetype) initWithDefaultCategories:(NSArray *) defaultCategories;
+ (NSArray *) createDefaultCategories;
- (void) addCategory;
- (void) addPOItoCategory:(POI *)poi;

@end
