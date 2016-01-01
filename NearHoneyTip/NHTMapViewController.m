//
//  NHTMapViewController.m
//  NearHoneyTip
//
//  Created by Eunjoo Im on 2015. 12. 30..
//  Copyright © 2015년 Mamamoo. All rights reserved.
//

#import "NHTMapViewController.h"
#import "NHTAnnotation.h"
#import "NHTTip.h"

@interface NHTMapViewController ()

@end

@implementation NHTMapViewController

CLLocationCoordinate2D curLocation;

- (void)viewDidLoad {
    [super viewDidLoad];

    //show currentLocation
    curLocation = [self getCurrentLocation];
    [self setCurrentLocaton];
    [self setNearTips];
}

- (void) setNearTips {
    NSLog(@"the number of tips: %d", (int)[self.tipCollection countOfTips]);
    
    for (int i = 0; i < (int)[self.tipCollection countOfTips]; i++) {
        NHTTip *tip = [self.tipCollection objectAtIndex:i];
        CLLocationCoordinate2D tipLoc;
        tipLoc.longitude = [tip.longitude floatValue];
        tipLoc.latitude = [tip.latitude floatValue];

        NHTAnnotation *tipLocation = [[NHTAnnotation alloc]
                                      initWithTitle:tip.storeName
                                      subTitle:[NSString stringWithFormat: @"%d m", tip.distance]
                                      Location:tipLoc];
        [self.nearMapView addAnnotation:tipLocation];
    }
}

- (void) setCurrentLocaton {
    float delta = 0.005f;
    MKCoordinateRegion tipRegion;
    CLLocationCoordinate2D center;
    center = curLocation;
    
    MKCoordinateSpan span;
    span.latitudeDelta = delta;
    span.longitudeDelta = delta;
    
    tipRegion.center = center;
    tipRegion.span = span;
    
    [self.nearMapView setRegion:tipRegion animated:YES];
    
    //mapView annotation
    self.nearMapView.delegate = self;
    
    NHTAnnotation *myLocation = [[NHTAnnotation alloc] initWithTitle:@"현재 위치" subTitle:@"" Location:curLocation];
    [self.nearMapView addAnnotation:myLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CLLocationCoordinate2D)getCurrentLocation {
    CLGeocoder *geocoder;
    
    NSLog(@"start to get location");
    geocoder = [[CLGeocoder alloc] init];
    if (self.locationManager == nil)
    {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        self.locationManager.delegate = self;
        [self.locationManager requestAlwaysAuthorization];
    }
    
    [self.locationManager startUpdatingLocation];
    
    if(self.locationManager.location){
        
        NSLog(@"got location info");
        return CLLocationCoordinate2DMake(self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude);
    } else {
        NSLog(@"no location info");
        NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
        return CLLocationCoordinate2DMake([preferences floatForKey:@"UserLocationLatitude"], [preferences floatForKey:@"UserLocationLongitude"]);
    }
}

#pragma mark annotation delegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    if ([annotation.title isEqualToString:@"현재 위치"]) {
        NHTAnnotation *customAnnotation = (NHTAnnotation *)annotation;
        
        MKAnnotationView *annotationView =
        [self.nearMapView dequeueReusableAnnotationViewWithIdentifier:@"customAnnotation"];
        
        if (annotationView == nil)
            annotationView = customAnnotation.annotationView;
        else
            annotationView.annotation = annotation;
        
        return annotationView;
    } else return nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
