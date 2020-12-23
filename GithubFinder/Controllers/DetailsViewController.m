//
//  DetailsViewController.m
//  GithubFinder
//
//  Created by Maksim Kalik on 12/22/20.
//

#import "DetailsViewController.h"
#import "UIImageView+Category.h"
#import "HTTPService.h"
#import "DetailsHelper.h"
#import "User.h"

@interface DetailsViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;

@property (weak, nonatomic) IBOutlet UILabel *bioLabel;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *generalLabels;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *detailsLabels;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.scrollView.delegate = self;
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
            // Fallback on earlier versions
    }
    
    [[HTTPService sharedInstance] fetchReposFromUrl:self.userUrl :^(NSDictionary * _Nullable dataDict, NSString * _Nullable errorMessage) {
        
        User *user = [[User alloc] initWithDictionary:dataDict];
        
        // [self.avatarImage loadFromUrl:user.avatarUrl];
        [self.avatarImage loadFromUrl:user.avatarUrl :^{
            NSLog(@"complete");
            // loader complete
        }];

        NSArray *generalLabelText = [[DetailsHelper sharedInstance] prepareLabelTextFromUserData:user :@"general"];
        NSArray *detailsLabelText = [[DetailsHelper sharedInstance] prepareLabelTextFromUserData:user :@"details"];
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            self.bioLabel.text = user.bio;
            self.generalLabels = [[DetailsHelper sharedInstance] prepareLabelsContentWithTextArray:generalLabelText andLabels:self.generalLabels];
            self.detailsLabels = [[DetailsHelper sharedInstance] prepareLabelsContentWithTextArray:detailsLabelText andLabels:self.detailsLabels];
        });

    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.avatarImage.transform = [[DetailsHelper sharedInstance] transformImageView:self.avatarImage :scrollView];
}

@end
