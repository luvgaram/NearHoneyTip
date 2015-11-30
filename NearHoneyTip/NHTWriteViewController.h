//
//  NHTViewController.h
//  NearHoneyTip
//
//  Created by Eunjoo Im on 2015. 11. 22..
//  Copyright © 2015년 Mamamoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NHTWriteViewController : UIViewController <UINavigationControllerDelegate,
UIImagePickerControllerDelegate>
@property (strong, nonatomic) IBOutlet UITextField *storeName;
@property (strong, nonatomic) IBOutlet UITextField *detail;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIImage *chosenImage;

- (IBAction)saveTip:(id)sender;
- (IBAction)cancelWrite:(id)sender;
//- (IBAction) pickImage:(id)sender;


@end