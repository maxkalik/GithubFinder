//
//  ViewController.m
//  GithubFinder
//
//  Created by Maksim Kalik on 12/21/20.
//

#import "HomeViewController.h"
#import "HTTPService.h"
#import "HomeTableViewDataSource.h"
#import "HomeSearchBar.h"

#import "DetailsViewController.h"
#import "NSDictionary+Safety.h"
#import "UserResponse.h"
#import "UIViewController+Alert.h"

#define ITEMS_PER_PAGE 50

@interface HomeViewController ()<HomeTableViewDataSourceDelegate, HomeSearchBarDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic, nullable) NSMutableArray<UserResponse *> *users;
@property (strong, nonatomic) UIActivityIndicatorView *spinner;

@property (strong, nonatomic) NSString *searchKeyword;

@property (nonatomic, assign) int currentPageNumber;
@property (nonatomic, assign) int pages;
@property (nonatomic, assign) BOOL isFetching;
@property (strong, nonatomic, nullable) NSNumber *totalDataItems;
@property (nonatomic, assign) int lastItems;

@property (nonatomic, strong, nullable) HomeTableViewDataSource *tableViewDataSource;
@property (nonatomic, strong, nullable) HomeSearchBar *homeSearchBar;

- (void)appendDataFromResponse:(NSDictionary *)dataDict;

@end


@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Github Finder";
    
    self.users = [[NSMutableArray alloc] init];
    
    self.tableViewDataSource = [[HomeTableViewDataSource alloc] initWithTableView:self.tableView andData:self.users];
    self.homeSearchBar = [[HomeSearchBar alloc] initWithSearchBar:self.searchBar];
    self.tableViewDataSource.delegate = self;
    self.homeSearchBar.delegate = self;
    
    // [self setupSearchBar];
    [self setupSpinner];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    
}

- (void)setupSpinner {
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview:self.spinner];
    self.spinner.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
}


- (void)dismissKeyboard:(UITapGestureRecognizer *) sender {
    [self.searchBar resignFirstResponder];
}

- (void)startLoading {
    [self.spinner startAnimating];
    self.isFetching = YES;
}

- (void)stopLoading {
    [self.spinner stopAnimating];
    self.isFetching = NO;
}

- (void)initialSearchDataFromDict: (NSDictionary *)dict {
    self.currentPageNumber = 2;
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
        [self fetchDataWithKeyword:self.searchKeyword onPageNumber:self.currentPageNumber];
    }
}

- (void)fetchDataWithKeyword:(NSString *)keyword onPageNumber:(int)pageNumber {
    NSLog(@"keyword: %@", keyword);
    [[HTTPService sharedInstance] fetchUsersByName:keyword fromPage:pageNumber withAmount:ITEMS_PER_PAGE :^(NSDictionary * _Nullable dataDict, NSString * _Nullable errorMessage) {
        if (dataDict) {
            if (pageNumber > 1) {
                [self repeatedSearchDataFromDict:dataDict];
            } else {
                self.searchKeyword = keyword;
                [self initialSearchDataFromDict:dataDict];
            }
        } else if (errorMessage) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self stopLoading];
                [self simpleAlertWithTitle:@"Error" withMessage:errorMessage :nil];
            });
        }
    }];
}

// MARK: - HomeSearchBarDelegate

- (void)searchbarDidChangeText:(NSString *)text {
    if (!text.length) {
        [self.users removeAllObjects];
        [self.tableView reloadData];
        [self stopLoading];
    } else {
        [self startLoading];
    }
}

- (void)searchBarBeginSearchingWithKeyword:(NSString *)keyword {
    if (keyword.length > 0) {
        [self fetchDataWithKeyword:keyword onPageNumber:1];
    }
}

- (void)searchBarTextDidBeginEditing {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)searchBarTextDidEndEditing {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

// MARK: - HomeTableViewDataSourceDelegate

- (void)rowDidSelectWithUrl:(nonnull NSURL *)url {
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
