//
//  ViewController.m
//  GithubFinder
//
//  Created by Maksim Kalik on 12/21/20.
//

#import "HomeViewController.h"
#import "HTTPService.h"
#import "HomeTableViewCell.h"
#import "DetailsViewController.h"

@interface HomeViewController ()<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
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
    
    [self tableView].separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.title = @"Github Finder";
    
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"HomeTableViewCell"];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self.searchBar action:@selector(resignFirstResponder)];
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolbar.items = [NSArray arrayWithObject:barButton];

    self.searchBar.inputAccessoryView = toolbar;
    [self.searchBar setBackgroundImage:[UIImage new]];
    
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    
    // self.automaticallyAdjustsScrollViewInsets = YES;
}

- (void)dismissKeyboard:(UITapGestureRecognizer *) sender {
    [self.searchBar resignFirstResponder];
    NSLog(@"dismissKeyboard");
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

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [self.navigationController setNavigationBarHidden: NO animated:YES];
    // [UIView animateWithDuration:0.2 animations:^{
    //     // self.searchBar.frame.origin.y = 0.0
    // }]
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [self.navigationController setNavigationBarHidden: YES animated:YES];
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

// -(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//     if ([segue.identifier isEqualToString:@"showDetails"]) {
//         NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//         DetailsViewController *detailsVC = segue.destinationViewController;
//         // detailsVC.data
//     }
// }

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
    [self performSegueWithIdentifier:@"showDetails" sender:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 84.0;
}

@end
