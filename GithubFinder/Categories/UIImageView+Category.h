//
//  UIImageView+UIImageView.h
//  GithubFinder
//
//  Created by Maksim Kalik on 12/22/20.
//

#import <UIKit/UIKit.h>

typedef void (^complition)(void);

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Category)

-(void)loadFromUrl:(NSURL *)url: (nullable complition)completionHandler;

@end

NS_ASSUME_NONNULL_END
