//
//  HomeSearchBar.m
//  GithubFinder
//
//  Created by Maksim Kalik on 12/27/20.
//

#import "HomeSearchBar.h"

@interface HomeSearchBar ()<UISearchBarDelegate>

@property (strong, nonatomic, nullable) NSTimer *timer;

@end

@implementation HomeSearchBar

@synthesize delegate;

- (id)initWithSearchBar:(UISearchBar *)searchBar {
    self = [super init];
    if (self) {
        _searchBar = searchBar;
        _searchBar.delegate = self;
    }
    _searchBar.placeholder = @"Search Github User";
    [self setupDoneButton];
    return self;
}

- (void)setupDoneButton {
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self.searchBar action:@selector(resignFirstResponder)];
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolbar.items = [NSArray arrayWithObject:barButton];
    _searchBar.inputAccessoryView = toolbar;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(searchForKeyword:) userInfo:searchText repeats:NO];
    [self.delegate searchbarDidChangeText:searchText];
}

- (void)searchForKeyword:(NSTimer *)timer {
    NSString *keyword = timer.userInfo;
    [self.delegate searchBarBeginSearchingWithKeyword:keyword];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [self.delegate searchBarTextDidBeginEditing];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [self.delegate searchBarTextDidEndEditing];
}

@end
