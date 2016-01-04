//
//  NHTMapSelectViewController.m
//  NearHoneyTip
//
//  Created by Eunjoo Im on 2016. 1. 2..
//  Copyright © 2016년 Mamamoo. All rights reserved.
//

#import "NHTMapSelectViewController.h"
#import "NHTAnnotation.h"

@interface NHTMapSelectViewController () {
    NSURLResponse *response;
}

@end

@implementation NHTMapSelectViewController
CLLocationCoordinate2D tipCurLocation;
static NSString *boundary = @"!@#$@#!$@#!$1234567890982123456789!@#$#@$%#@";

- (void)viewDidLoad {
    [super viewDidLoad];

    tipCurLocation = [self getCurrentLocation];
    [self setCurrentLocaton];
    
    // set current location to tip
    [self.tip setObject:[NSNumber numberWithFloat:tipCurLocation.longitude] forKey:@"longitude"];
    [self.tip setObject:[NSNumber numberWithFloat:tipCurLocation.latitude] forKey:@"latitude"];
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleGesture:)];
    lpgr.minimumPressDuration = 1;  //user must press for 2 seconds
    [self.tipMapView addGestureRecognizer:lpgr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelMap:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"backFromWrite" object:self];
}

- (IBAction)saveTip:(id)sender {
    NSLog(@"saveTip");
    [self postTip:self.tip];
    NSLog(@"saving tip for %@", [self.tip objectForKey:(@"uid")]);
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)handleGesture:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded)
        return;
    
    NSArray *oldAnnotations=[self.tipMapView annotations];
    [self.tipMapView removeAnnotations:oldAnnotations];
    
    CGPoint touchPoint = [gestureRecognizer locationInView:self.tipMapView];
    CLLocationCoordinate2D touchMapCoordinate =
    [self.tipMapView convertPoint:touchPoint toCoordinateFromView:self.tipMapView];
    
    MKPointAnnotation *pa = [[MKPointAnnotation alloc] init];
    pa.coordinate = touchMapCoordinate;
    pa.title = [self.tip objectForKey:@"storename"];
    [self.tipMapView addAnnotation:pa];
    
    [self.tip setObject:[NSNumber numberWithFloat:touchMapCoordinate.longitude] forKey:@"longitude"];
    [self.tip setObject:[NSNumber numberWithFloat:touchMapCoordinate.latitude] forKey:@"latitude"];
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

//- (void)postFormDataAtURL :(NSURL *)url postData:(NSData*)postData {
//    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
//    request.HTTPMethod = @"POST";
//    NSString* contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
//    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
//    [request setHTTPBody:postData];
//    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request
//                                                                  delegate:self];
//    [connection start];
//    
//    NSLog(@"connection end");
//}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    long code = [httpResponse statusCode];
    NSLog(@"connection response: %ld", code);
    
    if(code == 200){
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"backFromWrite" object:self];
    }
    
}

- (void)postFormDataAtURL :(NSURL *)url postData:(NSData*)postData {
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    NSString* contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request
                                                                  delegate:self];
    [connection start];
    [self connection:connection didReceiveResponse:response];
    
    NSLog(@"connection end");
    //temp
    
}



- (void) postTip:(NSDictionary *)tipDictionary {
    NSLog(@"start post");
    
    NSMutableData* body = [NSMutableData data];
    NSData *data = tipDictionary[@"imageData"];
    if (data) {
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"upload\"; filename=\"%@.jpg\"\r\n", tipDictionary[@"storename"]] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[NSData dataWithData:data]];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"storename\"\r\n\r\n%@", tipDictionary[@"storename"]] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"tipdetail\"\r\n\r\n%@", tipDictionary[@"detail"]] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"uid\"\r\n\r\n%@", tipDictionary[@"uid"]] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"nickname\"\r\n\r\n%@", tipDictionary[@"nickname"]] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"profilephoto\"\r\n\r\n%@", tipDictionary[@"profilephoto"]] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"longitude\"\r\n\r\n%@", tipDictionary[@"longitude"]] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"latitude\"\r\n\r\n%@", tipDictionary[@"latitude"]] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [self postFormDataAtURL:[NSURL URLWithString:@"http://54.64.250.239:3000/tip"]
                   postData:body];
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"backFromWrite" object:self];
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
