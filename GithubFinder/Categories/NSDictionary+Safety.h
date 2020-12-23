//
//  NSDictionary+Category.h
//  GithubFinder
//
//  Created by Maksim Kalik on 12/23/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (Safety)

- (id)safeObjectForKey:(id)aKey;

@end

NS_ASSUME_NONNULL_END
