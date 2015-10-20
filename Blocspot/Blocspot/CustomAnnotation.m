//
//  CustomAnnotation.m
//  Blocspot
//
//  Created by Casey Ward on 9/26/15.
//  Copyright (c) 2015 Casey Ward. All rights reserved.
//

#import "CustomAnnotation.h"

@implementation CustomAnnotation

-(id) initWithTitle:(NSString *)newTitle Location:(CLLocationCoordinate2D)location {
    
    self = [super init];
    
    if (self) {
        
    _title = newTitle;
    _coordinate = location;
    }
    
    return self;
}

- (MKAnnotationView *) annotationView {
    
    MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"customAnnoation"];
    
    annotationView.enabled = YES;
    annotationView.canShowCallout = YES;
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    annotationView.image = [UIImage imageNamed:@"map-pointer7.png"];
    
    return annotationView;
}

@end
