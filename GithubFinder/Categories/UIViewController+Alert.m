//
//  UIViewController+Alert.m
//  GithubFinder
//
//  Created by Maksim Kalik on 12/26/20.
//

#import "UIViewController+Alert.h"

@implementation UIViewController (Alert)

- (void)simpleAlertWithTitle:(NSString *)title withMessage :(NSString *)message :(nullable completion)completionHandler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:completionHandler];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
