//
//  ViewController.m
//  GithubFinder
//
//  Created by Maksim Kalik on 12/21/20.
//

#import "HomeViewController.h"
#import "HTTPService.h"
#import "HomeTableViewDataSource.h"

#import "DetailsViewController.h"
#import "NSDictionary+Safety.h"
#import "UserResponse.h"
#import "UIViewController+Alert.h"

#define ITEMS_PER_PAGE 50

@interface HomeViewController ()<UISearchBarDelegate, HomeTableViewDataSourceDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic, nullable) NSMutableArray<UserResponse *> *users;
@property (strong, nonatomic, nullable) NSTimer *timer;
@property (strong, nonatomic) UIActivityIndicatorView *spinner;

@property (strong, nonatomic) NSString *searchKeyword;
@property (nonatomic, assign) int currentPageNumber;
@property (nonatomic, assign) int pages;
@property (nonatomic, assign) BOOL isFetching;
@property (strong, nonatomic, nullable) NSNumber *totalDataItems;
@property (nonatomic, assign) int lastItems;

@property (nonatomic, strong, nullable) HomeTableViewDataSource *tableViewDataSource;

- (void)appendDataFromResponse:(NSDictionary *)dataDict;

@end


@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Github Finder";
    
    // [self setupTableView];
    
    self.tableViewDataSource = [[HomeTableViewDataSource alloc] initWithTableView:self.tableView andData:self.users];
    self.tableViewDataSource.delegate = self;
    
    [self setupSearchBar];
    [self setupSpinner];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    self.users = [[NSMutableArray alloc] init];
}

- (void)setupSpinner {
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview:self.spinner];
    self.spinner.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
}

- (void)setupSearchBar {
    self.searchBar.delegate = self;
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self.searchBar action:@selector(resignFirstResponder)];
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolbar.items = [NSArray arrayWithObject:barButton];
    self.searchBar.inputAccessoryView = toolbar;
    
    self.searchBar.placeholder = @"Search Github User";
    [self.searchBar setBackgroundImage:[UIImage new]];
}

- (void)dismissKeyboard:(UITapGestureRecognizer *) sender {
    [self.searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if (!searchText.length) {
        self.users = nil;
        // [self.tableView reloadData];
        [self.tableViewDataSource reloadData];
    }
    
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    if (searchText.length > 0) {
        [self startLoading];
    }
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(searchForKeyword:) userInfo:searchText repeats:NO];
    
}

- (void)startLoading {
    [self.spinner startAnimating];
    self.isFetching = YES;
}

- (void)stopLoading {
    [self.spinner stopAnimating];
    self.isFetching = NO;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)searchForKeyword:(NSTimer *)timer {
    NSString *keyword = timer.userInfo;
    if (keyword.length > 0) {
        [self startLoading];
        [[HTTPService sharedInstance] fetchUsersByName:keyword fromPage:1 withAmount:ITEMS_PER_PAGE :^(NSDictionary * _Nullable dataDict, NSString * _Nullable errorMessage) {
            self.searchKeyword = keyword;
            if (dataDict) {
                [self initialSearchDataFromDict:dataDict];
            } else if (errorMessage) {
                [self stopLoading];
                [self simpleAlertWithTitle:@"Error" withMessage:errorMessage :nil];
            }
        }];
    }
}

- (void)initialSearchDataFromDict: (NSDictionary *)dict {
    self.currentPageNumber = 1;
    NSNumber *totalCount = [dict safeObjectForKey:@"total_count"];
    self.totalDataItems = totalCount;
    if (totalCount > 0) {
        self.pages = ceil((float)[totalCount intValue] / (float)ITEMS_PER_PAGE);
        if (self.users.count > 0) {  [self.users removeAllObjects]; }
        [self appendDataFromResponse:dict];
        [self updateTableView];
    }
}

- (void)updateTableView {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableViewDataSource updateTableViewData:self.users];
        [self stopLoading];
    });
}

- (void)appendDataFromResponse:(NSDictionary *)dataDict {
    NSMutableArray *items = [dataDict safeObjectForKey:@"items"];
    for (NSDictionary *item in items) {
        UserResponse *userResponse = [[UserResponse alloc] initWithDictionary:item];
        if (userResponse) {
            [self.users addObject:userResponse];
        }
    }
}

- (void)repeatedSearchDataFromDict:(NSDictionary *)dict {
    NSNumber *totalCount = [dict safeObjectForKey:@"total_count"];
    if (totalCount > 0) {
        [self appendDataFromResponse:dict];
        self.currentPageNumber++;
        [self updateTableView];
    }
}

- (void)fetchOnScrollDidEnd {
    if (self.pages >= self.currentPageNumber) {
        // NSLog(@"fetching..., page: %d", self.currentPageNumber);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [[HTTPService sharedInstance] fetchUsersByName:self.searchKeyword fromPage:self.currentPageNumber withAmount:ITEMS_PER_PAGE :^(NSDictionary * _Nullable dataDict, NSString * _Nullable errorMessage) {
                if (dataDict) {
                    [self repeatedSearchDataFromDict:dataDict];
                } else if (errorMessage) {
                    [self stopLoading];
                    [self simpleAlertWithTitle:@"Error" withMessage:errorMessage :nil];
                }
            }];
        });
    }
}

// MARK: - HomeTableViewDataSourceDelegate

- (void)rowDidSelectWithUrl:(nonnull NSURL *)url {
    NSLog(@"%@", url);
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailsViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
    vc.userUrl = url;
    [[self navigationController] pushViewController:vc animated:YES];
}

- (void)scrollDidEnd {
    [self startLoading];
    [self fetchOnScrollDidEnd];
}

@end
