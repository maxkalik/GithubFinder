//
//  User.m
//  GithubFinder
//
//  Created by Maksim Kalik on 12/21/20.
//

#import "User.h"

@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        _name = dict[@"name"];
        _bio = dict[@"bio"];
        _publicRepos = dict[@"public_repos"];
        _location = dict[@"location"];
        _reposUrl = dict[@"repos_url"];
        _login = dict[@"login"];
        _createdAt = dict[@"created_at"];
        _avatarUrl = dict[@"avatar_url"];
    }
    return self;
}

@end
