//
//  NHTViewController.m
//  NearHoneyTip
//
//  Created by Eunjoo Im on 2015. 11. 22..
//  Copyright © 2015년 Mamamoo. All rights reserved.
//

#import "NHTWriteViewController.h"
#import "TWPhotoPickerController.h"
#import "NHTMapSelectViewController.h"

@interface NHTWriteViewController ()

@end

@implementation NHTWriteViewController

NSString *uid;
NSString *nickname;
NSString *profilephoto;
float latitude;
float longitude;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomImagePicker];
    
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    NSString *uidIdentifier = @"UserDefault";
    NSString *userLatitudeIdentifier = @"UserLocationLatitude";
    NSString *userLongitudeIdentifier = @"UserLocationLongitude";
    
    if([preferences objectForKey:uidIdentifier] != nil) {
        uid = [preferences objectForKey:uidIdentifier];
        nickname = [preferences objectForKey:@"userNickname"];
        profilephoto = [preferences objectForKey:@"userProfileImagePath"];
        latitude = [preferences floatForKey:userLatitudeIdentifier];
        longitude = [preferences floatForKey:userLongitudeIdentifier];
    }
    
    [self.imageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapping:)];
    [singleTap setNumberOfTapsRequired:1];
    [self.imageView addGestureRecognizer:singleTap];
    }

-(void)singleTapping:(UIGestureRecognizer *)recognizer
{
    [self setCustomImagePicker];
}

- (void)setCustomImagePicker {
    CustomeImagePicker *cip = [[CustomeImagePicker alloc] init];
    cip.delegate = self;
    [cip setHideSkipButton:NO];
    [cip setHideNextButton:NO];
    [cip setMaxPhotos:MAX_ALLOWED_PICK];
    [cip setShowOnlyPhotosWithGPS:NO];
    
    [self presentViewController:cip animated:YES completion:^{
    }
     ];
}

-(void) imageSelected:(NSArray *)arrayOfImages {
    int count = 0;
    for(NSString *imageURLString in arrayOfImages) {
        // Asset URLs
        ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
        [assetsLibrary assetForURL:[NSURL URLWithString:imageURLString] resultBlock:^(ALAsset *asset) {
            ALAssetRepresentation *representation = [asset defaultRepresentation];
            CGImageRef imageRef = [representation fullScreenImage];
            UIImage *image = [UIImage imageWithCGImage:imageRef];
            if (imageRef) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.imageView setImage:image];
                    _chosenImage = image;
                });
            } // Valid Image URL
        } failureBlock:^(NSError *error) {
        }];
        count++;
    }
}
-(void) imageSelectionCancelled {
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showTipMap"]) {
        NSData *data = UIImageJPEGRepresentation([UIImage imageNamed:@"ib_addphoto"], 1.0);
        data = UIImageJPEGRepresentation(_chosenImage, 1.0);
        
        NSMutableDictionary *newTip = [[NSMutableDictionary alloc] init];
        [newTip setObject:nickname forKey:@"nickname"];
        [newTip setObject:profilephoto forKey:@"profilephoto"];
        [newTip setObject:uid forKey:@"uid"];
        [newTip setObject:_storeName.text forKey:@"storename"];
        [newTip setObject:_detail.text forKey:@"detail"];
        [newTip setObject:data forKey:@"imageData"];

        NHTMapSelectViewController *mapViewController = (NHTMapSelectViewController *)segue.destinationViewController;
        mapViewController.tip = newTip;
    }
}

- (IBAction)cancelWrite:(id)sender {
    NSLog(@"%@",self.navigationController.viewControllers);
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"backFromWrite" object:self];
}

@end
