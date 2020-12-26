//
//  HTTPService.m
//  GithubFinder
//
//  Created by Maksim Kalik on 12/21/20.
//

//https://api.github.com/search/users?q=max

#import "HTTPService.h"

#define URL_BASE "https://api.github.com/"
#define USERS "users"
#define GISTS "gists/"
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

- (void)fetchUsersByName:(NSString  *)userName :(nullable onComplete)completionHandler {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s%s?q=%@", URL_BASE, SEARCH, userName]];
    [self fetchDataFromUrl:url :^(NSDictionary * _Nullable dataDict, NSString * _Nullable errorMessage) {
        completionHandler(dataDict, errorMessage);
    }];
}

- (void)fetchUsersByName:(NSString  *)userName fromPage:(int)page withAmount:(int)amount :(nullable onComplete)completionHandler {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s%s?q=%@&page=%li&per_page=%li", URL_BASE, SEARCH, userName, (long)page, (long)amount]];
    [self fetchDataFromUrl:url :^(NSDictionary * _Nullable dataDict, NSString * _Nullable errorMessage) {
        completionHandler(dataDict, errorMessage);
    }];
}

// page=3&per_page=100

- (void)fetchUserInfoFromUrl:(NSURL *)url :(nullable onComplete)completionHandler {
    [self fetchDataFromUrl:url :^(NSDictionary * _Nullable dataDict, NSString * _Nullable errorMessage) {
        completionHandler(dataDict, errorMessage);
    }];
}

- (void)fetchDataFromUrl:(NSURL *)url :(nullable onComplete)completionHandler {
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data != nil) {
            NSError *err;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
            
            if (err == nil) {
                completionHandler(json, nil);
            } else {
                completionHandler(nil, @"Data is not readable for this time");
            }
        } else {
            NSLog(@"Network error: %@", error.debugDescription);
            completionHandler(nil, @"Problem connecting to the server");
        }
    }] resume];
}

@end
