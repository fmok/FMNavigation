//
//  FMBaseViewController.m
//  Sample
//
//  Created by wjy on 2018/3/26.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "FMBaseViewController.h"
#import <Masonry/Masonry.h>

@interface FMBaseViewController ()<
    UIGestureRecognizerDelegate,
    UINavigationControllerDelegate>

@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UILabel *titleLab;  // default == SRGBCOLOR_HEX(0x222222)、UIFont:18
@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *interactiveEdgeGestureRecognizer;
//@property (nonatomic, strong) UIPanGestureRecognizer *interactiveEdgeGestureRecognizer;

@end

@implementation FMBaseViewController

- (void)dealloc
{
    NSLog(@"\n%@ --- %@\n", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
    if (!_invalidInteractivePopGesture) {
        self.interactiveEdgeGestureRecognizer.delegate = nil;
        self.interactiveEdgeGestureRecognizer = nil;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (![[self.navigationController.viewControllers lastObject] isKindOfClass:[FMBaseViewController class]]) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = SRGBCOLOR_HEX(0xf9f9f9);//[UIColor whiteColor];
    if (@available(iOS 11.0, *)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    // 初始化导航（默认配置）
    [self setNavInitialSetup];
    // 提供子类自定制导航方法（子类重写）
    [self setUpNav];
    // 添加边缘侧滑
    if (!_invalidInteractivePopGesture) {
        self.interactiveEdgeGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self.navigationController.interactivePopGestureRecognizer.delegate action:NSSelectorFromString(@"handleNavigationTransition:")];
        self.interactiveEdgeGestureRecognizer.edges = UIRectEdgeLeft;
        self.interactiveEdgeGestureRecognizer.delegate = self;
        [self.view addGestureRecognizer:self.interactiveEdgeGestureRecognizer];
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

#pragma mark - Private methods
- (void)setNavInitialSetup
{
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:nil];
    // custom Nav bar
    [self.view addSubview:self.customNavBar];
    [self.customNavBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.right.mas_equalTo(self.view);
        make.height.mas_equalTo(kNavBarAndStateHeight);
    }];
    self.customNavBar.navBarBgColor = [UIColor clearColor];
}

#pragma mark - Public methods
- (void)setUpNav
{
    WS(weakSelf);
    // back btn
    [self.customNavBar configureLeftItem:self.backBtn action:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    // title lab
    self.titleLab.text = self.title;
    [self.customNavBar configureMiddleItem:self.titleLab];
}

#pragma mark - Events
- (void)PopVC
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Override methods
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - getter
- (FMCustomNavBar *)customNavBar
{
    if (!_customNavBar) {
        _customNavBar = [[FMCustomNavBar alloc] initWithFrame:CGRectZero];
    }
    return _customNavBar;
}

- (UIButton *)backBtn
{
    if (!_backBtn) {
        _backBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_backBtn setImage:[UIImage imageNamed:@"FM_Back_Btn"] forState:UIControlStateNormal];
    }
    return _backBtn;
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLab.textColor = SRGBCOLOR_HEX(0x222222);
        _titleLab.font = [UIFont systemFontOfSize:18.f];
    }
    return _titleLab;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
