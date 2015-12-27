//
//  NHTGetLocationViewController.m
//  NearHoneyTip
//
//  Created by yunseo shin on 2015. 12. 27..
//  Copyright © 2015년 Mamamoo. All rights reserved.
//

#import "NHTGetLocationViewController.h"

@interface NHTGetLocationViewController ()
{
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}
@end


@implementation NHTGetLocationViewController
@synthesize locationManager;
@synthesize txtState, txtLatitude, txtLongitude, txtCountry;

#pragma mark - View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    geocoder = [[CLGeocoder alloc] init];
    if (locationManager == nil)
    {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        locationManager.delegate = self;
        [locationManager requestAlwaysAuthorization];
    }
    [locationManager startUpdatingLocation];

}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Turn off the location manager to save power.
    [self.locationManager stopUpdatingLocation];
}

#pragma mark - CLLocationManager delegate methods

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    CLLocation *newLocation = [locations lastObject];
    
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            txtLatitude.text = [NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];
            txtLongitude.text = [NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
            txtState.text = placemark.administrativeArea;
            txtCountry.text = placemark.country;
            
            NSLog(@"Current my location latitude is : %f",newLocation.coordinate.latitude);
            
            NSLog(@"Current my location longitude is : %f",newLocation.coordinate.longitude);
            
            
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    } ];
    
    // Turn off the location manager to save power.
    [manager stopUpdatingLocation];
    
    NSLog(@"%f", newLocation.coordinate.latitude);
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"Cannot find the location.");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
