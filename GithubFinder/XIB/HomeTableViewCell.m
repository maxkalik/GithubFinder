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

@interface HomeTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end


@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.avatarImgView.hidden = YES;
    [self.activityIndicator startAnimating];
    self.avatarImgView.layer.cornerRadius = 28;
    self.avatarImgView.layer.masksToBounds = YES;
}

- (void)configureWithUserResponse:(NSDictionary *)userResponse {
    NSString *avatarUrlString = [userResponse safeObjectForKey:@"avatar_url"];
    NSString *login = [userResponse safeObjectForKey:@"login"];
    NSURL *avatarUrl = [NSURL URLWithString:avatarUrlString];
    
    [self.avatarImgView loadFromUrl:avatarUrl];
    [self nameLabel].text = login;
    
    self.avatarImgView.hidden = NO;
    [self.activityIndicator stopAnimating];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
