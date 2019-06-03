//
//  FMBaseViewController.h
//  Sample
//
//  Created by wjy on 2018/3/26.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMCustomNavBar.h"

@interface FMBaseViewController : UIViewController

@property (nonatomic, strong) FMCustomNavBar *customNavBar;  // default clearColor
@property (nonatomic, assign) BOOL invalidInteractivePopGesture; // default == NO

/**
 自定义导航（子类重写此方法，定制导航按钮）
 */
- (void)setUpNav;

@end
