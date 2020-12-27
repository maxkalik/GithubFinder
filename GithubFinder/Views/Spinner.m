//
//  Spinner.m
//  GithubFinder
//
//  Created by Maksim Kalik on 12/27/20.
//

#import "Spinner.h"

@interface Spinner ()

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation Spinner

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [self setup];
    }
    return self;
}

- (void)setup {
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
    self.activityIndicator.hidesWhenStopped = YES;
    self.hidden = YES;
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    self.layer.cornerRadius = 8;
    self.layer.masksToBounds = YES;
    self.activityIndicator.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    self.activityIndicator.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    
    if (self.superview) {
        self.frame = CGRectMake(0, 0, 54, 54);
        self.center = self.superview.center;
    }
}

- (void)show {
    self.hidden = NO;
}

- (void)hide {
    self.hidden = YES;
}

@end
