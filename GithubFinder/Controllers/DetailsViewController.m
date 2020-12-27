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
#import "TypographyHelper.h"
#import "User.h"
#import "UIViewController+Alert.h"
#import "UIViewController+NavigationBar.h"

@interface DetailsViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;

@property (weak, nonatomic) IBOutlet UILabel *bioLabel;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *generalLabels;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *detailsLabels;

@property (strong, nonatomic) NSURL *userHtmlUrl;

@end

@implementation DetailsViewController

- (void)loadView
{
    [super loadView];
    UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 32, 20)];
    [backButton setImage:[UIImage imageNamed:@"back.png"]  forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(popVC) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
}

- (void) popVC{
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeNavigationBarTransparent];
    [self fetchData];
}

- (void)setScrollView:(UIScrollView *)scrollView {
    scrollView.delegate = self;
    if (@available(iOS 11.0, *)) {
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

- (void)fetchData {
    [[HTTPService sharedInstance] fetchUserInfoFromUrl:self.userUrl :^(NSDictionary * _Nullable dataDict, NSString * _Nullable errorMessage) {
        if (dataDict) {
            [self adjustContentFrom:dataDict];
        } else if (errorMessage) {
            [self simpleAlertWithTitle:@"Error" withMessage:errorMessage :nil];
        }
    }];
}

- (void)adjustContentFrom:(NSDictionary *)dict {
    User *user = [[User alloc] initWithDictionary:dict];
    self.userHtmlUrl = user.htmlUrl;
    [self.avatarImage loadFromUrl:user.avatarUrl];
    
    NSArray *generalLabelText = [[DetailsHelper sharedInstance] prepareLabelTextFromUserData:user :@"general"];
    NSArray *detailsLabelText = [[DetailsHelper sharedInstance] prepareLabelTextFromUserData:user :@"details"];
    
    dispatch_async(dispatch_get_main_queue(), ^(void){
        if (user.bio) { self.bioLabel.attributedText = [[TypographyHelper sharedInstance] makeLineHeight:4 forString:user.bio]; }
        self.generalLabels = [[DetailsHelper sharedInstance] prepareLabelsContentWithTextArray:generalLabelText andLabels:self.generalLabels];
        self.detailsLabels = [[DetailsHelper sharedInstance] prepareLabelsContentWithTextArray:detailsLabelText andLabels:self.detailsLabels];
    });
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.avatarImage.layer.transform = [[DetailsHelper sharedInstance] scaleImageViewOnScroll:self.avatarImage :scrollView];
}

- (IBAction)profileButtonTapped:(UIButton *)sender {
    [[UIApplication sharedApplication]openURL:self.userHtmlUrl];
}

@end
