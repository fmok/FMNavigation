//
//  FMCustomNavBar.m
//  CeCeGotTalent
//
//  Created by wjy on 2018/9/23.
//

#import "FMCustomNavBar.h"
#import <Masonry/Masonry.h>

@interface FMCustomNavBar()
{
    TargetAction leftAction;
    TargetAction middleAction;
    TargetAction rightAction;
    CGFloat gap_left_right;
}

@property (nonatomic, strong) UIControl *leftBlank;
@property (nonatomic, strong) UIControl *leftItem;
@property (nonatomic, strong) UIControl *rightBlank;
@property (nonatomic, strong) UIControl *rightItem;
@property (nonatomic, strong) UIView *middleItem;

@property (nonatomic, strong) UIView *bottomLine;

@end


@implementation FMCustomNavBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        gap_left_right = 15.f;
        [self addSubview:self.bottomLine];
        [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.bottom.mas_equalTo(self);
            make.height.mas_equalTo(.5f);
        }];
    }
    return self;
}

#pragma mark - Public methods
- (void)configureLeftItem:(UIControl *)item action:(TargetAction)action
{
    if (_leftItem) {
        [_leftItem removeFromSuperview];
        leftAction = nil;
    }
    if (item) {
        [self addSubview:self.leftBlank];
        [self.leftBlank mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(kNavStatusBarHeight);
            make.left.and.bottom.mas_equalTo(self);
            make.width.mas_equalTo(self->gap_left_right);
        }];
        if ([item isKindOfClass:[UIControl class]]) {
            item.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        } else if ([item isKindOfClass:[UIImageView class]]) {
            item.userInteractionEnabled = YES;
            item.contentMode = UIViewContentModeLeft;
        }
        self.leftItem = item;
        [self addSubview:self.leftItem];
        [self.leftItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(kNavStatusBarHeight);
            make.bottom.mas_equalTo(self);
            make.left.mas_equalTo(self.leftBlank.mas_right).offset(0.f);
            make.width.mas_equalTo(44.f);
        }];
    }
    if (action && [item isKindOfClass:[UIControl class]]) {
        leftAction = action;
        [self.leftBlank addTarget:self action:@selector(selLeftAction) forControlEvents:UIControlEventTouchUpInside];
        [self.leftItem addTarget:self action:@selector(selLeftAction) forControlEvents:UIControlEventTouchUpInside];
    } else if (action && [item isKindOfClass:[UIImageView class]]) {
        leftAction = action;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selLeftAction)];
        [self.leftBlank addGestureRecognizer:tap];
        [self.leftItem addGestureRecognizer:tap];
    }
}

- (void)configureMiddleItem:(UIView *)item
{
    if (_middleItem) {
        [_middleItem removeFromSuperview];
    }
    self.middleItem = item;
    [self addSubview:self.middleItem];
    [self.middleItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(kNavStatusBarHeight);
        make.centerX.mas_equalTo(self);
        make.height.mas_equalTo(kNavBarHeight);
        if (item.frame.size.width > 0) {
            make.width.mas_lessThanOrEqualTo(item.frame.size.width);
        }
    }];
}

- (void)configureRightItem:(UIControl *)item action:(TargetAction)action
{
    if (_rightItem) {
        [_rightItem removeFromSuperview];
        rightAction = nil;
    }
    if (item) {
        [self addSubview:self.rightBlank];
        [self.rightBlank mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(kNavStatusBarHeight);
            make.right.and.bottom.mas_equalTo(self);
            make.width.mas_equalTo(self->gap_left_right);
        }];
        if ([item isKindOfClass:[UIControl class]]) {
            item.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        } else if ([item isKindOfClass:[UIImageView class]]) {
            item.userInteractionEnabled = YES;
            item.contentMode = UIViewContentModeRight;
        }
        self.rightItem = item;
        [self addSubview:self.rightItem];
        [self.rightItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(kNavStatusBarHeight);
            make.right.mas_equalTo(self.rightBlank.mas_left).offset(0.f);
            make.size.mas_equalTo(CGSizeMake(CGRectGetWidth(item.frame), CGRectGetHeight(item.frame)));
        }];
    }
    if (action && [item isKindOfClass:[UIControl class]]) {
        rightAction = action;
        [self.rightItem addTarget:self action:@selector(selRightAction) forControlEvents:UIControlEventTouchUpInside];
    } else if (action && [item isKindOfClass:[UIImageView class]]) {
        rightAction = action;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selRightAction)];
        [self.rightBlank addGestureRecognizer:tap];
        [self.rightBlank addGestureRecognizer:tap];
    }
}

#pragma mark - Events
- (void)selLeftAction
{
    leftAction();
}

- (void)selRightAction
{
    rightAction();
}

#pragma mark - setter
- (void)setNavBarBgColor:(UIColor *)navBarBgColor
{
    self.backgroundColor = navBarBgColor;
    BOOL bottomLineHidden = (navBarBgColor == [UIColor clearColor]);
    self.bottomLine.hidden = bottomLineHidden;
}

- (void)setNavTitle:(NSString *)navTitle
{
    if (_middleItem && [_middleItem isKindOfClass:[UILabel class]]) {
        ((UILabel *)_middleItem).text = navTitle;
    }
}

- (void)setNavMiddleTitleColor:(UIColor *)navMiddleTitleColor
{
    if (_middleItem && [_middleItem isKindOfClass:[UILabel class]]) {
        ((UILabel *)_middleItem).textColor = navMiddleTitleColor;
    }
}

- (void)setNavMiddleTitleFont:(UIFont *)navMiddleTitleFont
{
    if (_middleItem && [_middleItem isKindOfClass:[UILabel class]]) {
        ((UILabel *)_middleItem).font = navMiddleTitleFont;
    }
}

#pragma mark - getter
- (UIControl *)leftBlank
{
    if (!_leftBlank) {
        _leftBlank = [[UIControl alloc] init];
    }
    return _leftBlank;
}

- (UIControl *)rightBlank
{
    if (!_rightBlank) {
        _rightBlank = [[UIControl alloc] init];
    }
    return _rightBlank;
}

- (UIControl *)leftItem
{
    if (!_leftItem) {
        _leftItem = [[UIControl alloc] initWithFrame:CGRectZero];
    }
    return _leftItem;
}

- (UIView *)middleItem
{
    if (!_middleItem) {
        _middleItem = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _middleItem;
}

- (UIControl *)rightItem
{
    if (!_rightItem) {
        _rightItem = [[UIControl alloc] initWithFrame:CGRectZero];
    }
    return _rightItem;
}

- (UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomLine.backgroundColor = SRGBCOLOR_HEX(0xEEEEEE);
    }
    return _bottomLine;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
