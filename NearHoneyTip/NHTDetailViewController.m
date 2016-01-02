//
//  NHTDetailViewController.m
//  NearHoneyTip
//
//  Created by Kate KyuWon on 11/25/15.
//  Copyright © 2015 Mamamoo. All rights reserved.
//

#import "NHTDetailViewController.h"
#import "NHTTip.h"
#import "NHTButtonTapPost.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NHTAnnotation.h"

@interface NHTDetailViewController (){
    NSUserDefaults *preferences;
}
@end

@implementation NHTDetailViewController
@synthesize storeMapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.postManager = [[NHTButtonTapPost alloc] init];
    if(self.tip){
        
        
        self.storeName.title = self.tip.storeName;
        
        // modified by ej
//        self.tipImage.image = self.tip.tipImage;
        
        NSString *tipImagePathWhole = @"http://54.64.250.239:3000/image/photo=";
        tipImagePathWhole = [tipImagePathWhole stringByAppendingString:self.tip.tipImage];
        [self.tipImage sd_setImageWithURL:[NSURL URLWithString:tipImagePathWhole]
                         placeholderImage:[UIImage imageNamed:@"nht_logo.png"]];
        
        self.tipDetails.text = self.tip.tipDetails;
        
//        self.userProfileImage.image = self.tip.userProfileImg;
        
        self.userProfileImage.layer.cornerRadius = 25;
        NSString *tipIconPathWhole = @"http://54.64.250.239:3000/image/icon=";
        tipIconPathWhole = [tipIconPathWhole stringByAppendingString:self.tip.userProfileImg];
        [self.userProfileImage sd_setImageWithURL:[NSURL URLWithString:tipIconPathWhole]
                                 placeholderImage:[UIImage imageNamed:@"nht_logo.png"]];

        self.userNickname.text = self.tip.userNickname;
        self.tipDate.text = self.tip.tipDate;
        //userBadge
        //likeButton
        [self setLikeButtonProperty];
        UITapGestureRecognizer *tapLikeButton = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapLike:)];
        self.likeButton.target = tapLikeButton;
        self.likeButton.action= @selector(didTapLike:);
        self.likeButtonImage.target = tapLikeButton;
        self.likeButtonImage.action = @selector(didTapLike);
       
        NSString *distanceWithKm = [NSString stringWithFormat:@"%lu", (unsigned long)self.tip.distance];
        distanceWithKm = [distanceWithKm stringByAppendingString:@" m"];
        
        /* //상세화면에서 거리 삭제.
        self.distance.text = distanceWithKm;
         */
        //commentButton
        
        //mapView
        CLLocationCoordinate2D tipLocation;
        tipLocation.latitude = [self.tip.latitude floatValue];
        tipLocation.longitude = [self.tip.longitude floatValue];
        
        float delta = 0.0011f;
        
        MKCoordinateRegion tipRegion;
        
        MKCoordinateSpan span;
        span.latitudeDelta = delta;
        span.longitudeDelta = delta;

        tipRegion.center = tipLocation;
        tipRegion.span = span;
        
        [self.storeMapView setRegion:tipRegion animated:YES];
        
        //mapView annotation
        NHTAnnotation *storeAnnotation = [[NHTAnnotation alloc] initWithTitle:self.tip.storeName subTitle:distanceWithKm Location:tipLocation];
        [self.storeMapView addAnnotation:storeAnnotation];
    }
}

-(void)setLikeButtonProperty{
    
    NSString *likeString = @"좋아요 ";
    NSString *likeCount;
    
    preferences = [NSUserDefaults standardUserDefaults];

    if(self.tip.likeInteger <= 0){
        likeCount = @"";
    } else {
        likeCount = [NSString stringWithFormat:@"%lu", (unsigned long)self.tip.likeInteger];
    }
    
    likeString = [likeString stringByAppendingString:likeCount];
    self.likeButton.title = likeString;
    
    if(self.tip.isLiked){
        [self didTapLike];
    }

}
-(void)didTapLike:(UITapGestureRecognizer *)recognizer{
    NSLog(@"#####Tap like recog: %@", recognizer);
    if( self.tip.isLiked == NO ){
        self.tip.isLiked = YES;
        self.likeButton.tintColor = [[UIColor alloc]initWithRed: 253.0/255.0 green:204.0/255.0 blue:1.0/255.0 alpha:1];
        self.likeButtonImage.tintColor = [[UIColor alloc]initWithRed: 253.0/255.0 green:204.0/255.0 blue:1.0/255.0 alpha:1];
        [self willPlusLike];
        [self.postManager   postLikeChangeMethod:@"POST" Tip:self.tip.tipId];
//        
    } else {
        self.tip.isLiked = NO;
        self.likeButton.tintColor = [UIColor whiteColor];
        self.likeButtonImage.tintColor = [UIColor whiteColor];
        [self willSubtractLike];
        //post syn
        [self.postManager postLikeChangeMethod:@"PUT" Tip:self.tip.tipId];
    }
    
   
    
}


-(void)didTapLike{
    self.likeButton.tintColor = [[UIColor alloc]initWithRed: 253.0/255.0 green:204.0/255.0 blue:1.0/255.0 alpha:1];
    self.likeButtonImage.tintColor = [[UIColor alloc]initWithRed: 253.0/255.0 green:204.0/255.0 blue:1.0/255.0 alpha:1];
}

-(void)willPlusLike{
    self.tip.likeInteger++;
   // NSLog(@"%@ and %lu", self.tip.likeInteger, self.tip.likeInteger);
    NSString *likeString = @"좋아요 ";
    likeString = [likeString stringByAppendingString: [NSString stringWithFormat:@"%lu", (unsigned long)self.tip.likeInteger]];
    self.likeButton.title = likeString;
    
}
-(void)willSubtractLike{
    self.tip.likeInteger = self.tip.likeInteger - 1;
   
    NSString *likeString = @"좋아요 ";
    if(self.tip.likeInteger > 0){
        likeString = [likeString stringByAppendingString: [NSString stringWithFormat:@"%lu", (unsigned long)self.tip.likeInteger]];
    }
    self.likeButton.title = likeString;
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
