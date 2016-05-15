//
//  GPRPageViewTitleCollectionViewCell.h
//  Pods
//
//  Created by anthann on 16/5/15.
//
//

#import <UIKit/UIKit.h>

@interface GPRPageViewTitleCollectionViewCell : UICollectionViewCell

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSDictionary *titleTextAttributes;
@property (copy, nonatomic) NSDictionary *selectedTitleTextAttributes;
@property (strong, nonatomic) UIColor *selectedIndicatorColor;
@property (assign, nonatomic) CGFloat indicatorHeight;

+ (CGFloat)minWidthToFitContent:(NSString *)title attribute:(NSDictionary *)attribute;

@end
