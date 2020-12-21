//
//  HTTPService.m
//  GithubFinder
//
//  Created by Maksim Kalik on 12/21/20.
//

#import "HTTPService.h"

#define URL_BASE "https://api.github.com/"
#define USERS "users"
#define SEARCH "search/users"

@implementation HTTPService

- (instancetype)initPrivate {
    self = [super init];
    return self;
}

+ (instancetype)sharedInstance {
    static HTTPService *uniqueInstance = nil;
    
    // here I try to avoid multiple writes from the streams
    // all other streams will wait when first one will done
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        uniqueInstance = [[HTTPService alloc] initPrivate];
    });
    
    return uniqueInstance;
}

- (void)fetchUsers {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s%s", URL_BASE, USERS]];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data != nil) {
            NSError *err;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
            if (err == nil) {
                NSLog(@"JSON: %@", json);
            }
        }
    }] resume];
}

@end
