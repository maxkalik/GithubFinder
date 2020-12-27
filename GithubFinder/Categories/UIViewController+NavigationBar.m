//
//  UIViewController+NavigationBar.m
//  GithubFinder
//
//  Created by Maksim Kalik on 12/27/20.
//

#import "UIViewController+NavigationBar.h"

@implementation UIViewController (NavigationBar)

- (void)makeNavigationBarTransparent {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    
    CGRect statusBarFrame = [UIApplication sharedApplication].statusBarFrame;
    UIView *statusBarView = [[UIView alloc] initWithFrame:statusBarFrame];
    statusBarView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            statusBarView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        }
    }
    
    [self.view addSubview:statusBarView];
}

@end
