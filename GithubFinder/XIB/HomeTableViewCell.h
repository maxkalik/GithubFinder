//
//  HomeTableViewCell.h
//  GithubFinder
//
//  Created by Maksim Kalik on 12/22/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeTableViewCell : UITableViewCell

- (void)configureWithUserUrl:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
