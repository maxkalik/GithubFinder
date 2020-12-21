//
//  ViewController.m
//  GithubFinder
//
//  Created by Maksim Kalik on 12/21/20.
//

#import "ViewController.h"
#import "HTTPService.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // [[HTTPService sharedInstance] test];
    [[HTTPService sharedInstance] fetchUsers];
    
}


@end
