//
//  GPRViewController.m
//  GPRPageViewController
//
//  Created by anthann on 05/15/2016.
//  Copyright (c) 2016 anthann. All rights reserved.
//

#import <Masonry/Masonry.h>

#import "GPRPageViewController.h"
#import "GPRViewController.h"

@interface GPRViewController () <GPRPageViewControllerDelegate>

@property (weak, nonatomic) GPRPageViewController *pageViewController;

@end

@implementation GPRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupViews];
    
}

- (void)setupViews {
    GPRPageViewController *pageViewController = [GPRPageViewController new];
    pageViewController.titleBarBackgroundColor = [UIColor whiteColor];
    pageViewController.selectedIndicatorColor = [UIColor orangeColor];
    pageViewController.selectedTitleTextAttributes = @{
        NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote],
        NSForegroundColorAttributeName: [UIColor orangeColor]
    };
    pageViewController.delegate = self;
    [self addChildViewController:_pageViewController = pageViewController];
    [self.view addSubview:pageViewController.view];
    [pageViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
    }];
    [pageViewController didMoveToParentViewController:self];
}

- (NSUInteger)numOfPagesInPageViewController:(GPRPageViewController *)pageViewController {
    return arc4random() % 10;
}

- (UIViewController *)pageViewController:(GPRPageViewController *)pageViewController viewControllerAtIndex:(NSInteger)index {
    UIViewController *viewController = [UIViewController new];
    NSInteger red = arc4random() % 255;
    NSInteger green = arc4random() % 255;
    NSInteger blue = arc4random() % 255;
    viewController.view.backgroundColor = [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:1.0];
    return viewController;
}

- (NSString *)pageViewController:(GPRPageViewController *)pageViewController titleAtIndex:(NSInteger)index {
    return [NSString stringWithFormat:@"No. %lu", index];
}

- (IBAction)refresh:(id)sender {
    [self.pageViewController reloadData];
}

@end
