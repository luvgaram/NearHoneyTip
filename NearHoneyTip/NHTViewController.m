//
//  NHTViewController.m
//  NearHoneyTip
//
//  Created by Eunjoo Im on 2015. 11. 22..
//  Copyright © 2015년 Mamamoo. All rights reserved.
//

#import "NHTViewController.h"

@interface NHTViewController ()

@end

static NSString *boundary = @"!@#$@#!$@#!$1234567890982123456789!@#$#@$%#@";

@implementation NHTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)saveTip:(id)sender {
    NSData *data = UIImageJPEGRepresentation([UIImage imageNamed:@"ib_addphoto"], 1.0);
    
    if (_chosenImage) {
        data = UIImageJPEGRepresentation(_chosenImage, 1.0);
    }

    
    NSDictionary *tipDictionary = @{ @"storeName":_storeName.text,
                                        @"detail":_detail.text,
                                        @"imageData":data
                                     };
    [self postTip:tipDictionary];
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
    NSLog(@"connection end");
}

- (void) postTip:(NSDictionary *)tipDictionary {
    
    NSLog(@"start post");
    
    NSMutableData* body = [NSMutableData data];
    NSData *data = tipDictionary[@"imageData"];
    if (data) {
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"upload\"; filename=\"%@.jpg\"\r\n", tipDictionary[@"storeName"]] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[NSData dataWithData:data]];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"storename\"\r\n\r\n%@", tipDictionary[@"storeName"]] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"tipdetail\"\r\n\r\n%@", tipDictionary[@"detail"]] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [self postFormDataAtURL:[NSURL URLWithString:@"http://54.64.250.239:3000/tip"]
                   postData:body
               ];
}

- (IBAction) pickImage:(id)sender{
    
    UIImagePickerController *pickerController = [[UIImagePickerController alloc]
                                                 init];
    pickerController.delegate = self;
    [self presentViewController:pickerController animated:YES completion:nil];
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate

- (void) imagePickerController:(UIImagePickerController *)picker
         didFinishPickingImage:(UIImage *)image
                   editingInfo:(NSDictionary *)editingInfo {
    _chosenImage = image;
    self.imageView.image = image;
    [self dismissModalViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
