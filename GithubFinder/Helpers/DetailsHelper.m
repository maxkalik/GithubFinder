//
//  DetailsHelper.m
//  GithubFinder
//
//  Created by Maksim Kalik on 12/22/20.
//

#import "DetailsHelper.h"

@interface DetailsHelper ()

- (NSString *)parseDateString:(NSString *)dateString;

@end

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

- (NSArray<NSString *> *)prepareLabelTextFromUserData:(User *)user :(NSString *)labelGroup {
    NSDictionary *casesDict = @{
        @"general": [NSArray arrayWithObjects: user.name, user.login, user.location, [self parseDateString:user.createdAt], nil],
        @"details": [NSArray arrayWithObjects: user.publicRepos, user.publicGists, user.followers, user.following, nil]
    };
    return casesDict[labelGroup];
}

- (NSArray *)prepareLabelsContentWithTextArray:(NSArray<NSString *> *)text andLabels:(NSArray<UILabel *> *)labels {
    NSMutableArray *arrayWithLabels = [NSMutableArray arrayWithCapacity:4];
    for (int i = 0; i < text.count; i++) {
        UILabel *label = [labels objectAtIndex:i];
        label.text = [text objectAtIndex:i];
        [arrayWithLabels addObject:label];
    }
    return arrayWithLabels;
}

- (NSString *)parseDateString:(NSString *)dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:SSZ"];
    NSDate *date = [dateFormatter dateFromString:dateString];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];

    return [dateFormatter stringFromDate:date];
}

@end
