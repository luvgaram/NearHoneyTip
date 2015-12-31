//
//  NHTAnnotation.h
//  NearHoneyTip
//
//  Created by Eunjoo Im on 2015. 12. 30..
//  Copyright © 2015년 Mamamoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface NHTAnnotation : NSObject <MKAnnotation>

@property(nonatomic, assign) CLLocationCoordinate2D coordinate;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *subtitle;

-(id)initWithTitle:(NSString *)newTitle subTitle:(NSString *)newSubTitle Location:(CLLocationCoordinate2D)location;
-(MKAnnotationView *)annotationView;

@end
