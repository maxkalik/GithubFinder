//
//  ViewController.m
//  GithubFinder
//
//  Created by Maksim Kalik on 12/21/20.
//

#import "HomeViewController.h"
#import "HTTPService.h"
#import "HomeTableViewCell.h"

@interface HomeViewController ()<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic, nullable) NSMutableArray *users;
@property (strong, nonatomic, nullable) NSTimer *timer;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self tableView].delegate = self;
    [self tableView].dataSource = self;
    [self searchBar].delegate = self;
    self.title = @"Github Finder";
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"HomeTableViewCell"];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
}

- (void)dismissKeyboard:(UITapGestureRecognizer *) sender {
    [self.searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if (!searchText.length) {
        self.users = nil;
        [self.tableView reloadData];
    }
    
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(searchForKeyword:) userInfo:searchText repeats:NO];
    
}

- (void)searchForKeyword:(NSTimer *)timer {
    NSString *keyword = timer.userInfo;
    NSLog(@"%@", keyword);
    
    if (keyword.length > 0) {
        [[HTTPService sharedInstance] fetchUsersByName:keyword :^(NSDictionary * _Nullable dataDict, NSString * _Nullable errorMessage) {
            if (dataDict) {
                NSNumber *totalCount = [dataDict objectForKey:@"total_count"];
                NSLog(@"%@", totalCount);
                if (totalCount > 0) {
                    NSMutableArray *items = [dataDict objectForKey:@"items"];
                    self.users = items;
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableView reloadData];                        
                    });

                }
            } else if (errorMessage) {
                    // Display alert
            }
        }];
    }
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    NSLog(@"text did end editing");
    [self.navigationController setNavigationBarHidden: NO animated:YES];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [self.navigationController setNavigationBarHidden: YES animated:YES];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTableViewCell"];
    // NSDictionary *user = [self.users objectAtIndex:indexPath.row];
    // NSLog(@"%@", user);
    // NSString *userUrl = [user objectForKey:@"url"];
    // [cell configureWithUserUrl:userUrl];
    [cell configureWithUserResponse:[self.users objectAtIndex:indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // NSLog(@"%lu", (unsigned long)self.users.count);
    return [self.users count];
    // return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSLog(@"%@", [self.users objectAtIndex:indexPath.row]);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 84.0;
}

@end
