//
//  HomeSearchBar.h
//  GithubFinder
//
//  Created by Maksim Kalik on 12/27/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class HomeSearchBar;

@protocol HomeSearchBarDelegate <UISearchBarDelegate>

- (void)searchbarDidChangeText:(NSString *)text;
- (void)searchBarBeginSearchingWithKeyword:(NSString *)keyword;
- (void)searchBarTextDidBeginEditing;
- (void)searchBarTextDidEndEditing;

@end

@interface HomeSearchBar : UISearchBar

@property (strong, nonatomic) UISearchBar *searchBar;
@property (weak, nonatomic) id <HomeSearchBarDelegate> delegate;

- (id)initWithSearchBar:(UISearchBar *)searchBar;

@end

NS_ASSUME_NONNULL_END
