//
//  User.m
//  GithubFinder
//
//  Created by Maksim Kalik on 12/21/20.
//

#import "User.h"
#import "NSDictionary+Safety.h"

@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        _bio = [dict safeObjectForKey:@"bio"];
        _name = [dict safeObjectForKey:@"name"];
        _login = [dict safeObjectForKey:@"login"];
        _location = [dict safeObjectForKey:@"location"];

        _publicRepos = [NSString stringWithFormat:@"%@", [dict safeObjectForKey:@"public_repos"]];
        _publicGists = [NSString stringWithFormat:@"%@", [dict safeObjectForKey:@"public_gists"]];
        _followers = [NSString stringWithFormat:@"%@", [dict safeObjectForKey:@"followers"]];
        _following = [NSString stringWithFormat:@"%@", [dict safeObjectForKey:@"following"]];
        
        _createdAt = [dict safeObjectForKey:@"created_at"];
        _avatarUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@", [dict safeObjectForKey:@"avatar_url"]]];
        _reposUrl = [dict safeObjectForKey:@"repos_url"];
    }
    return self;
}

@end
