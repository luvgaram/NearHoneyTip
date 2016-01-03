//
//  NHTMainTableCell.m
//  NearHoneyTip
//
//  Created by Kate KyuWon on 11/30/15.
//  Copyright © 2015 Mamamoo. All rights reserved.
//

#import "NHTMainTableCell.h"
#import "NHTTip.h"
#import "NHTButtonTapPost.h"
#import <SDWebImage/UIImageView+WebCache.h>

#import "NHTMainViewController.h"


@implementation NHTMainTableCell{
    NSUserDefaults *preferences;
}

- (void)setCellWithTip:(NHTTip*)tip{
    
    self.postManager = [[NHTButtonTapPost alloc] init];
    self.tip = tip;
   
    // modified by ej
    //    self.tipImage.image = self.tip.tipImage;
    
    NSString *tipImagePathWhole = @"http://54.64.250.239:3000/image/photo=";
    tipImagePathWhole = [tipImagePathWhole stringByAppendingString:self.tip.tipImage];
    [self.tipImage sd_setImageWithURL:[NSURL URLWithString:tipImagePathWhole]
                     placeholderImage:[UIImage imageNamed:@"nht_logo.png"]];
    
    self.storeName.text = self.tip.storeName;
    
    //self.tipDetails.font = [UIFont fontWithName:@"Apple SD Gothic Neo SemiBold" size:100];//it doesn't work
    self.tipDetails.text = self.tip.tipDetails;
    self.userProfileImage.layer.cornerRadius = 16;
//    self.userProfileImage.image = self.tip.userProfileImg;
    
    NSString *tipIconPathWhole = @"http://54.64.250.239:3000/image/icon=";
    tipIconPathWhole = [tipIconPathWhole stringByAppendingString:self.tip.userProfileImg];
    [self.userProfileImage sd_setImageWithURL:[NSURL URLWithString:tipIconPathWhole]
                     placeholderImage:[UIImage imageNamed:@"nht_logo.png"]];
    
    self.userNickname.text = self.tip.userNickname;
    self.tipDate.text = self.tip.tipDate;
    
    NSString *distanceWithKm = [NSString stringWithFormat:@"%lu", (unsigned long)self.tip.distance];
    distanceWithKm = [distanceWithKm stringByAppendingString:@" m"];
    
    self.distance.text = distanceWithKm;
    
    [self setLikeButtonProperty];
    
    UITapGestureRecognizer *tapLikeButton = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapLike:)];
    self.likeButton.gestureRecognizers = [[NSArray alloc] initWithObjects: tapLikeButton, nil];
    
  
    [self setReplyButtonProperty];
}

-(void)setLikeButtonProperty{
    
    NSString *likeString = @"좋아요 ";
    NSString *likeCount;
   
    
    UIImage *likeTintImage = [UIImage imageNamed:@"likeDefault"];
    [self.likeButton setImage:likeTintImage forState:UIControlStateNormal];
    
    
    if (self.tip.likeInteger <= 0){
        likeCount = @"";
    } else {
        likeCount = [NSString stringWithFormat:@"%lu", (unsigned long)self.tip.likeInteger];
    }
    likeString = [likeString stringByAppendingString:likeCount];
    [self.likeButton setTitle:likeString forState:UIControlStateNormal];
    
    if (self.tip.isLiked){
        [self didTapLike];
    }
    
}

-(void)setReplyButtonProperty{
    
    NSString *replyString = @"댓글";
    NSString *replyCount;
    
    if(self.tip.replyInteger){
        
        if(self.tip.replyInteger > 0){
            replyCount = [NSString stringWithFormat:@"%ld", (long)self.tip.replyInteger];
        } else {
            replyCount = @"";
        }
        
    } else {
        replyCount = @"";
    }
    
    replyString = [replyString stringByAppendingString:replyCount];
    [self.commentButton setTitle:replyString forState:UIControlStateNormal];
}



-(void)didTapLike:(UITapGestureRecognizer *)recognizer{
    NSLog(@"#####Tap like recog: %@", recognizer);
    if( self.tip.isLiked == NO){
        self.tip.isLiked = YES;
        UIImage *likeTintImage = [UIImage imageNamed:@"likeTint"];
        [self.likeButton setImage:likeTintImage forState:UIControlStateNormal];
        [self willPlusLike];
        //post syn
        [self.postManager postLikeChangeMethod:@"POST" Tip:self.tip.tipId];
        //  [NSNotification
        
    } else {
        self.tip.isLiked = NO;
        UIImage *likeDefalut = [UIImage imageNamed:@"likeDefault"];
        [self.likeButton setImage:likeDefalut forState:UIControlStateNormal];
        [self willSubtractLike];
        //post syn
        [self.postManager postLikeChangeMethod:@"PUT" Tip:self.tip.tipId];
    }
    

}

-(void)willPlusLike{
    self.tip.likeInteger = self.tip.likeInteger + 1 ;
    NSString *likeString = @"좋아요 ";
    likeString = [likeString stringByAppendingString: [NSString stringWithFormat:@"%lu", (unsigned long)self.tip.likeInteger]];
    [self.likeButton setTitle:likeString forState:UIControlStateNormal];
    
    
}
-(void)willSubtractLike{
    self.tip.likeInteger = self.tip.likeInteger - 1;
    NSString *likeString = @"좋아요 ";
    if(self.tip.likeInteger > 0){
        likeString = [likeString stringByAppendingString: [NSString stringWithFormat:@"%lu", (unsigned long)self.tip.likeInteger]];
    }
    [self.likeButton setTitle:likeString forState:UIControlStateNormal];
    
}
-(void)didTapLike{

    UIImage *likeTintImage = [UIImage imageNamed:@"likeTint"];
    [self.likeButton setImage:likeTintImage forState:UIControlStateNormal];

}
@end
