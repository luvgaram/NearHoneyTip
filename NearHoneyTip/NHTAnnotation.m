//
//  NHTAnnotation.m
//  NearHoneyTip
//
//  Created by Eunjoo Im on 2015. 12. 30..
//  Copyright © 2015년 Mamamoo. All rights reserved.
//

#import "NHTAnnotation.h"

@implementation NHTAnnotation
@synthesize coordinate, title, subtitle;

-(id)initWithTitle:(NSString *)newTitle subTitle:(NSString *)newSubTitle Location:(CLLocationCoordinate2D)location {
    self = [super init];
    
    if (self) {
        self.title = newTitle;
        self.subtitle = newSubTitle;
        self.coordinate = location;
    }
    return self;
}

-(MKAnnotationView *)annotationView {
    MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"customAnnotation"];
    
    annotationView.enabled = YES;
    annotationView.canShowCallout = YES;
//    annotationView.image = self.image;
    UIImage *myimage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"userlocation" ofType:@"png"]];
    annotationView.image = myimage;
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    return annotationView;
}

@end
