//
//  HomeTableViewCell.m
//  GithubFinder
//
//  Created by Maksim Kalik on 12/22/20.
//

#import "HomeTableViewCell.h"
#import "User.h"

@interface HomeTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bioLabel;

@end


@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configureWithUserUrl:(NSString *)url {
    NSLog(@"%@", url);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
