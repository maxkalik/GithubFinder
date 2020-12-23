//
//  NSDictionary+Category.m
//  GithubFinder
//
//  Created by Maksim Kalik on 12/23/20.
//

#import "NSDictionary+Safety.h"

@implementation NSDictionary (Safety)

- (id)safeObjectForKey:(id)aKey {
    NSObject *object = self[aKey];
    
    if (object == [NSNull null]) {
        return nil;
    }
    
    return object;
}

@end
