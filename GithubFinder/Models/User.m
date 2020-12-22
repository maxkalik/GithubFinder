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
        _bio = dict[@"bio"];
        _name = dict[@"name"];
        _login = dict[@"login"];
        _location = dict[@"location"];

        _publicRepos = dict[@"public_repos"];
        _publicGists = dict[@"public_gists"];
        _followers = dict[@"followers"];
        _following = dict[@"following"];
        
        _createdAt = dict[@"created_at"];
        _avatarUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@", dict[@"avatar_url"]]];
        _reposUrl = dict[@"repos_url"];
    }
    return self;
}

@end
