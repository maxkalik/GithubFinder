//
//  DetailsHelper.h
//  GithubFinder
//
//  Created by Maksim Kalik on 12/22/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailsHelper : NSObject

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)sharedInstance;

// Methods
- (CGAffineTransform)transformImageView:(UIImageView *)imageView :(UIScrollView *)scrollView;

@end

NS_ASSUME_NONNULL_END
