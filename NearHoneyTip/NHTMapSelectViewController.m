//
//  NHTMapSelectViewController.m
//  NearHoneyTip
//
//  Created by Eunjoo Im on 2016. 1. 2..
//  Copyright © 2016년 Mamamoo. All rights reserved.
//

#import "NHTMapSelectViewController.h"
#import "NHTAnnotation.h"

@interface NHTMapSelectViewController ()

@end

@implementation NHTMapSelectViewController
CLLocationCoordinate2D tipCurLocation;

- (void)viewDidLoad {
    [super viewDidLoad];

    tipCurLocation = [self getCurrentLocation];
    [self setCurrentLocaton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelMap:(id)sender {
    NSLog(@"cancelMap");
}

- (IBAction)saveTip:(id)sender {
    NSLog(@"saveTip");
}

- (void) setCurrentLocaton {
    float delta = 0.003f;
    MKCoordinateRegion tipRegion;
    CLLocationCoordinate2D center;
    center = tipCurLocation;
    
    MKCoordinateSpan span;
    span.latitudeDelta = delta;
    span.longitudeDelta = delta;
    
    tipRegion.center = center;
    tipRegion.span = span;
    
    [self.tipMapView setRegion:tipRegion animated:YES];
    
    //mapView annotation
    self.tipMapView.delegate = self;
    
    NHTAnnotation *myLocation = [[NHTAnnotation alloc] initWithTitle:@"현재 위치" subTitle:@"" Location:tipCurLocation];
    [self.tipMapView addAnnotation:myLocation];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
