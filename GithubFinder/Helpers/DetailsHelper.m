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

- (CATransform3D)scaleImageViewOnScroll:(UIImageView *)imageView :(UIScrollView *)scrollView {
    
    float offset = scrollView.contentOffset.y;
    
    if (offset < 0.0) {
        CATransform3D transform = CATransform3DTranslate(CATransform3DIdentity, 0, offset, 0);
        float scaleFactor = 1 + (-1 * offset / (imageView.frame.size.height / 2));
        transform = CATransform3DScale(transform, scaleFactor, scaleFactor, 1);
        return transform;
    } else {
        return CATransform3DIdentity;
    }
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
