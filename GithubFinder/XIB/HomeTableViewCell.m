//
//  HomeTableViewCell.m
//  GithubFinder
//
//  Created by Maksim Kalik on 12/22/20.
//

#import "HomeTableViewCell.h"
#import "HTTPService.h"
#import "User.h"

@interface HomeTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end


@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

// - (void)configureWithUserUrl:(nullable NSString *)url {
    // if (url != nil) {
        // [[HTTPService sharedInstance] fetchReposFromUrl:url :^(NSDictionary * _Nullable dataDict, NSString * _Nullable errorMessage) {
        //
        //     NSLog(@"%@", dataDict);
        //
        //     if (dataDict != nil) {
        //         NSString * _Nullable name = [dataDict objectForKey:@"name"];
        //         NSString * _Nullable bio = [dataDict objectForKey:@"bio"];
        //
        //         if (name != nil || bio != nil) {
        //             NSLog(@"%@ %@", name, bio);
        //             dispatch_async(dispatch_get_main_queue(), ^{
        //                 self.nameLabel.text = name;
        //                 // self.bioLabel.text = bio;
        //             });
        //         }
        //     } else if (errorMessage) {
        //             // show nothing
        //     }
        // }];
    // }
// }

- (void)configureWithUserResponse:(NSDictionary *)userResponse {
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        
            // Background Thread
        NSString *avatarUrlString = [userResponse objectForKey:@"avatar_url"];
        NSURL *avatarUrl = [NSURL URLWithString:avatarUrlString];
        NSData *data = [NSData dataWithContentsOfURL:avatarUrl];
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            // UI Updates
            self.avatarImgView.image = [[UIImage alloc] initWithData:data];
        });
    });
    
    
    NSString *login = [userResponse objectForKey:@"login"];
    [self nameLabel].text = login;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
