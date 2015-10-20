//
//  Category.m
//  Blocspot
//
//  Created by Casey Ward on 8/25/15.
//  Copyright (c) 2015 Casey Ward. All rights reserved.
//

#import "BlocSpotCategory.h"


//@implementation Category : NSObject // do I always add NSObject to custom class .m file?
@implementation BlocSpotCategory

-(instancetype) init {
        
    return self;
}

- (instancetype) initWithName: (NSString *) name {
    self = [super init];
    
    self.categoryName = name;
    
    return self;
}



- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    
    if (self) {
        self.categoryName = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(name))];
        self.categoryColorString = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(categoryColorString))];
        //self.assignedPOIs = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(assignedPOIs))];
        self.categoryColor = [self convertStringToColor:self.categoryColorString];
       
    }
    return self;
}


- (void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.categoryName forKey:NSStringFromSelector(@selector(name))];
    [aCoder encodeObject:self.categoryColorString forKey:NSStringFromSelector(@selector(categoryColorString))];
    //[aCoder encodeObject:self.assignedPOIs forKey:NSStringFromSelector(@selector(assignedPOIs))];
}

- (void) addCategory {
    
    [[DataSource2 sharedInstance].categories addObject:self];

}

+ (UIColor *) createRandomColor {
    
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    saturation = saturation < 0.5 ? 0.5 : saturation;
    brightness = brightness < 0.9 ? 0.9 : brightness;
    UIColor *randomColor = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    
    return randomColor;
}

+(NSArray *) createDefaultCategories {
    NSArray *colorArray = [[NSArray alloc] initWithObjects:
                           [UIColor colorWithRed:231.0/255.0 green:76.0/255.0 blue:60.0/255.0 alpha:1.0f],
                           [UIColor colorWithRed:230.0/255.0 green:126.0/255.0 blue:34.0/255.0 alpha:1.0f ],
                           [UIColor colorWithRed:142.0/255.0 green:68.0/255.0 blue:173.0/255.0 alpha:1.0f ],
                           [UIColor colorWithRed:41.0/255.0 green:128.0/255.0 blue:185.0/255.0 alpha:1.0f ], nil];
    NSMutableArray *defaultCategories = [[NSMutableArray alloc] init];
    
    int i = 0;
    for (NSString *category in @[@"Bars", @"Restaurants", @"Gas Stations", @"Banks/ATMs"]) {
        BlocSpotCategory *defaultCategory = [[BlocSpotCategory alloc] init];
        defaultCategory.categoryName = category;
        defaultCategory.categoryColor = [colorArray objectAtIndex:i];
        defaultCategory.categoryColorString = [defaultCategory convertColorToString:defaultCategory.categoryColor];
        i++;
        [defaultCategories addObject:defaultCategory];
    }

    return defaultCategories;
}



- (NSString *) convertColorToString:(UIColor *)categoryColorUIColor {
    const CGFloat *components = CGColorGetComponents(categoryColorUIColor.CGColor);
    NSString *colorAsString = [NSString stringWithFormat:@"%f,%f,%f,%f", components[0], components[1], components[2], components[3]];
    return colorAsString;
}



- (UIColor *) convertStringToColor:(NSString *)categoryColorString {
    NSArray *components = [categoryColorString componentsSeparatedByString:@","];
    CGFloat r = [[components objectAtIndex:0] floatValue];
    CGFloat g = [[components objectAtIndex:1] floatValue];
    CGFloat b = [[components objectAtIndex:2] floatValue];
    CGFloat a = [[components objectAtIndex:3] floatValue];
    UIColor *color = [UIColor colorWithRed:r green:g blue:b alpha:a];
    
    return color;
}

- (void) addPOItoCategory:(POI *)poi {
    [self.assignedPOIs addObject:poi];
}

@end
