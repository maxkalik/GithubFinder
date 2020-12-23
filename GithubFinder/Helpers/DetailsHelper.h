//
//  DetailsHelper.h
//  GithubFinder
//
//  Created by Maksim Kalik on 12/22/20.
//

#import <UIKit/UIKit.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsHelper : NSObject

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)sharedInstance;

// Methods
- (CATransform3D)scaleImageViewOnScroll:(UIImageView *)imageView :(UIScrollView *)scrollView;
- (NSArray *)prepareLabelTextFromUserData:(User *)user :(NSString *)labelGroup;
- (NSArray *)prepareLabelsContentWithTextArray:(NSArray<NSString *> *)text andLabels:(NSArray<UILabel *> *)labels;

@end

NS_ASSUME_NONNULL_END
