//
//  RecommendUserCell.m
//  CanNotGetSister
//
//  Created by X-Liang on 16/1/29.
//  Copyright © 2016年 X-Liang. All rights reserved.
//

#import "RecommendUserCell.h"
#import "RecommendUser.h"
#import <UIImageView+WebCache.h>

@interface RecommendUserCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansLabel;
@end

@implementation RecommendUserCell

- (void)setUser:(RecommendUser *)user {
    _user = user;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    [self.nameLabel setText:user.screen_name];
    [self.fansLabel setText:[NSString stringWithFormat:@"%@人关注",user.fans_count]];
}

- (IBAction)flowBtn:(UIButton *)sender {
}
@end
