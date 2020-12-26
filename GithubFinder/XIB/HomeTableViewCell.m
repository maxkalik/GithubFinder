//
//  HomeTableViewCell.m
//  GithubFinder
//
//  Created by Maksim Kalik on 12/22/20.
//

#import "HomeTableViewCell.h"
#import "HTTPService.h"
#import "User.h"
#import "UIImageView+Category.h"
#import "NSDictionary+Safety.h"
#import "UserResponse.h"

@interface HomeTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end


@implementation HomeTableViewCell

- (void)prepareForReuse {
    [super prepareForReuse];
    // [UIImage imageNamed:[NSString stringWithFormat:@"%@", self.avatarImgView.image]];
    self.avatarImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", self.avatarImgView.image]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // [UIImage imageNamed:[NSString stringWithFormat:@"%@", self.avatarImgView.image]];
    self.avatarImgView.hidden = YES;
    [self.activityIndicator startAnimating];
    self.avatarImgView.layer.cornerRadius = 28;
    self.avatarImgView.layer.masksToBounds = YES;
}

- (void)configureWithUserResponse:(UserResponse *)userResponse {
    [self.avatarImgView loadFromUrl:userResponse.avatarUrl];
    [self nameLabel].text = userResponse.login;
    
    self.avatarImgView.hidden = NO;
    [self.activityIndicator stopAnimating];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
