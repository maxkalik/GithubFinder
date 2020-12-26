//
//  HomeTableView.m
//  GithubFinder
//
//  Created by Maksim Kalik on 12/26/20.
//

#import "HomeTableViewDataSource.h"
#import "HomeTableViewCell.h"

@interface HomeTableViewDataSource ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation HomeTableViewDataSource
@synthesize delegate;

- (id)initWithTableView:(UITableView *)tableView andData:(NSMutableArray<UserResponse *> *)data {
    self = [super init];
    if (self) {
        _tableView = tableView;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _data = data;
    }
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 100, 0);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"HomeTableViewCell"];
    return self;
}

- (void)updateTableViewData:(NSMutableArray *)data {
    _data = data;
    [self.tableView reloadData];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTableViewCell"];
    [cell configureWithUserResponse:[self.data objectAtIndex:indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSURL *url = [self.data objectAtIndex:indexPath.row].url;
    [self.delegate rowDidSelectWithUrl:url];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 84.0;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat actualPosition = scrollView.contentOffset.y;
    CGFloat contentHeight = scrollView.contentSize.height - self.tableView.frame.size.height;
    if (actualPosition >= contentHeight && contentHeight > 0) {
        [self.delegate scrollDidEnd];
    }
}

@end
