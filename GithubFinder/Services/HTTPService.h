//
//  HTTPService.h
//  GithubFinder
//
//  Created by Maksim Kalik on 12/21/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTTPService : NSObject

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)sharedInstance;

- (void)fetchUsers;

@end

NS_ASSUME_NONNULL_END
