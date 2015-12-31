//
//  NHTMapViewController.h
//  NearHoneyTip
//
//  Created by Eunjoo Im on 2015. 12. 30..
//  Copyright © 2015년 Mamamoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface NHTMapViewController : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *nearMapView;
@property (nonatomic, retain) CLLocationManager *locationManager;
@end
