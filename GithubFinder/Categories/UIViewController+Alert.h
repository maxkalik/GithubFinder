//
//  UIViewController+Alert.h
//  GithubFinder
//
//  Created by Maksim Kalik on 12/26/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^completion)(UIAlertAction *);

@interface UIViewController (Alert)

- (void)simpleAlertWithTitle:(NSString *)title withMessage :(NSString *)message :(nullable completion)completionHandler;

@end

NS_ASSUME_NONNULL_END
