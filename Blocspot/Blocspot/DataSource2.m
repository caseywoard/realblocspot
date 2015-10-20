//
//  DataSource2.m
//  Blocspot
//
//  Created by Casey Ward on 8/30/15.
//  Copyright (c) 2015 Casey Ward. All rights reserved.
//

#import "DataSource2.h"

@implementation DataSource2

+ (instancetype) sharedInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


- (instancetype) init {
    self = [super init];
    
    if (self) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectoryPath = [paths objectAtIndex:0];
        NSString *filePath = [documentsDirectoryPath stringByAppendingPathComponent:@"poi"];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            NSData *data = [NSData dataWithContentsOfFile:filePath];
            NSMutableArray *savedData = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            if ([savedData isKindOfClass:[NSMutableArray class]] && savedData.count > 0) {
                self.poiFavorites = savedData;
            } else {
                self.poiFavorites = [NSMutableArray new];
            }
        } else {
            self.poiFavorites = [NSMutableArray new];
        }

        filePath = [documentsDirectoryPath stringByAppendingPathComponent:@"category"];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            NSData *data = [NSData dataWithContentsOfFile:filePath];
            NSMutableArray *savedData = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            if ([savedData isKindOfClass:[NSMutableArray class]] && savedData.count > 0) {
                self.categories = savedData; //original
                
            } else {
                self.categories = [BlocSpotCategory createDefaultCategories].mutableCopy;
            }
        } else {
            self.categories = [BlocSpotCategory createDefaultCategories].mutableCopy;
        }
        
    }
    return self;
}


- (void) saveData {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    
    //saving points of interest
    NSString *filePath = [documentsDirectoryPath stringByAppendingPathComponent:@"poi"];
    [NSKeyedArchiver archiveRootObject:self.poiFavorites toFile:filePath];
    
    //saving categories
    filePath = [documentsDirectoryPath stringByAppendingPathComponent:@"category"];
    [NSKeyedArchiver archiveRootObject:self.categories toFile:filePath]; //original

}






@end

