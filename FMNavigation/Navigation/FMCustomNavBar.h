//
//  FMCustomNavBar.h
//  CeCeGotTalent
//
//  Created by wjy on 2018/9/23.
//

#import <UIKit/UIKit.h>

typedef void(^TargetAction)(void);

@interface FMCustomNavBar : UIView

@property (nonatomic, copy) UIColor *navBarBgColor;

@property (nonatomic, copy) NSString *navTitle;
@property (nonatomic, copy) UIColor *navMiddleTitleColor;
@property (nonatomic, copy) UIFont *navMiddleTitleFont;

- (void)configureLeftItem:(UIControl *)item action:(TargetAction)action;
- (void)configureMiddleItem:(UIView *)item;
- (void)configureRightItem:(UIControl *)item action:(TargetAction)action;

@end
