//
//  HomeTableViewCell.h
//  GithubFinder
//
//  Created by Maksim Kalik on 12/22/20.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "UserResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeTableViewCell : UITableViewCell

// - (void)configureWithUserUrl:(nullable NSString *)url;
- (void)configureWithUserResponse:(UserResponse *)userResponse;

@end

NS_ASSUME_NONNULL_END
