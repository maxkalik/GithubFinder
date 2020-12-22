//
//  HomeTableViewCell.m
//  GithubFinder
//
//  Created by Maksim Kalik on 12/22/20.
//

#import "HomeTableViewCell.h"
#import "HTTPService.h"
#import "User.h"
#import "UIImageView+category.h"

@interface HomeTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end


@implementation HomeTableViewCell

- (void)configureWithUserResponse:(NSDictionary *)userResponse {
    NSString *avatarUrlString = [userResponse objectForKey:@"avatar_url"];
    NSString *login = [userResponse objectForKey:@"login"];
    NSURL *avatarUrl = [NSURL URLWithString:avatarUrlString];
    
    [self.avatarImgView loadFromUrl:avatarUrl];
    [self nameLabel].text = login;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
