//
//  NHTMyTipsController.h
//  NearHoneyTip
//
//  Created by yunseo shin on 2015. 12. 8..
//  Copyright © 2015년 Mamamoo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NHTTip;
@class NHTTipManager;

@interface NHTMyTipsController : UITableViewController

@property (strong, nonatomic) NHTTip *selectedTip;
@property (strong, nonatomic) NHTTipManager *Q1;


@end

