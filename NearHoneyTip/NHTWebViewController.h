//
//  NHTWebViewController.h
//  NearHoneyTip
//
//  Created by yunseo shin on 2015. 12. 23..
//  Copyright © 2015년 Mamamoo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NHTTip;

@interface NHTWebViewController : UIViewController

@property (strong, nonatomic) NHTTip *selectedTip;
@property (weak, nonatomic) IBOutlet UIWebView *myPage;

@end