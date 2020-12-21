//
//  ViewController.m
//  GithubFinder
//
//  Created by Maksim Kalik on 12/21/20.
//

#import "HomeViewController.h"
#import "HTTPService.h"

@interface HomeViewController ()<UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic, nullable) NSTimer *timer;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchBar.delegate = self;
    
    self.title = @"Github Finder";
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.hidesBarsWhenKeyboardAppears = true;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    [self.view addGestureRecognizer:tap];
    
    // [[HTTPService sharedInstance] fetchUsersByName:@"maxkalik" :^(NSDictionary * _Nullable dataDict, NSString * _Nullable errorMessage) {
    //     if (dataDict) {
    // NSNumber *totalCount = [dataDict objectForKey:@"total_count"];
    // NSLog(@"%@", totalCount);
    //         NSArray *items = [dataDict objectForKey:@"items"];
    //         if (items.count > 0) {
    //             NSString *reposUrl = [items[0] objectForKey:@"repos_url"];
    //             // NSLog(@"%@", reposUrl);
    //
    //             [[HTTPService sharedInstance] fetchReposFromUrl:reposUrl :^(NSDictionary * _Nullable dataDict, NSString * _Nullable errorMessage) {
    //                 NSLog(@"%@", dataDict);
    //             }];
    //         }
    //     } else if (errorMessage) {
    //         // Display alert
    //     }
    // }];
}

- (void)dismissKeyboard:(UITapGestureRecognizer *) sender {
    [self.searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(searchForKeyword:) userInfo:searchText repeats:NO];
    
    // self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:NO block:^(NSTimer * _Nonnull timer) {
    //     NSLog(@"%@", searchText);
    // }];
    
}

- (void)searchForKeyword:(NSTimer *)timer {
    NSString *keyword = timer.userInfo;
    NSLog(@"%@", keyword);
    
    if (keyword.length > 0) {
        [[HTTPService sharedInstance] fetchUsersByName:keyword :^(NSDictionary * _Nullable dataDict, NSString * _Nullable errorMessage) {
            if (dataDict) {
                NSNumber *totalCount = [dataDict objectForKey:@"total_count"];
                NSLog(@"%@", totalCount);
                    // NSArray *items = [dataDict objectForKey:@"items"];
                    // if (items.count > 0) {
                    //     NSString *reposUrl = [items[0] objectForKey:@"repos_url"];
                    //     // NSLog(@"%@", reposUrl);
                    //
                    //     [[HTTPService sharedInstance] fetchReposFromUrl:reposUrl :^(NSDictionary * _Nullable dataDict, NSString * _Nullable errorMessage) {
                    //         NSLog(@"%@", dataDict);
                    //     }];
                    // }
            } else if (errorMessage) {
                    // Display alert
            }
        }];
    }
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    NSLog(@"text did end editing");
}

@end
