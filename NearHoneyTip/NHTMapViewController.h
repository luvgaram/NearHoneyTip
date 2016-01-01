//
//  NHTMapViewController.h
//  NearHoneyTip
//
//  Created by Eunjoo Im on 2015. 12. 30..
//  Copyright © 2015년 Mamamoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "NHTTipCollection.h"

@interface NHTMapViewController : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *nearMapView;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (strong, nonatomic) NHTTipCollection *tipCollection;

@end
