//
//  GPRPageViewController.h
//  Pods
//
//  Created by anthann on 16/5/15.
//
//

#import <UIKit/UIKit.h>

@class GPRPageViewController;
@protocol GPRPageViewControllerDelegate <NSObject>

- (NSUInteger)numOfPagesInPageViewController:(GPRPageViewController *)pageViewController;
- (UIViewController *)pageViewController:(GPRPageViewController *)pageViewController viewControllerAtIndex:(NSInteger)index;
- (NSString *)pageViewController:(GPRPageViewController *)pageViewController titleAtIndex:(NSInteger)index;

@end

@interface GPRPageViewController : UIViewController

@property (weak, nonatomic) id<GPRPageViewControllerDelegate>delegate;
@property (copy, nonatomic) NSDictionary *titleTextAttributes;
@property (copy, nonatomic) NSDictionary *selectedTitleTextAttributes;
@property (strong, nonatomic) UIColor *selectedIndicatorColor;
@property (assign, nonatomic) CGFloat indicatorHeight;
@property (assign, nonatomic) CGFloat titleBarHeight;

- (void)reloadData;

@end
