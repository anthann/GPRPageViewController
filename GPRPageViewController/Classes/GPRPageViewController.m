//
//  GPRPageViewController.m
//  Pods
//
//  Created by anthann on 16/5/15.
//
//

#import <Masonry/Masonry.h>

#import "GPRPageViewController.h"
#import "GPRPageViewTitleCollectionViewCell.h"

NSString * const titleCellReuseIdentifier = @"titleCellReuseIdentifier";

@interface GPRPageViewController() <UICollectionViewDelegate, UICollectionViewDataSource, UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (weak, nonatomic) UICollectionView *collectionView;
@property (weak, nonatomic) UIPageViewController *pageViewController;
@property (assign, nonatomic) CGFloat widthOfCell;

@property (copy, nonatomic) NSArray <NSString *>*titles;
@property (copy, nonatomic) NSArray <UIViewController *>*viewControllers;

@end

@implementation GPRPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _indicatorHeight = 3.0;
    _titleBarHeight = 40.0;
    _selectedIndicatorColor = [UIColor blueColor];
    _titleTextAttributes = @{
                             NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote],
                             NSForegroundColorAttributeName: [UIColor grayColor]
                             };
    _selectedTitleTextAttributes = @{
                                     NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote],
                                     NSForegroundColorAttributeName: [UIColor blueColor]
                                     };
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupViews];
}

- (void)didMoveToParentViewController:(UIViewController *)parent {
    [super didMoveToParentViewController:parent];
    [self reloadData];
}

- (void)setupViews {
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumInteritemSpacing = 0.0;
    flowLayout.minimumLineSpacing = 0.0;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
//    collectionView.pagingEnabled = YES;
    collectionView.alwaysBounceVertical = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.bounces = NO;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[GPRPageViewTitleCollectionViewCell class] forCellWithReuseIdentifier:titleCellReuseIdentifier];
    [self.view addSubview:_collectionView = collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(self.titleBarHeight);
    }];
    
    UIPageViewController *pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    pageViewController.dataSource = self;
    pageViewController.delegate = self;
    [self addChildViewController:_pageViewController = pageViewController];
    [self.view addSubview:pageViewController.view];
    [pageViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(collectionView.mas_bottom);
    }];
    [pageViewController didMoveToParentViewController:self];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GPRPageViewTitleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:titleCellReuseIdentifier forIndexPath:indexPath];
    cell.selectedIndicatorColor = self.selectedIndicatorColor;
    cell.titleTextAttributes = self.titleTextAttributes;
    cell.selectedTitleTextAttributes = self.selectedTitleTextAttributes;
    cell.title = self.titles[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.item;
    if (!self.pageViewController || index < 0 || index >= self.viewControllers.count) {
        return ;
    }
    UIPageViewControllerNavigationDirection direction;
    NSInteger currentIndex = [self currentPageIndex];
    if (index > currentIndex) {
        direction = UIPageViewControllerNavigationDirectionForward;
    } else {
        direction = UIPageViewControllerNavigationDirectionReverse;
    }
    [self.pageViewController setViewControllers:@[self.viewControllers[index]] direction:direction animated:YES completion:nil];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.widthOfCell, 40);
}

#pragma mark - UIPageViewControllerDelegate, UIPageViewControllerDataSource

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [self indexOfViewController:(UIViewController *)viewController];
    if (index <= 0 || index >= self.viewControllers.count) {
        return nil;
    }
    return self.viewControllers[index - 1];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [self indexOfViewController:(UIViewController *)viewController];
    if (index < 0 || index >= self.viewControllers.count - 1) {
        return nil;
    }
    return self.viewControllers[index + 1];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (!finished || !completed) {
        return;
    }
    NSInteger pageIndex = [self currentPageIndex];
    [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:pageIndex inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
}

- (NSInteger)currentPageIndex {
    UIViewController *currentViewController = [self.pageViewController.viewControllers objectAtIndex:0];
    NSInteger pageIndex = [self indexOfViewController:currentViewController];
    return pageIndex;
}

- (NSInteger)indexOfViewController:(UIViewController *)viewController {
    if ([self.viewControllers containsObject:viewController]) {
        return [self.viewControllers indexOfObject:viewController];
    } else {
        return -1;
    }
}

#pragma mark - Data

- (void)updateWidthOfCell {
    if (!self.titles || self.titles.count == 0) {
        self.widthOfCell = CGFLOAT_MIN;
        return;
    }
    NSInteger numOfTitles = self.titles.count;
    CGFloat maxWidth = CGFLOAT_MIN;
    for (NSString *title in self.titles) {
        CGFloat width = [GPRPageViewTitleCollectionViewCell minWidthToFitContent:title attribute:@{NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote]}];
        maxWidth = width > maxWidth ? width : maxWidth;
    }
    CGFloat selfWidth = CGRectGetWidth(self.view.bounds);
    while (numOfTitles * maxWidth > selfWidth && numOfTitles > 1) {
        numOfTitles -= 1;
    }
    self.widthOfCell = selfWidth / numOfTitles;
}

- (void)reloadData {
    __block NSArray *viewControllers = @[];
    __block NSArray *titles = @[];
    
    ^{
        if (!self.delegate) {
            return;
        }
        
        NSUInteger numOfPages = [self.delegate numOfPagesInPageViewController:self];
        if (numOfPages == 0) {
            return;
        }
        NSMutableArray *ts = [NSMutableArray array];
        NSMutableArray *vcs = [NSMutableArray array];
        
        for (NSUInteger i = 0; i < numOfPages; ++i) {
            NSString *title = [self.delegate pageViewController:self titleAtIndex:i];
            UIViewController *vc = [self.delegate pageViewController:self viewControllerAtIndex:i];
            if (title && vc) {
                [ts addObject:title];
                [vcs addObject:vc];
            } else {
                return;
            }
        }
        titles = [ts copy];
        viewControllers = [vcs copy];
    }();
    
    self.viewControllers = viewControllers;
    self.titles = titles;
    [self updateWidthOfCell];
    [self.collectionView reloadData];
    if (self.titles.count) {
        [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    }
    
    if (self.pageViewController) {
        if (self.viewControllers.firstObject) {
            [self.pageViewController setViewControllers:@[[self.viewControllers firstObject]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        } else {
            [self.pageViewController setViewControllers:@[[UIViewController new]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        }
    }
}

@end
