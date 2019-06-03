//
//  TestViewController.m
//  FMNavigation
//
//  Created by wjy on 2019/6/3.
//  Copyright © 2019 wjy. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [self configureUI];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [self RandomColor];
}

#pragma mark - Private methods
- (void)configureUI
{
    /**
     subviews
     */
}

#pragma mark - Override methods
- (void)setUpNav
{
    [super setUpNav];
    if (!self.customNavBar.hidden) {
        self.customNavBar.navBarBgColor = [UIColor whiteColor];
    }
    /**
     重写 setUpNav，若不调用 super，即：重写导航（左item、中间item、右item）
     若调用 super，默认配置生效
     支持边缘右滑，可修改为 全屏右滑
     */
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    TestViewController *vc = [[TestViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

#pragma mark - Getter
- (UIColor *)RandomColor {
    NSInteger aRedValue =arc4random() %255;
    NSInteger aGreenValue =arc4random() %255;
    NSInteger aBlueValue =arc4random() %255;
    UIColor *randColor = [UIColor colorWithRed:aRedValue /255.f green:aGreenValue/255.f blue:aBlueValue /255.f alpha:1.0f];
    return randColor;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
