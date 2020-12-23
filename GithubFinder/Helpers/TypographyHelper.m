//
//  TypographyHelper.m
//  GithubFinder
//
//  Created by Maksim Kalik on 12/24/20.
//

#import "TypographyHelper.h"

@implementation TypographyHelper

- (instancetype)initPrivate {
    self = [super init];
    return self;
}

+ (instancetype)sharedInstance {
    static TypographyHelper *uniqueInstance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        uniqueInstance = [[TypographyHelper alloc] initPrivate];
    });
    
    return uniqueInstance;
}

- (NSMutableAttributedString *)makeLineHeight:(double)height forString:(NSString *)string {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = height;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedString.length)];
    return attributedString;
}

- (NSString *)parseDateString:(NSString *)dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:SSZ"];
    NSDate *date = [dateFormatter dateFromString:dateString];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];

    return [dateFormatter stringFromDate:date];
}

@end
