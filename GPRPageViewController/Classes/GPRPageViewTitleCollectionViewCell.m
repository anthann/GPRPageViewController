//
//  GPRPageViewTitleCollectionViewCell.m
//  Pods
//
//  Created by anthann on 16/5/15.
//
//

#import <Masonry/Masonry.h>

#import "GPRPageViewTitleCollectionViewCell.h"

@interface GPRPageViewTitleCollectionViewCell()

@property (weak, nonatomic) UILabel *label;
@property (weak, nonatomic) UIView *indicatorView;

@end

@implementation GPRPageViewTitleCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    UILabel *label = [UILabel new];
    [self.contentView addSubview:_label = label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView);
    }];
    
    UIView *indicatorView = [UIView new];
    [self.contentView addSubview:_indicatorView = indicatorView];
    [indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.mas_equalTo(self.indicatorHeight);
    }];
}

+ (CGFloat)minWidthToFitContent:(NSString *)title attribute:(NSDictionary *)attribute {
    return [[[NSAttributedString alloc] initWithString:title attributes:attribute] size].width + 10;
}

- (void)setTitle:(NSString *)title {
    _title = [title copy];
    [self updateTitle];
}

- (void)updateTitle {
    if (!self.title) {
        return;
    }
    if (self.isSelected) {
        self.label.attributedText = [[NSAttributedString alloc] initWithString:self.title attributes:self.selectedTitleTextAttributes];
        self.indicatorView.backgroundColor = self.selectedIndicatorColor;
    } else {
        self.label.attributedText = [[NSAttributedString alloc] initWithString:self.title attributes:self.titleTextAttributes];
        self.indicatorView.backgroundColor = [UIColor clearColor];
    }
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    [self updateTitle];
}

@end
