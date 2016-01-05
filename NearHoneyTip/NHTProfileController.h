//
//  NHTProfileController.h
//  NearHoneyTip
//
//  Created by yunseo shin on 2015. 12. 8..
//  Copyright © 2015년 Mamamoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomeImagePicker.h"

@interface NHTProfileController : UIViewController<UINavigationControllerDelegate,
UIImagePickerControllerDelegate, UITextFieldDelegate, CustomeImagePickerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *userProfile;
@property (weak, nonatomic) IBOutlet UILabel *userNickname; //outputLabel
@property (strong, nonatomic) UIImage *chosenImg;
@property (weak, nonatomic) IBOutlet UITextField *inputText;
//@property (weak, nonatomic) IBOutlet UIImageView *imgView;

- (IBAction)profilePhotoEditButton:(id)sender;
- (IBAction)NicknameEditButton:(id)sender;
- (IBAction)back:(id)sender;
- (IBAction)cancelEdit:(id)sender;
- (IBAction)saveEdit:(id)sender;

- (void) connection:(NSURLConnection *) connection didReceiveResponse:(nonnull NSURLResponse *)response2;


@end


