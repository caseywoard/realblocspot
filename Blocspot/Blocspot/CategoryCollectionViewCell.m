//
//  CategoryCollectionViewCell.m
//  Blocspot
//
//  Created by Casey Ward on 8/9/15.
//  Copyright (c) 2015 Casey Ward. All rights reserved.
//

#import "CategoryCollectionViewCell.h"

@implementation CategoryCollectionViewCell

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self){
        self.categoryView = [[UIView alloc] init];
        
        self.categoryView = [UIColor lightGrayColor];
        [self.contentView addSubview:self.categoryView];
    }
    
    return self;
}



@end
