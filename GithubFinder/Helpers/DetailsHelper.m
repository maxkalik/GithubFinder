//
//  DetailsHelper.m
//  GithubFinder
//
//  Created by Maksim Kalik on 12/22/20.
//

#import "DetailsHelper.h"
#import "TypographyHelper.h"

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
        @"general": [NSArray arrayWithObjects: user.location, [[TypographyHelper sharedInstance] parseDateString:user.createdAt], user.name, user.login, nil],
        @"details": [NSArray arrayWithObjects: user.followers, user.following, user.publicRepos, user.publicGists, nil]
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

@end
