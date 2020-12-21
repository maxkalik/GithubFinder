//
//  ViewController.m
//  GithubFinder
//
//  Created by Maksim Kalik on 12/21/20.
//

#import "ViewController.h"
#import "HTTPService.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[HTTPService sharedInstance] fetchUsersByName:@"maxkalik" :^(NSDictionary * _Nullable dataDict, NSString * _Nullable errorMessage) {
        if (dataDict) {
            NSArray *items = [dataDict objectForKey:@"items"];
            if (items.count > 0) {
                NSString *reposUrl = [items[0] objectForKey:@"repos_url"];
                // NSLog(@"%@", reposUrl);
                
                [[HTTPService sharedInstance] fetchReposFromUrl:reposUrl :^(NSDictionary * _Nullable dataDict, NSString * _Nullable errorMessage) {
                    NSLog(@"%@", dataDict);
                }];
            }
        } else if (errorMessage) {
            // Display alert
        }
    }];
    
}

@end
