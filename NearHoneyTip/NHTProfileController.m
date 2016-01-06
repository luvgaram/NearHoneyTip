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
    NSURLResponse *profileResponse;
}
@end

@implementation NHTProfileController
@synthesize userNickname,inputText;
NSString *profileUserId;
NSString *profileUserNickname;
NSString *profileUserPhoto;

static NSString *profileBoundary = @"!@#$@#!$@#!$1234567890982123456789!@#$#@$%#@";

- (void)viewDidLoad {
    [super viewDidLoad];

    //Deligate
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    NSString *uidIdentifier = @"UserDefault";
    NSLog(@"******* UserDefault: %@",uidIdentifier);
    
    if([preferences objectForKey:uidIdentifier] != nil) {
        profileUserId = [preferences objectForKey:uidIdentifier];
        profileUserNickname = [preferences objectForKey:@"userNickname"];
        profileUserPhoto = [preferences objectForKey:@"userProfileImagePath"];
        
        NSLog(@"******* userNickname: %@", userNickname);
        NSLog(@"******* userProfileImagePath: %@",profileUserPhoto);
        
        userNickname.text = profileUserNickname;
        
        
        NSString *tipIconPathWhole = @"http://54.64.250.239:3000/image/icon=";
        NSUInteger pointOfPathStart = 5;
        NSString *tipImagePath = [profileUserPhoto substringFromIndex: pointOfPathStart];
        
        tipIconPathWhole = [tipIconPathWhole stringByAppendingString:tipImagePath];
        [self.userProfile sd_setImageWithURL:[NSURL URLWithString:tipIconPathWhole]
                            placeholderImage:[UIImage imageNamed:@"nht_logo.png"]];
        
        NSLog(@"userProfilePhoto : %@", profileUserPhoto);
        
        //imgView
        [self.userProfile setUserInteractionEnabled:YES];
        UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapping:)];
        [singleTap setNumberOfTapsRequired:1];
        [self.userProfile addGestureRecognizer:singleTap];
    }
}

-(void)singleTapping:(UIGestureRecognizer *)recognizer {
    [self setCustomImagePicker];
}

- (IBAction)profilePhotoEditButton:(id)sender {
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

- (IBAction)cancelEdit:(id)sender{
    NSLog(@"%@",self.navigationController.viewControllers);
    [self.navigationController popToRootViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"backFromEdit" object:self];
}

- (IBAction)saveEdit:(id)sender{
    NSMutableDictionary *newUserProfile = [[NSMutableDictionary alloc] init];
    [newUserProfile setObject:userNickname.text forKey:@"nickname"];
    
    NSLog(@"nickname: %@", [newUserProfile objectForKey:@"nickname"]);
    [self editProfile:newUserProfile];
}

- (void) editProfile:(NSDictionary *)tipDictionary {
    NSLog(@"< start profile Edit >");
    NSString *baseURL = @"http://54.64.250.239:3000/users/_id=";
    baseURL = [baseURL stringByAppendingString:profileUserId];
    
    NSMutableData* body = [NSMutableData data];
    NSData *data = UIImageJPEGRepresentation(_chosenImg, 1.0);
    
    if (data) {
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", profileBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"upload\"; filename=\"%@.jpg\"\r\n", tipDictionary[@"storename"]] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[NSData dataWithData:data]];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", profileBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"nickname\"\r\n\r\n%@", tipDictionary[@"nickname"]] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", profileBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [self putFormDataAtURL:[NSURL URLWithString:baseURL] putData:body];
}



- (void)putFormDataAtURL :(NSURL *)url putData:(NSData*)putData {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"PUT";
    NSString* contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", profileBoundary];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:putData];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request
                                                                  delegate:self];
    [connection start];
    [self connection:connection didReceiveResponse:profileResponse];
    NSLog(@"connection end");
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    long code = [httpResponse statusCode];
    NSLog(@"connection response: %ld", code);
    
    if(code == 200){
        [self.navigationController popToRootViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"backFromEdit" object:self];
        
    }
}

- (IBAction)backgroundSender:(id)sender {
    
    [inputText resignFirstResponder];
    //tab gesture 로 대체
    
}

- (IBAction)NicknameEditButton:(id)sender {
    NSString *input = inputText.text;
    userNickname.text = input;
    
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
