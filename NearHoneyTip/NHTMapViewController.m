//
//  NHTMapViewController.m
//  NearHoneyTip
//
//  Created by Eunjoo Im on 2015. 12. 30..
//  Copyright © 2015년 Mamamoo. All rights reserved.
//

#import "NHTMapViewController.h"
#import "NHTAnnotation.h"

@interface NHTMapViewController ()

@end

@implementation NHTMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //mapView
//    float latitude = [self.tip.latitude floatValue];
//    float longitude = [self.tip.longitude floatValue];
//    float latitude = 51.434783;
//    float longitude = -0.213428;

    float delta = 0.005f;
    //get currentLocation
    CLLocationCoordinate2D curLocation = [self setCurrentLocation];
    
    MKCoordinateRegion tipRegion;
    CLLocationCoordinate2D center;
    center.latitude = curLocation.latitude;
    center.longitude = curLocation.longitude;
    
    MKCoordinateSpan span;
    span.latitudeDelta = delta;
    span.longitudeDelta = delta;
    
    tipRegion.center = center;
    tipRegion.span = span;
    
    [self.nearMapView setRegion:tipRegion animated:YES];
    
    //mapView annotation
    CLLocationCoordinate2D storeLocation;
    storeLocation.latitude = curLocation.latitude;
    storeLocation.longitude = curLocation.longitude;
    
//    NHTAnnotation *storeAnnotation = [NHTAnnotation alloc];
//    storeAnnotation.coordinate = storeLocation;
////    storeAnnotation.title = self.tip.storeName;
////    storeAnnotation.subtitle = distanceWithKm;
//    storeAnnotation.title = @"현재 위치";
//    storeAnnotation.subtitle = @"0m";
//     [self.nearMapView addAnnotation:storeAnnotation];
    
    self.nearMapView.delegate = self;
    
    NHTAnnotation *myLocation = [[NHTAnnotation alloc] initWithTitle:@"현재 위치" subTitle:@"" Location:curLocation];
    [self.nearMapView addAnnotation:myLocation];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    NHTAnnotation *customAnnotation = (NHTAnnotation *)annotation;
    
    MKAnnotationView *annotationView =
    [self.nearMapView dequeueReusableAnnotationViewWithIdentifier:@"customAnnotation"];
    
    if (annotationView == nil)
        annotationView = customAnnotation.annotationView;
    else
        annotationView.annotation = annotation;
    
    return annotationView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CLLocationCoordinate2D)setCurrentLocation {
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
