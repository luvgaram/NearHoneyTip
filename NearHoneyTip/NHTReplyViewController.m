//
//  NHTReplyViewController.m
//  NearHoneyTip
//
//  Created by Eunjoo Im on 2016. 1. 5..
//  Copyright © 2016년 Mamamoo. All rights reserved.
//

#import "NHTReplyViewController.h"
#import "NHTReply.h"
#import "NHTReplyTableCell.h"

@interface NHTReplyViewController ()

@end

@implementation NHTReplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"replyView: %d", [self.NHTRepliesArray count]);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 68;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"count: %d", [self.NHTRepliesArray count]);
    return [self.NHTRepliesArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"replyCell";
    NHTReplyTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[NHTReplyTableCell alloc] init];
    }
    [cell setCellWithReply:self.NHTRepliesArray[indexPath.row]];
    
    NSLog(@"cell: %@", cell);
    
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
