//
//  NHTWriteViewController.h
//  NearHoneyTip
//
//  Created by Eunjoo Im on 2015. 11. 22..
//  Copyright © 2015년 Mamamoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UINavigationControllerDelegate,
UIImagePickerControllerDelegate>


@property (strong, nonatomic) IBOutlet UIImageView* imageView;

- (IBAction) pickImage:(id)sender;


@end
