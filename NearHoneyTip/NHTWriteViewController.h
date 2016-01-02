//
//  NHTViewController.h
//  NearHoneyTip
//
//  Created by Eunjoo Im on 2015. 11. 22..
//  Copyright © 2015년 Mamamoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomeImagePicker.h"

@interface NHTWriteViewController : UIViewController <UINavigationControllerDelegate,
UIImagePickerControllerDelegate, CustomeImagePickerDelegate>

@property (strong, nonatomic) IBOutlet UITextField *storeName;
@property (strong, nonatomic) IBOutlet UITextField *detail;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIImage *chosenImage;

- (IBAction)cancelWrite:(id)sender;
//- (IBAction) pickImage:(id)sender;


@end