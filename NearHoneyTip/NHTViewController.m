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

@implementation NHTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
                   editingInfo:(NSDictionary *)editingInfo
{
    self.imageView.image = image;
    [self dismissModalViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
