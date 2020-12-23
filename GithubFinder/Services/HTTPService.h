//
//  HTTPService.h
//  GithubFinder
//
//  Created by Maksim Kalik on 12/21/20.
//

#import <Foundation/Foundation.h>

typedef void (^onComplete)(NSDictionary * __nullable dataDict, NSString * __nullable errorMessage);

NS_ASSUME_NONNULL_BEGIN

@interface HTTPService : NSObject

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)sharedInstance;

- (void)fetchUsersByName:(NSString  *)userName :(nullable onComplete)completionHandler;
- (void)fetchUserInfoFromUrl:(NSString *)urlString :(nullable onComplete)completionHandler;

@end

NS_ASSUME_NONNULL_END
