//
//  TypographyHelper.h
//  GithubFinder
//
//  Created by Maksim Kalik on 12/24/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TypographyHelper : NSObject

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)sharedInstance;
- (NSMutableAttributedString *)makeLineHeight:(double)height forString:(NSString *)string;
- (NSString *)parseDateString:(NSString *)dateString;

@end

NS_ASSUME_NONNULL_END
