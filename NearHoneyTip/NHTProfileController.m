//
//  NHTProfileController.m
//  NearHoneyTip
//
//  Created by yunseo shin on 2015. 12. 8..
//  Copyright © 2015년 Mamamoo. All rights reserved.
//

#import "NHTProfileController.h"
#import "NHTTip.h"
#import "NHTWriteViewController.h"
#import "TWPhotoPickerController.h"
#import "NHTMapSelectViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface NHTProfileController (){
    NSURLResponse *response2;
}
@end

@implementation NHTProfileController
@synthesize userNickname,inputText;

static NSString *boundary2 = @"!@#$@#!$@#!$1234567890982123456789!@#$#@$%#@";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *userId;
    NSString *userNickname2;
    NSString *userProfilePhoto;
    
    
    //Deligate
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    NSString *uidIdentifier = @"UserDefault";
    NSLog(@"******* UserDefault: %@",uidIdentifier);
    
    if([preferences objectForKey:uidIdentifier] != nil) {
        userId = [preferences objectForKey:uidIdentifier];
        userNickname2 = [preferences objectForKey:@"userNickname"];
        userProfilePhoto = [preferences objectForKey:@"userProfileImagePath"];
        
        NSLog(@"******* userNickname: %@", userNickname);
        NSLog(@"******* userProfileImagePath: %@",userProfilePhoto);
        
        userNickname.text = userNickname2;
        
        
        NSString *tipIconPathWhole = @"http://54.64.250.239:3000/image/icon=";
        NSUInteger pointOfPathStart = 5;
        NSString *tipImagePath = [userProfilePhoto substringFromIndex: pointOfPathStart];
        
        tipIconPathWhole = [tipIconPathWhole stringByAppendingString:tipImagePath];
        [self.userProfile sd_setImageWithURL:[NSURL URLWithString:tipIconPathWhole]
                            placeholderImage:[UIImage imageNamed:@"nht_logo.png"]];
        
        NSLog(@"userProfilePhoto : %@", 	userProfilePhoto);
        
        
        //imgView
        [self.userProfile setUserInteractionEnabled:YES];
        UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapping:)];
        [singleTap setNumberOfTapsRequired:1];
        [self.userProfile addGestureRecognizer:singleTap];
        
        
        
    }
}

-(void)singleTapping:(UIGestureRecognizer *)recognizer
{
    [self setCustomImagePicker2];
}

- (IBAction)profilePhotoEditButton:(id)sender {
    [self setCustomImagePicker2];
    
}


- (void)setCustomImagePicker2 {
    
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
                    [self.userProfile setImage:image];
                    _chosenImg = image;
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
        data = UIImageJPEGRepresentation(_chosenImg, 1.0);
        
        NSMutableDictionary *newTip = [[NSMutableDictionary alloc] init];
        [newTip setObject:userNickname forKey:@"nickname"];
        [newTip setObject:_userProfile forKey:@"profilephoto"];
        //        [newTip setObject:_userId forKey:@"uid"];
        //        [newTip setObject:data forKey:@"imageData"];
        
        NHTMapSelectViewController *mapViewController = (NHTMapSelectViewController *)segue.destinationViewController;
        mapViewController.tip = newTip;
    }
}

//- (IBAction)cancelWrite:(id)sender {
//    NSLog(@"%@",self.navigationController.viewControllers);
//    [self.navigationController popToRootViewControllerAnimated:YES];
//}

- (IBAction)cancelEdit:(id)sender{
    NSLog(@"%@",self.navigationController.viewControllers);
    [self.navigationController popToRootViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"backFromEdit" object:self];
}

- (IBAction)saveEdit:(id)sender{
    [self editProfile:nil];
    
    
}

- (void) editProfile:(NSDictionary *)tipDictionary {
    NSLog(@"< start profile Edit >");
    NSMutableData* body = [NSMutableData data];
    NSData *data2 = tipDictionary[@"imageData"];
    
    if (data2) {
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary2] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"upload\"; filename=\"%@.jpg\"\r\n", tipDictionary[@"storename"]] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[NSData dataWithData:data2]];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    //    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary2] dataUsingEncoding:NSUTF8StringEncoding]];
    //    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"storename\"\r\n\r\n%@", tipDictionary[@"storename"]] dataUsingEncoding:NSUTF8StringEncoding]];
    //
    //    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary2] dataUsingEncoding:NSUTF8StringEncoding]];
    //    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"tipdetail\"\r\n\r\n%@", tipDictionary[@"detail"]] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary2] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"uid\"\r\n\r\n%@", tipDictionary[@"uid"]] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSLog(@"< stipDictionary uid >: %@", tipDictionary[@"uid"]);
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary2] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"nickname\"\r\n\r\n%@", tipDictionary[@"nickname"]] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary2] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"profilephoto\"\r\n\r\n%@", tipDictionary[@"profilephoto"]] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary2] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [self putFormDataAtURL:[NSURL URLWithString:@"http://54.64.250.239:3000/users/_id=9ABC1F3F-886F-4D0A-A307-1F75A49BA2BC"] putData:body];
}



- (void)putFormDataAtURL :(NSURL *)url putData:(NSData*)putData {
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"PUT";
    NSString* contentType2 = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary2];
    [request addValue:contentType2 forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:putData];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request
                                                                  delegate:self];
    [connection start];
    [self connection:connection didReceiveResponse:response2];
    NSLog(@"connection end");
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    long code = [httpResponse statusCode];
    NSLog(@"connection response: %ld", code);
    
    if(code == 200){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"backFromWrite" object:self];
    }
}

- (IBAction)backgroundSender:(id)sender {
    
    [inputText resignFirstResponder];
    //tab gesture 로 대체
    
}

- (IBAction)NicknameEditButton:(id)sender {
    NSString * input=inputText.text;
    userNickname.text=input;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnLoad {
    //    [self setuserNickname:nil];
    [self setInputText:nil];
    [super viewDidLoad];
    
}

@end
