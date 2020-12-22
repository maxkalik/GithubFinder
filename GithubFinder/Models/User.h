//
//  User.h
//  GithubFinder
//
//  Created by Maksim Kalik on 12/21/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

@property (nonatomic, strong) NSString *bio;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *reposUrl;
@property (nonatomic, strong) NSString *login;

@property (nonatomic, strong) NSNumber *followers;
@property (nonatomic, strong) NSNumber *following;
@property (nonatomic, strong) NSNumber *publicRepos;
@property (nonatomic, strong) NSNumber *publicGists;

@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSURL *avatarUrl;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
