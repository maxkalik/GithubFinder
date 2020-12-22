//
//  DetailsHelper.m
//  GithubFinder
//
//  Created by Maksim Kalik on 12/22/20.
//

#import "DetailsHelper.h"

@implementation DetailsHelper

- (instancetype)initPrivate {
    self = [super init];
    return self;
}

+ (instancetype)sharedInstance {
    static DetailsHelper *uniqueInstance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        uniqueInstance = [[DetailsHelper alloc] initPrivate];
    });
    
    return uniqueInstance;
}

- (CGAffineTransform)transformImageView:(UIImageView *)imageView :(UIScrollView *)scrollView {
    float scale = 1.0f + fabs(scrollView.contentOffset.y) / scrollView.frame.size.height;
    scale = MAX(0.0f, scale);
    CGAffineTransform transform = CGAffineTransformMakeScale(scale, scale);
    return transform;
}

@end
