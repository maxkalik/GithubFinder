//
//  HomeTableView.h
//  GithubFinder
//
//  Created by Maksim Kalik on 12/26/20.
//

#import <UIKit/UIKit.h>
#import "UserResponse.h"

NS_ASSUME_NONNULL_BEGIN

@class HomeTableViewDataSource;

@protocol HomeTableViewDataSourceDelegate <UITableViewDelegate>

- (void)rowDidSelectWithUrl:(NSURL *)url;
- (void)scrollDidEnd;

@end

@interface HomeTableViewDataSource : UITableView

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray<UserResponse *> * data;
@property (weak, nonatomic) id <HomeTableViewDataSourceDelegate> delegate;

- (id)initWithTableView:(UITableView *)tableView andData:(NSMutableArray *)data;
- (void)updateTableViewData:(NSMutableArray *)data;

@end

NS_ASSUME_NONNULL_END
