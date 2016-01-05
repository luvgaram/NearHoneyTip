//
//  NHTReplyViewController.h
//  NearHoneyTip
//
//  Created by Eunjoo Im on 2016. 1. 5..
//  Copyright © 2016년 Mamamoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NHTReplyViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *replyText;
- (IBAction)sendReply:(id)sender;

@property (nonatomic, strong) NSArray *NHTRepliesArray;
@property (nonatomic, strong) NSString *NHTReplyTipId;


@end
