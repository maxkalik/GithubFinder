//
//  User.h
//  GithubFinder
//
//  Created by Maksim Kalik on 12/21/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *bio;
@property (nonatomic, strong) NSNumber *publicRepos;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *reposUrl;
@property (nonatomic, strong) NSString *login;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSString *avatarUrl;

@end

NS_ASSUME_NONNULL_END
