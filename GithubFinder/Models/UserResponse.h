//
//  UserResponse.h
//  GithubFinder
//
//  Created by Maksim Kalik on 12/24/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserResponse : NSObject

@property (nonatomic, strong) NSString *login;
@property (nonatomic, strong) NSURL *avatarUrl;
@property (nonatomic, strong) NSURL *url;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
