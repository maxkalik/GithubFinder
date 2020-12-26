//
//  UserResponse.m
//  GithubFinder
//
//  Created by Maksim Kalik on 12/24/20.
//

#import "UserResponse.h"
#import "NSDictionary+Safety.h"


@implementation UserResponse

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        _login = [dict safeObjectForKey:@"login"];
        _avatarUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@", [dict safeObjectForKey:@"avatar_url"]]];
        _url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", [dict safeObjectForKey:@"url"]]];
    }
    return self;
}

@end
