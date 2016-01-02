//
//  NHTMapSelectViewController.h
//  NearHoneyTip
//
//  Created by Eunjoo Im on 2016. 1. 2..
//  Copyright © 2016년 Mamamoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface NHTMapSelectViewController : UIViewController

@property (strong, nonatomic) NSDictionary *tip;
- (IBAction)cancelMap:(id)sender;
- (IBAction)saveTip:(id)sender;
@property (weak, nonatomic) IBOutlet MKMapView *tipMapView;
@property (nonatomic, retain) CLLocationManager *locationManager;

@end
