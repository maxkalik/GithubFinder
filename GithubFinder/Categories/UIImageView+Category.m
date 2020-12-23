//
//  UIImageView+UIImageView.m
//  GithubFinder
//
//  Created by Maksim Kalik on 12/22/20.
//

#import "UIImageView+Category.h"

@implementation UIImageView (Category)

-(void)loadFromUrl:(NSURL *)url {
    
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        // Main thread
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:spinner];
        [spinner startAnimating];
        spinner.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));

        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
            // Background Thread
            NSData *data = [NSData dataWithContentsOfURL:url];
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                // UI Updates
                self.image = [[UIImage alloc] initWithData:data];
                [spinner stopAnimating];
            });
        });
    });
}

@end
