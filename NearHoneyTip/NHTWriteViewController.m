//
//  NHTViewController.m
//  NearHoneyTip
//
//  Created by Eunjoo Im on 2015. 11. 22..
//  Copyright © 2015년 Mamamoo. All rights reserved.
//

#import "NHTWriteViewController.h"
#import "TWPhotoPickerController.h"

@interface NHTWriteViewController (){
    NSURLResponse *response;
}

@end

static NSString *boundary = @"!@#$@#!$@#!$1234567890982123456789!@#$#@$%#@";

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

-(void) imageSelected:(NSArray *)arrayOfImages
{
    int count = 0;
    for(NSString *imageURLString in arrayOfImages)
    {
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
-(void) imageSelectionCancelled
{
    
}

- (IBAction)saveTip:(id)sender {
    NSData *data = UIImageJPEGRepresentation([UIImage imageNamed:@"ib_addphoto"], 1.0);
    
    if (_chosenImage) {
        data = UIImageJPEGRepresentation(_chosenImage, 1.0);
        NSDictionary *tipDictionary = @{
                                        @"nickname":nickname,
                                        @"profilephoto":profilephoto,
                                        @"longitude":[NSNumber numberWithFloat:longitude],
                                        @"latitude":[NSNumber numberWithFloat:latitude],
                                        @"uid":uid,
                                        @"storename":_storeName.text,
                                        @"detail":_detail.text,
                                        @"imageData":data
                                        };
        [self postTip:tipDictionary];
        NSLog(@"saving tip for %@, uid: %@", _storeName.text, [tipDictionary objectForKey:(@"uid")]);
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    } else {
        NSLog(@"no image");
    }
    
    
}

- (IBAction)cancelWrite:(id)sender {
    NSLog(@"%@",self.navigationController.viewControllers);
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"backFromWrite" object:self];
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

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    long code = [httpResponse statusCode];
    NSLog(@"connection response: %ld", code);
    
    if(code == 200){
        
    [[NSNotificationCenter defaultCenter] postNotificationName:@"backFromWrite" object:self];
    }
    
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
    
   
}

@end
